import 'package:flutter/foundation.dart';
import '../model/range_item.dart';
import '../service/range_service.dart';

/// ViewModel using ChangeNotifier (no setState)
class RangeViewModel extends ChangeNotifier {
  RangeViewModel(this._service);

  final RangeService _service;

  List<RangeItem> ranges = [];

  bool isLoading = false;
  String? errorMessage;

  double? inputValue;

  /// Derived properties
  double get minValue =>
      ranges.isEmpty ? 0 : ranges.map((e) => e.start).reduce((a, b) => a < b ? a : b);

  double get maxValue =>
      ranges.isEmpty ? 0 : ranges.map((e) => e.end).reduce((a, b) => a > b ? a : b);

  String get displayValueText {
    if (inputValue == null) return '-';
    return inputValue!.toStringAsFixed(0);
  }

  Future<void> loadRanges() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      ranges = await _service.fetchRanges();
    } catch (e) {
      errorMessage = 'Error fetching ranges: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateInput(String value) {
    if (value.isEmpty) {
      inputValue = null;
    } else {
      inputValue = double.tryParse(value);
      if (inputValue != null) {
        // Clamp to min/max so the indicator stays within bar
        if (inputValue! < minValue) inputValue = minValue;
        if (inputValue! > maxValue) inputValue = maxValue;
      }
    }
    notifyListeners();
  }
}