import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderOverlay {
  static OverlayEntry? _overlayEntry;

  // Show full-screen loader with custom Lottie and message
  static void show({
    required BuildContext context,
    String lottieAsset = 'assets/lottie/default_loader.json', // Default
    String message = 'Processing...',
  }) {
    if (_overlayEntry != null) return; // Prevent duplicates

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                lottieAsset,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                repeat: true,
              ),
              const SizedBox(height: 24),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // Hide the loader
  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
