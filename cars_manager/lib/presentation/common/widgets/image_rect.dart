import 'dart:convert';

import 'package:flutter/material.dart';

class ImageRect extends StatelessWidget {
  final String? imageUrl;
  final String? imageBase64;
  final Alignment? imageAlignment;
  final double aspectRatio;
  final Color backgroundColor;
  final BorderRadius borderRadius;
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
      return Image.memory(
        base64Decode(b64),
        width: double.infinity,
        fit: BoxFit.cover,
        alignment: imageAlignment ?? Alignment.center,
        errorBuilder: _buildErrorDisplay,
      );
    }

    return Image.network(
      imageUrl ?? "",
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
}
