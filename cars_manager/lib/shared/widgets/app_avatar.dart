import 'dart:convert';

import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.name,
    this.imageBase64,
    this.size = 40,
  });

  final String name;
  final String? imageBase64;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(name);

    return ClipOval(
      child: SizedBox.square(
        dimension: size,
        child: imageBase64 != null && imageBase64!.isNotEmpty
            ? _ImageAvatar(imageBase64: imageBase64!, size: size)
            : _InitialsAvatar(initials: initials, size: size),
      ),
    );
  }

  String _initials(String name) {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '?';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}

class _ImageAvatar extends StatelessWidget {
  const _ImageAvatar({required this.imageBase64, required this.size});

  final String imageBase64;
  final double size;

  @override
  Widget build(BuildContext context) {
    try {
      final bytes = base64Decode(imageBase64);
      return Image.memory(
        bytes,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _InitialsAvatar(initials: '?', size: size),
      );
    } catch (_) {
      return _InitialsAvatar(initials: '?', size: size);
    }
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials, required this.size});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.brandPrimary.withValues(alpha: 0.15),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppColors.brandPrimary,
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
