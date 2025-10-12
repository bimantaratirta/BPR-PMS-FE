import 'dart:io';

import 'package:bpr_pms/app/data/modules/report/report_service.dart';
import 'package:dio/dio.dart';
import 'package:bpr_pms/app/data/modules/customer/models/customer_model.dart';
import 'package:bpr_pms/app/widgets/build_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class NasabahNasabahCreateReportController extends GetxController {
  final ReportService reportService = ReportService();

  final RxString id = ''.obs;
  final isLoading = false.obs;
  final RxString message = ''.obs;
  final isFormValid = false.obs;
  final Rx<CustomerModel?> customerData = Rx<CustomerModel?>(null);

  Rx<List<String>> evaluationList = Rx<List<String>>(['Good', 'Bad']);
  Rx<String?> pickEvaluation = Rx<String?>(null);
  void usePickEvaluation(String value) {
    pickEvaluation.value = value;
    _updateFormValid();
  }

  final RxList<File> selectedPhotos = <File>[].obs;
  final int maxPhotos = 5;

  void showImageSourceDialog(BuildContext context) {
    if (selectedPhotos.length >= maxPhotos) {
      CustomSnackbar(message: 'Maksimal $maxPhotos foto telah diunggah.', type: CustomSnackbarType.warning).show(context);
      return;
    }

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    if (selectedPhotos.length >= maxPhotos) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedPhotos.add(File(pickedFile.path));
      _updateFormValid();
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < selectedPhotos.length) {
      selectedPhotos.removeAt(index);
      _updateFormValid();
    }
  }

  void _updateFormValid() {
    isFormValid.value = pickEvaluation.value != null && selectedPhotos.isNotEmpty;
  }

  Future createCustomerReport(BuildContext context) async {
    try {
      isLoading.value = true;
      message.value = '';

      final List<MultipartFile> imageFiles = [];
      for (var file in selectedPhotos) {
        String? mimeType;
        final extension = path.extension(file.path).toLowerCase();

        switch (extension) {
          case '.jpg':
          case '.jpeg':
            mimeType = 'image/jpeg';
            break;
          case '.png':
            mimeType = 'image/png';
            break;
          case '.gif':
            mimeType = 'image/gif';
            break;
          case '.webp':
            mimeType = 'image/webp';
            break;
          default:
            mimeType = 'image/jpeg'; // fallback
        }

        imageFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      final payload = FormData.fromMap({
        'customer_id': id.value,
        'status': pickEvaluation.value == 'Good'
            ? "GOOD"
            : pickEvaluation.value == 'Bad'
            ? "BAD"
            : "",
        'images': imageFiles,
      });

      final response = await reportService.createReport(payload);

      isLoading.value = false;

      if (response.code == 200 || response.code == 201) {
        message.value = "Laporan berhasil dibuat!";
        CustomSnackbar(message: message.value, type: CustomSnackbarType.success).show(context);
      } else {
        String errorMsg = response.message ?? "Laporan gagal dibuat. Silakan coba lagi.";
        message.value = errorMsg;
        CustomSnackbar(message: errorMsg, type: CustomSnackbarType.warning).show(context);
      }
    } catch (e) {
      isLoading.value = false;
      message.value = e.toString();
      CustomSnackbar(message: message.value, type: CustomSnackbarType.error).show(context);
    }
  }
}
