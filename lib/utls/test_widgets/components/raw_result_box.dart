import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matger_core_logic/utls/bloc/data_source_bloc_builder.dart';
import '../test_colors.dart';

class TestRawResultBox extends StatelessWidget {
  final dynamic bloc;
  final String title;

  const TestRawResultBox({super.key, required this.bloc, required this.title});

  String _formatJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: TestColors.codeBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TestColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: TestColors.surfaceWithOpacity(0.03),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.data_object_rounded,
                        size: 12,
                        color: TestColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 9,
                          color: TestColors.inactiveText,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  DataSourceBlocBuilder<Map<String, dynamic>>(
                    bloc: bloc,
                    success: (data) => IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _formatJson(data)),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("JSON copied to clipboard"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy_all_rounded,
                        size: 14,
                        color: TestColors.subtleText,
                      ),
                      visualDensity: VisualDensity.compact,
                      tooltip: "Copy All JSON",
                    ),
                    loading: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            // Body
            Container(
              constraints: const BoxConstraints(maxHeight: 400),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: DataSourceBlocBuilder<Map<String, dynamic>>(
                bloc: bloc,
                success: (data) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SelectableText(
                    _formatJson(data),
                    style: TextStyle(
                      fontSize: 11,
                      color: TestColors.textAcent.withOpacity(0.8),
                      fontFamily: 'monospace',
                      height: 1.5,
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: TestColors.divider,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
