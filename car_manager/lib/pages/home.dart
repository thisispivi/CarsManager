import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/image_rect.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Consumer<CarManagerState>(
                builder: (context, carState, child) {
                  return CarCard(car: carState.car);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      color: Theme.of(context).cardColor,
      elevation: 3,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageRect(
              imageUrl: car.imageUrl,
              imageAlignment: car.imageAlignment,
              aspectRatio: 16 / 9,
              backgroundColor: Theme.of(
                context,
              ).navigationBarTheme.backgroundColor!,
              borderRadius: BorderRadius.circular(12),
              primaryColor: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.model,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(AppLocalizations.of(context)!.bodySpecs_weight),
                  Text('Year: ${car.yearOfManufacture}'),
                  Text('License Plate: ${car.licensePlate}'),
                  if (car.inspectionDatas != null &&
                      car.inspectionDatas!.isNotEmpty)
                    ...car.inspectionDatas!.map((inspection) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${inspection.date.toLocal()} - ${inspection.isPassed ? 'Passed' : 'Failed'}',
                          ),
                          if (inspection.amount != null)
                            Text(
                              'Amount: \$${inspection.amount!.toStringAsFixed(2)}',
                            ),
                          if (inspection.mileage != null)
                            Text('Mileage: ${inspection.mileage} km'),
                          SizedBox(height: 8),
                        ],
                      );
                    }),
                  if (car.inspectionDatas != null &&
                      car.inspectionDatas!.isNotEmpty)
                    Text(
                      'Next Inspection: ${car.getNextInspectionDate()?.toLocal()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  if (car.inspectionDatas != null &&
                      car.inspectionDatas!.isNotEmpty)
                    Text(
                      'Days until next inspection: ${car.getDaysUntilNextInspection()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
