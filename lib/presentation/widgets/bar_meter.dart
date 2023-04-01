import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kBarWidth = 8.0;

/// A widget that displays a tone analysis as a bar chart.
class BarMeter extends StatelessWidget {
  final int rate;
  final int maxRate;
  final double width;

  const BarMeter({Key? key, required this.rate, this.maxRate = 5, this.width = 10.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barPadding = width / 5;
    final emptyBarColor = Colors.grey.shade300;
    final finalRate = rate <= maxRate ? rate : maxRate;

    return Container(
      width: (maxRate - 1) * barPadding + maxRate * width,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            maxRate,
            (index) => _Bar(
              rate: (index + 1),
              color: finalRate > (index + 1) ? Colors.red : emptyBarColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({Key? key, required this.rate, required this.color}) : super(key: key);

  final int rate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: _kBarWidth,
      height: _kBarWidth * 0.5 * rate * math.pow(1.07, rate),
    );
  }
}
