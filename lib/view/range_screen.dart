import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../service/range_service.dart';
import '../viewModel/range_view_model.dart';
import '../widget/bar_widget.dart';

// Screen that shows the bar + input + handles loading/error
class RangeScreen extends StatefulWidget {
  const RangeScreen({super.key});

  @override
  State<RangeScreen> createState() => _RangeScreenState();
}

class _RangeScreenState extends State<RangeScreen> {
  late final RangeViewModel _viewModel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = RangeViewModel(RangeService());
    _viewModel.loadRanges();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ranges Bar'),
      ),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _viewModel.loadRanges,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (_viewModel.ranges.isEmpty) {
            return const Center(
              child: Text('No ranges available'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // The dynamic bar widget
                BarWidget(
                  ranges: _viewModel.ranges,
                  inputValue: _viewModel.inputValue,
                ),
                const SizedBox(height: 50),
                // Display current value
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Text(
                    _viewModel.displayValueText,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 24),
                // Numeric input field
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter value',
                    hintText: 'e.g. 90',
                  ),
                  onChanged: _viewModel.updateInput,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
