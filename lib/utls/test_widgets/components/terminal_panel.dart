import 'package:flutter/material.dart';
import '../test_colors.dart';

class TestTerminalPanel extends StatelessWidget {
  final List<String> logs;

  const TestTerminalPanel({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: const BoxDecoration(
        color: TestColors.terminalBg,
        border: Border(top: BorderSide(color: TestColors.divider)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.code, size: 14, color: Colors.greenAccent),
                SizedBox(width: 8),
                Text(
                  "SYSTEM_LOGS",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: TestColors.inactiveText.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: logs.length,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  logs[i],
                  style: const TextStyle(
                    color: TestColors.logText,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
