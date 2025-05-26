import 'package:car_manager/components/image_rect.dart';
import 'package:car_manager/components/section_header.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/body_specs.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/models/engine_specs.dart';
import 'package:car_manager/models/fuel_consumption.dart';
import 'package:car_manager/models/performance_specs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../extensions/engine_specs_extensions.dart';

class CarStatsPage extends StatelessWidget {
  const CarStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarManagerState>(
        builder: (context, carState, child) {
          final Car car = carState.car;

          final List<Widget Function()> sections = [
            () => const SizedBox(height: 16),
            () => CarHeader(car: car),
            () => const SizedBox(height: 45),
            () => CarDataBlock(car: car),
            () => const SizedBox(height: 45),
            () => BodySpecsBlock(bodySpecs: car.bodySpecs),
            () => const SizedBox(height: 45),
            () => EngineSpecsBlock(engineSpecs: car.engineSpecs),
            () => const SizedBox(height: 45),
            () => PerformanceSpecsBlock(performanceSpecs: car.performanceSpecs),
            () => const SizedBox(height: 45),
            () => FuelConsumptionBlock(fuelConsumption: car.fuelConsumption),
            () => const SizedBox(height: 45),
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
                value: car.manufacture.name,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_model,
                value: car.model,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_setUp,
                value: car.setUp,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_licensePlate,
                value: car.licensePlate,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.carData_originalPrice,
                value: car.originalPrice != null
                    ? AppLocalizations.of(context)!.unit_currency(
                        NumberFormat("#,###").format(car.originalPrice!),
                        "€",
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(
                  context,
                )!.carData_productionRangeYears,
                value:
                    car.productionStartYear != null &&
                        car.productionEndYear != null
                    ? "${car.productionStartYear} - ${car.productionEndYear}"
                    : "-",
              ),
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

class BodySpecsBlock extends StatelessWidget {
  final BodySpecs? bodySpecs;

  const BodySpecsBlock({super.key, required this.bodySpecs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppLocalizations.of(context)!.bodySpecs_title,
          icon: Icon(
            Icons.directions_car_outlined,
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
                label: AppLocalizations.of(context)!.bodySpecs_type,
                value: bodySpecs?.type,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_doors,
                value: bodySpecs?.doors,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_seats,
                value: bodySpecs?.seats,
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_trunkCapacity,
                value: bodySpecs?.trunkCapacity != null
                    ? '${bodySpecs!.trunkCapacity} ${AppLocalizations.of(context)!.unit_dm3("")}'
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_fuelTankCapacity,
                value: bodySpecs?.fuelTankCapacity != null
                    ? AppLocalizations.of(context)!.unit_l(
                        NumberFormat(
                          "#,###",
                        ).format(bodySpecs!.fuelTankCapacity),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_weight,
                value: bodySpecs?.weight != null
                    ? AppLocalizations.of(context)!.unit_kg(
                        NumberFormat("#,###").format(bodySpecs!.weight),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_maxTowingWeight,
                value: bodySpecs?.maxTowingWeight != null
                    ? AppLocalizations.of(context)!.unit_kg(
                        NumberFormat(
                          "#,###",
                        ).format(bodySpecs!.maxTowingWeight),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_length,
                value: bodySpecs?.length != null
                    ? AppLocalizations.of(context)!.unit_m(
                        NumberFormat("#,##0.00").format(bodySpecs!.length),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_width,
                value: bodySpecs?.width != null
                    ? AppLocalizations.of(context)!.unit_m(
                        NumberFormat("#,##0.00").format(bodySpecs!.width),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_height,
                value: bodySpecs?.height != null
                    ? AppLocalizations.of(context)!.unit_m(
                        NumberFormat("#,##0.00").format(bodySpecs!.height),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.bodySpecs_wheelbase,
                value: bodySpecs?.wheelbase != null
                    ? AppLocalizations.of(context)!.unit_m(
                        NumberFormat("#,##0.00").format(bodySpecs!.wheelbase),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
            ],
          ),
        ),
      ],
    );
  }
}

class EngineSpecsBlock extends StatelessWidget {
  final EngineSpecs? engineSpecs;

  const EngineSpecsBlock({super.key, required this.engineSpecs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppLocalizations.of(context)!.engineSpecs_title,
          icon: SvgPicture.asset(
            "assets/icons/engine.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_type,
                value: engineSpecs?.type != null
                    ? engineSpecs!.type!.localized(
                        AppLocalizations.of(context)!,
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_displacement,
                value: engineSpecs?.displacement != null
                    ? AppLocalizations.of(context)!.unit_cc(
                        NumberFormat("#,###").format(engineSpecs!.displacement),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_fuelType,
                value: engineSpecs?.fuelType != null
                    ? engineSpecs!.fuelType!.localized(
                        AppLocalizations.of(context)!,
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_maxPower,
                value: engineSpecs?.maxPower != null
                    ? AppLocalizations.of(
                        context,
                      )!.unit_kw(engineSpecs!.maxPower.toString())
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_horsePower,
                value: engineSpecs?.horsePower != null
                    ? AppLocalizations.of(
                        context,
                      )!.unit_hp(engineSpecs!.horsePower.toString())
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_engineSpeed,
                value: engineSpecs?.engineSpeed != null
                    ? AppLocalizations.of(
                        context,
                      )!.unit_rpm(engineSpecs!.engineSpeed.toString())
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_maxTorque,
                value: engineSpecs?.maxTorque != null
                    ? AppLocalizations.of(
                        context,
                      )!.unit_nm(engineSpecs!.maxTorque.toString())
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_driveType,
                value: engineSpecs?.driveType != null
                    ? engineSpecs!.driveType!.localized(
                        AppLocalizations.of(context)!,
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(
                  context,
                )!.engineSpecs_transmissionType,
                value: engineSpecs?.transmissionType != null
                    ? engineSpecs!.transmissionType!.localized(
                        AppLocalizations.of(context)!,
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.engineSpecs_gears,
                value: engineSpecs?.gears != null
                    ? engineSpecs!.gears.toString()
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
            ],
          ),
        ),
      ],
    );
  }
}

class PerformanceSpecsBlock extends StatelessWidget {
  final PerformanceSpecs? performanceSpecs;

  const PerformanceSpecsBlock({super.key, required this.performanceSpecs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppLocalizations.of(context)!.performanceSpecs_title,
          icon: SvgPicture.asset(
            "assets/icons/speedometer.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.performanceSpecs_maxSpeed,
                value: performanceSpecs?.maxSpeed != null
                    ? AppLocalizations.of(
                        context,
                      )!.unit_kmh(performanceSpecs!.maxSpeed.toString())
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(
                  context,
                )!.performanceSpecs_zeroToHundred,
                value: performanceSpecs?.zeroToHundred != null
                    ? "${performanceSpecs!.zeroToHundred} s"
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(
                  context,
                )!.performanceSpecs_co2Emissions,
                value: performanceSpecs?.co2Emissions != null
                    ? AppLocalizations.of(context)!.unit_l_per_100km(
                        performanceSpecs!.co2Emissions.toString(),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(
                  context,
                )!.performanceSpecs_emissionStandard,
                value: performanceSpecs?.emissionStandard ?? "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
            ],
          ),
        ),
      ],
    );
  }
}

class FuelConsumptionBlock extends StatelessWidget {
  final FuelConsumption? fuelConsumption;

  const FuelConsumptionBlock({super.key, required this.fuelConsumption});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppLocalizations.of(context)!.fuelConsumption_title,
          icon: Icon(
            Icons.local_gas_station_outlined,
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
                label: AppLocalizations.of(context)!.fuelConsumption_urban,
                value: fuelConsumption?.urban != null
                    ? AppLocalizations.of(context)!.unit_l_per_100km(
                        NumberFormat("#,##0.0").format(fuelConsumption!.urban),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.fuelConsumption_extraUrban,
                value: fuelConsumption?.extraUrban != null
                    ? AppLocalizations.of(context)!.unit_l_per_100km(
                        NumberFormat(
                          "#,##0.0",
                        ).format(fuelConsumption!.extraUrban),
                      )
                    : "-",
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              DataRow(
                label: AppLocalizations.of(context)!.fuelConsumption_combined,
                value: fuelConsumption?.combined != null
                    ? AppLocalizations.of(context)!.unit_l_per_100km(
                        NumberFormat(
                          "#,##0.0",
                        ).format(fuelConsumption!.combined),
                      )
                    : "-",
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
