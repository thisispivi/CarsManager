import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatefulWidget {
  const LoadingState({super.key, this.height, this.borderRadius});

  final double? height;
  final double? borderRadius;

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
    final radius = widget.borderRadius ?? AppRadius.md;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Container(
        height: widget.height ?? 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: [base, highlight, base],
            stops: [0.0, _animation.value, 1.0],
          ),
        ),
      ),
    );
  }
}
