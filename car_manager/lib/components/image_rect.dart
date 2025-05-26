import 'package:flutter/material.dart';

class ImageRect extends StatelessWidget {
  const ImageRect({
    super.key,
    required this.imageUrl,
    required this.imageAlignment,
    required this.aspectRatio,
    required this.backgroundColor,
    required this.borderRadius,
    required this.primaryColor,
  });

  final String? imageUrl;
  final Alignment? imageAlignment;
  final double aspectRatio;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image.network(
          imageUrl ?? "",
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: imageAlignment ?? Alignment.center,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: backgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  color: primaryColor,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: backgroundColor,
              child: Center(
                child: Icon(Icons.broken_image, size: 48, color: primaryColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
