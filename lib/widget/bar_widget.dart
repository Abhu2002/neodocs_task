import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/range_item.dart';
// The dynamic bar widget that visualizes ranges + current value
class BarWidget extends StatelessWidget {
  const BarWidget({
    super.key,
    required this.ranges,
    required this.inputValue,
  });

  final List<RangeItem> ranges;
  final double? inputValue;

  @override
  Widget build(BuildContext context) {
    if (ranges.isEmpty) return const SizedBox.shrink();

    final double minValue =
    ranges.map((e) => e.start).reduce((a, b) => a < b ? a : b);
    final double maxValue =
    ranges.map((e) => e.end).reduce((a, b) => a > b ? a : b);
    final double fullRange = maxValue - minValue;

    // Build boundaries like [0, 30, 40, 60, 70, 120]
    final List<double> boundaries = [
      ranges.first.start,
      ...ranges.map((e) => e.end),
    ];
    if (kDebugMode) {
      print('boundaries : $boundaries');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final double barWidth = constraints.maxWidth;

        double? indicatorX;
        if (inputValue != null) {
          final double clamped =
          inputValue!.clamp(minValue, maxValue).toDouble();
          final double percent = (clamped - minValue) / fullRange;
          indicatorX = percent * barWidth;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Meanings row (kept same)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: ranges.map((r) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: r.color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      r.meaning,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // TOP BOUNDARY LABELS (0, 30, 40, 60, 70, 120)
            SizedBox(
              height: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: boundaries.map((value) {
                  final percent = (value - minValue) / fullRange;
                  final xPos = percent * barWidth;

                  return Positioned(
                    left: xPos - 8,
                    child: Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 6),

            // BAR + INDICATOR
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Colored bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Row(
                    children: ranges.map((range) {
                      final double fraction =
                          (range.end - range.start) / fullRange;
                      final int flex =
                      (fraction * 1000).round().clamp(1, 1000);

                      return Expanded(
                        flex: flex,
                        child: Container(
                          height: 18,
                          color: range.color,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Indicator
                if (indicatorX != null)
                  Positioned(
                    left: indicatorX - 8, // center arrow
                    top: 22,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.arrow_drop_up,
                          size: 26,
                          color: Colors.black,
                        ),
                        Text(
                          inputValue!.toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
