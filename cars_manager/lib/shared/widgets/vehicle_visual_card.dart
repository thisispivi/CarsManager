import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';

/// Stylized gradient hero card shown as a placeholder when a car has no photo.
/// Shows manufacturer, model, plate, and year/mileage in a warm gradient card.
class VehicleVisualCard extends StatelessWidget {
  const VehicleVisualCard({
    super.key,
    required this.car,
    this.height = 150,
    this.borderRadius = 18,
  });

  final Car car;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = _carColors(car);
    final initials = car.manufacture.length >= 2
        ? car.manufacture.substring(0, 2).toUpperCase()
        : car.manufacture.toUpperCase();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
        child: Stack(
          children: [
            // Radial highlight top-right
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.8, -0.8),
                    radius: 1.0,
                    colors: [
                      Colors.white.withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Diagonal line overlay
            Positioned.fill(
              child: CustomPaint(painter: _DiagonalLinesPainter()),
            ),
            // Badge circle bottom-right
            Positioned(
              right: -22,
              bottom: -22,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
              ),
            ),
            // Manufacturer initial badge
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.28),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.manufacture.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      height: 1,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    car.model,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      height: 1.1,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Plate chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          car.licensePlate.isEmpty ? '—' : car.licensePlate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${car.yearOfManufacture}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate a warm gradient pair from the car's id hash.
  static List<Color> _carColors(Car car) {
    final palettes = [
      [const Color(0xFF1B2B4B), const Color(0xFFE5734F)], // navy → coral
      [const Color(0xFF0F4A3A), const Color(0xFF2C8C72)], // forest → mint
      [const Color(0xFF4A1B1B), const Color(0xFFC04949)], // crimson → red
      [const Color(0xFF2B1B4B), const Color(0xFF8E5BC2)], // indigo → purple
      [const Color(0xFF1B3A4B), const Color(0xFF3D6FB5)], // navy → blue
      [const Color(0xFF3A2B1B), const Color(0xFFC9A227)], // brown → amber
    ];
    final idx = car.id.codeUnits.fold(0, (a, b) => a + b) % palettes.length;
    return palettes[idx];
  }
}

class _DiagonalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(-50, size.height * 0.9),
      Offset(size.width + 50, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(-50, size.height * 1.05),
      Offset(size.width + 50, size.height * 0.45),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
