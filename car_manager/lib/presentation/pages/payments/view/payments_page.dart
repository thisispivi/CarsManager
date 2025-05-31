import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/inspection/inspection_section.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/insurance/insurance_section.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/tax/tax_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarManagerState>(
        builder: (context, carState, child) {
          final Car car = carState.car;

          final bool hasInspectionData =
              car.inspectionDatas != null && car.inspectionDatas!.isNotEmpty;

          final bool hasInsuranceData =
              car.insuranceDatas != null && car.insuranceDatas!.isNotEmpty;

          final bool hasTaxData =
              car.taxDatas != null && car.taxDatas!.isNotEmpty;

          final List<Widget> sections = [
            const SizedBox(height: 16),
            if (hasInsuranceData) InsuranceSection(car: car),
            const SizedBox(height: 50),
            if (hasInspectionData) InspectionSection(car: car),
            const SizedBox(height: 50),
            if (hasTaxData) TaxSection(car: car),
            const SizedBox(height: 16),
          ];

          return ListView(children: sections);
        },
      ),
    );
  }
}
