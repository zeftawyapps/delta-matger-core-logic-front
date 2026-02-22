import 'package:flutter/material.dart';
import '../test_colors.dart';

class TestNavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const TestNavIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isActive ? TestColors.primary : Colors.transparent,
              width: 3,
            ),
          ),
          color: isActive
              ? TestColors.primary.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? TestColors.primary : TestColors.inactiveIcon,
              size: 26,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? TestColors.primary : TestColors.inactiveText,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
