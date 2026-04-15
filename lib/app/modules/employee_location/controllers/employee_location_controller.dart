import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:bpr_pms/app/data/modules/employee_location/employee_location_service.dart';
import 'package:bpr_pms/app/data/modules/employee_location/models/employee_location_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class EmployeeLocationController extends GetxController {
  final EmployeeLocationService employeeLocationService = EmployeeLocationService();

  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();

  // Default center: Cirebon, Indonesia
  final Rx<LatLng> mapCenter = LatLng(-6.7320, 108.5523).obs;
  final RxDouble mapZoom = 13.0.obs;

  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isRequestingLocation = false.obs;
  final RxString message = ''.obs;

  final Rx<List<EmployeeLocationModel>> employeeLocations = Rx<List<EmployeeLocationModel>>([]);

  // Cache alamat geocoding agar tidak request berulang
  final RxMap<String, String> addressCache = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getLatestLocations(Get.context!, isInitialLoad: true);

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    debounce(searchQuery, (_) async {
      employeeLocations.value = [];
      await getLatestLocations(Get.context!, isInitialLoad: true);
    }, time: const Duration(milliseconds: 1000));
  }

  @override
  void onClose() {
    searchController.dispose();
    mapController.dispose();
    super.onClose();
  }

  List<Marker> get markers {
    return employeeLocations.value.map((employee) {
      if (employee.latitude == null || employee.longitude == null) return null;
      return Marker(
        point: LatLng(employee.latitude!, employee.longitude!),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      );
    }).whereType<Marker>().toList();
  }

  Future<void> refreshData(BuildContext context) async {
    employeeLocations.value = [];
    await getLatestLocations(context, isInitialLoad: true);
  }

  Future<void> getLatestLocations(BuildContext context, {bool isInitialLoad = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      message.value = '';

      final params = {
        'get_all': true,
        'include_relation': ['user'],
        'search': searchController.text.trim(),
      };

      final response = await employeeLocationService.latestLocation(params);

      isLoading.value = false;

      if (response.code == 200) {
        final newData = response.data ?? [];
        employeeLocations.value = newData;

        // Fit map ke semua marker jika ada data
        _fitMapToMarkers();

        // Geocode semua lokasi yang belum ada di cache
        for (var employee in newData) {
          if (employee.latitude != null && employee.longitude != null) {
            final key = '${employee.latitude},${employee.longitude}';
            if (!addressCache.containsKey(key)) {
              _reverseGeocode(employee.latitude!, employee.longitude!);
            }
          }
        }

        message.value = "Data lokasi karyawan berhasil diambil!";
      } else {
        String errorMsg = response.message ?? "Data lokasi karyawan gagal diambil. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }

  void _fitMapToMarkers() {
    final validLocations = employeeLocations.value
        .where((e) => e.latitude != null && e.longitude != null)
        .toList();

    if (validLocations.isEmpty) return;

    if (validLocations.length == 1) {
      final loc = validLocations.first;
      try {
        mapController.move(LatLng(loc.latitude!, loc.longitude!), 16.0);
      } catch (_) {}
      return;
    }

    try {
      double minLat = validLocations.first.latitude!;
      double maxLat = validLocations.first.latitude!;
      double minLng = validLocations.first.longitude!;
      double maxLng = validLocations.first.longitude!;

      for (var loc in validLocations) {
        if (loc.latitude! < minLat) minLat = loc.latitude!;
        if (loc.latitude! > maxLat) maxLat = loc.latitude!;
        if (loc.longitude! < minLng) minLng = loc.longitude!;
        if (loc.longitude! > maxLng) maxLng = loc.longitude!;
      }

      final bounds = LatLngBounds(
        LatLng(minLat, minLng),
        LatLng(maxLat, maxLng),
      );

      mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(50),
        ),
      );
    } catch (_) {}
  }

  Future<void> _reverseGeocode(double lat, double lng) async {
    final key = '$lat,$lng';
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final parts = <String>[
          if (place.street != null && place.street!.isNotEmpty) place.street!,
          if (place.subLocality != null && place.subLocality!.isNotEmpty) place.subLocality!,
          if (place.locality != null && place.locality!.isNotEmpty) place.locality!,
          if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) place.subAdministrativeArea!,
          if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) place.administrativeArea!,
        ];
        addressCache[key] = parts.isNotEmpty ? parts.join(', ') : 'Alamat tidak ditemukan';
      } else {
        addressCache[key] = 'Alamat tidak ditemukan';
      }
    } catch (e) {
      addressCache[key] = 'Gagal memuat alamat';
    }
  }

  String getAddress(EmployeeLocationModel employee) {
    if (employee.latitude == null || employee.longitude == null) return '-';
    final key = '${employee.latitude},${employee.longitude}';
    return addressCache[key] ?? 'Memuat alamat...';
  }

  void focusOnEmployee(EmployeeLocationModel employee) {
    if (employee.latitude == null || employee.longitude == null) return;
    mapController.move(LatLng(employee.latitude!, employee.longitude!), 16.0);
  }

  void showRequestLocationConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.my_location, color: MainColor.blue1),
              const SizedBox(width: 8),
              const Text('Konfirmasi'),
            ],
          ),
          content: const Text(
            'Apakah Anda yakin ingin meminta lokasi terbaru dari semua karyawan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Batal',
                style: TextStyle(color: SecondaryColor.neutral500),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                requestLatestLocation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColor.blue1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Ya, Minta Lokasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> requestLatestLocation(BuildContext context) async {
    try {
      isRequestingLocation.value = true;

      CustomSnackbar(message: 'Mengirim permintaan lokasi...', type: CustomSnackbarType.loading).show(context);

      final response = await employeeLocationService.requestAllLocation();

      isRequestingLocation.value = false;
      CustomSnackbar.dismiss();

      if (response.code == 200) {
        CustomSnackbar(
          message: response.message ?? 'Permintaan lokasi terbaru telah dikirim',
          type: CustomSnackbarType.success,
        ).show(context);
      } else {
        CustomSnackbar(
          message: response.message ?? 'Gagal mengirim permintaan lokasi',
          type: CustomSnackbarType.warning,
        ).show(context);
      }
    } catch (e) {
      isRequestingLocation.value = false;
      CustomSnackbar.dismiss();
      CustomSnackbar(
        message: 'Terjadi kesalahan: ${e.toString()}',
        type: CustomSnackbarType.error,
      ).show(context);
    }
  }
}
