import 'package:flutter/material.dart';

/// A widget that displays an image with a specified aspect ratio and handles
/// loading and error states gracefully.
///
/// This widget is commonly used for displaying car images throughout the app.
class ImageRect extends StatelessWidget {
  /// Creates an ImageRect widget.
  ///
  /// The [aspectRatio], [backgroundColor], [borderRadius], and [primaryColor]
  /// parameters are required.
  const ImageRect({
    super.key,
    required this.imageUrl,
    required this.imageAlignment,
    required this.aspectRatio,
    required this.backgroundColor,
    required this.borderRadius,
    required this.primaryColor,
  });

  /// The URL of the image to display.
  final String? imageUrl;

  /// The alignment of the image within its container.
  final Alignment? imageAlignment;

  /// The aspect ratio (width/height) to use for the image container.
  final double aspectRatio;

  /// The background color to show while loading or on error.
  final Color backgroundColor;

  /// The border radius for the corners of the image.
  final BorderRadius borderRadius;

  /// The primary color used for loading indicators and error icons.
  final Color primaryColor;

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

  /// Builds the image with proper loading and error handling.
  Widget _buildImageWithErrorHandling() {
    return Image.network(
      imageUrl ?? "",
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: imageAlignment ?? Alignment.center,
      loadingBuilder: _buildLoadingIndicator,
      errorBuilder: _buildErrorDisplay,
    );
  }

  /// Builds the loading indicator when the image is being loaded.
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

  /// Calculates the loading progress value for the progress indicator.
  double? _calculateLoadingProgress(ImageChunkEvent loadingProgress) {
    if (loadingProgress.expectedTotalBytes == null) return null;
    return loadingProgress.cumulativeBytesLoaded /
        loadingProgress.expectedTotalBytes!;
  }

  /// Builds the error display when the image fails to load.
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
