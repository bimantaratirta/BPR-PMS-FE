import 'dart:async';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../common/constant/assets.dart';

enum CustomSnackbarType { success, warning, error, loading }

class CustomSnackbar {
  final String message;
  final CustomSnackbarType type;

  static final _overlayDuration = const Duration(seconds: 2);
  static OverlayEntry? _currentOverlay;

  CustomSnackbar({required this.message, required this.type});

  void show(BuildContext context) {
    // Dismiss snackbar sebelumnya jika ada
    _currentOverlay?.remove();
    _currentOverlay = null;

    final overlay = OverlayEntry(
      builder: (context) => _SnackbarOverlay(message: message, type: type, onDismissed: () => _currentOverlay = null),
    );

    _currentOverlay = overlay;

    Overlay.of(context).insert(overlay);
  }

  static void dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _SnackbarOverlay extends StatefulWidget {
  final String message;
  final CustomSnackbarType type;
  final VoidCallback onDismissed;

  const _SnackbarOverlay({required this.message, required this.type, required this.onDismissed});

  @override
  State<_SnackbarOverlay> createState() => _SnackbarOverlayState();
}

class _SnackbarOverlayState extends State<_SnackbarOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _autoHideTimer; // Tambahkan timer reference

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..forward();

    if (widget.type != CustomSnackbarType.loading) {
      _autoHideTimer = Timer(CustomSnackbar._overlayDuration, () {
        _hide();
      });
    }
  }

  void _hide() {
    if (!mounted) return; // Check if widget is still mounted

    _controller.reverse().then((_) {
      widget.onDismissed();
      if (mounted) {
        Overlay.of(context).setState(() {}); // force rebuild to remove
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String? icon;
    switch (widget.type) {
      case CustomSnackbarType.success:
        icon = IconAssets.success;
        break;
      case CustomSnackbarType.warning:
        icon = IconAssets.warning;
        break;
      case CustomSnackbarType.error:
        icon = IconAssets.danger;
        break;
      case CustomSnackbarType.loading:
        icon = null;
        break;
    }

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.03,
      left: 0,
      right: 0,
      child: IgnorePointer(
        // Tambahkan ini agar tidak menghalangi interaksi
        ignoring: widget.type != CustomSnackbarType.loading, // Hanya loading yang menghalangi
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: FadeTransition(
              opacity: _controller,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(color: SecondaryColor.blackCharcoal, borderRadius: BorderRadius.circular(50)),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.type == CustomSnackbarType.loading)
                      SpinKitFadingCircle(color: SecondaryColor.white, size: 25.w)
                    else
                      SvgPicture.asset(icon!, width: 25.w),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.labelMedium!.copyWith(color: SecondaryColor.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel(); // Cancel timer sebelum dispose
    _controller.dispose();
    super.dispose();
  }
}
