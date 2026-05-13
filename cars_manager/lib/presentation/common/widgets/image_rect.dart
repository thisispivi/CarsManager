import 'dart:convert';

import 'package:flutter/material.dart';

/// Fixed-aspect image view that safely handles network and base64 failures.
///
/// Invalid base64 strings are caught and rendered as the same broken-image
/// state as failed network images instead of throwing during build.
class ImageRect extends StatelessWidget {
  /// Remote image URL used when no base64 image is available.
  final String? imageUrl;

  /// Base64-encoded image data. Corrupt values render the error display.
  final String? imageBase64;

  /// Focal alignment for cover-fitted images.
  final Alignment? imageAlignment;

  /// Aspect ratio reserved for the image.
  final double aspectRatio;

  /// Background color used while loading or after an error.
  final Color backgroundColor;

  /// Clipping radius for the image frame.
  final BorderRadius borderRadius;

  /// Accent color used for loaders and fallback icons.
  final Color primaryColor;

  const ImageRect({
    super.key,
    required this.imageUrl,
    this.imageBase64,
    required this.imageAlignment,
    required this.aspectRatio,
    required this.backgroundColor,
    required this.borderRadius,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: _buildImageWithErrorHandling(),
      ),
    );
  }

  Widget _buildImageWithErrorHandling() {
    final b64 = imageBase64;
    if (b64 != null && b64.trim().isNotEmpty) {
      try {
        final bytes = base64Decode(b64);
        return Image.memory(
          bytes,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: imageAlignment ?? Alignment.center,
          errorBuilder: _buildErrorDisplay,
        );
      } on FormatException {
        return _buildErrorContent();
      }
    }

    return Image.network(
      imageUrl ?? '',
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: imageAlignment ?? Alignment.center,
      loadingBuilder: _buildLoadingIndicator,
      errorBuilder: _buildErrorDisplay,
    );
  }

  Widget _buildLoadingIndicator(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return Container(
      color: backgroundColor,
      child: Center(
        child: CircularProgressIndicator(
          value: _calculateLoadingProgress(loadingProgress),
          color: primaryColor,
        ),
      ),
    );
  }

  double? _calculateLoadingProgress(ImageChunkEvent loadingProgress) {
    if (loadingProgress.expectedTotalBytes == null) return null;
    return loadingProgress.cumulativeBytesLoaded /
        loadingProgress.expectedTotalBytes!;
  }

  Widget _buildErrorDisplay(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Icon(Icons.broken_image, size: 48, color: primaryColor),
      ),
    );
  }

  Widget _buildErrorContent() {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Icon(Icons.broken_image, size: 48, color: primaryColor),
      ),
    );
  }
}
