import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';

class TotalCostCal extends StatelessWidget {
  const TotalCostCal({
    super.key,
    required this.consultationFee,
    required this.platformFee,
    required this.totalAmount,
  });

  final double consultationFee;
  final double platformFee;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TColors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TColors.grey,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Consultation Charge",
                style: TextStyle(
                    color: TColors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${consultationFee.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: TColors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Platform fee (incl. GST)",
                style: TextStyle(
                    color: TColors.black.withOpacity(0.4),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${platformFee.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: TColors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                    color: TColors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: TColors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

