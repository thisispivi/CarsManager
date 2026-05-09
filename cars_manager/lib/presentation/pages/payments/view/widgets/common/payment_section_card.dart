import 'package:cars_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';

class PaymentSectionCard extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Widget? trailing;
  final Widget? nextInfoDue;
  final double? verticalSpacing;
  final List<Widget> items;
  static const double horizontalPadding = 16.0;

  const PaymentSectionCard({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.nextInfoDue,
    required this.items,
    this.verticalSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            horizontalPadding: horizontalPadding,
            title: title,
            icon: icon,
            trailing: trailing,
          ),
          SizedBox(height: verticalSpacing ?? 24),
          ?nextInfoDue,
          if (nextInfoDue != null) SizedBox(height: verticalSpacing ?? 24),
          ...items,
        ],
      ),
    );
  }
}
