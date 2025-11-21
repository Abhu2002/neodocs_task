import 'dart:ui';

/// Model for each range item from the API
class RangeItem {
  final double start;
  final double end;
  final String meaning;
  final Color color;

  RangeItem({
    required this.start,
    required this.end,
    required this.meaning,
    required this.color,
  });

  factory RangeItem.fromJson(Map<String, dynamic> json) {
    // "range": "0-21" -> [0, 21]
    final parts = (json['range'] as String).split('-');
    final double start = double.parse(parts[0]);
    final double end = double.parse(parts[1]);

    final String colorString = json['color'] as String;
    // "#098a5d" -> 0xff098a5d
    final int colorInt = int.parse(
      colorString.replaceFirst('#', '0xff'),
    );

    return RangeItem(
      start: start,
      end: end,
      meaning: json['meaning'] as String,
      color: Color(colorInt),
    );
  }
}