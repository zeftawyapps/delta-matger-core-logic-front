import 'package:flutter/material.dart';
import '../test_colors.dart';

class TestActionCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  final VoidCallback onTap;

  const TestActionCard({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TestColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TestColors.divider),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: TestColors.primaryWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.hub,
                  color: TestColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      desc,
                      style: const TextStyle(
                        color: TestColors.inactiveText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: TestColors.subtleText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
