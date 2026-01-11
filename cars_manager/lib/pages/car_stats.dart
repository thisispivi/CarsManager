import '../main.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarStatsPage extends StatelessWidget {
  const CarStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarsManagerState>(
        builder: (context, carState, child) {
          final Car? car = carState.activeCar;
          if (car == null) {
            final l10n = AppLocalizations.of(context)!;
            return Center(
              child: Text(
                l10n.stats_selectCarHint,
                style: GoogleFonts.spaceGrotesk().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }

          final List<Widget Function()> sections = [
            () => const SizedBox(height: 16),
            () => CarHeader(car: car),
            () => const SizedBox(height: 45),
            () => CarDataBlock(car: car),
          ];

          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) => sections[index](),
          );
        },
      ),
    );
  }
}

class CarHeader extends StatelessWidget {
  final Car car;

  const CarHeader({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            car.name,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: ImageRect(
            imageUrl: car.imageUrl,
            imageAlignment: car.imageAlignment,
            aspectRatio: 16 / 9,
            backgroundColor: Theme.of(
              context,
            ).navigationBarTheme.backgroundColor!,
            borderRadius: BorderRadius.circular(12),
            primaryColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class CarDataBlock extends StatelessWidget {
  final Car car;

  const CarDataBlock({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          horizontalPadding: 32,
          title: AppLocalizations.of(context)!.carData_title,
          icon: Icon(
            Icons.info_outline,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_manufacture,
                value: car.manufacture,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_model,
                value: car.model,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_licensePlate,
                value: car.licensePlate,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_yearOfManufacture,
                value: car.yearOfManufacture,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
            ],
          ),
        ),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  const DataRow({super.key, required this.label, required this.value});

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final displayValue = value?.toString() ?? "-";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: GoogleFonts.spaceGrotesk(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
