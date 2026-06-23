import 'package:flutter/material.dart';

class TrackingStepTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDone;
  final bool isActive;

  const TrackingStepTile({
    super.key,
    required this.icon,
    required this.label,
    required this.isDone,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final Color dotColor;
    final Color lineColor;

    if (isDone) {
      dotColor = scheme.primary;
      lineColor = scheme.primary.withValues(alpha: 0.35);
    } else if (isActive) {
      dotColor = scheme.primary;
      lineColor = scheme.primary.withValues(alpha: 0.20);
    } else {
      dotColor = scheme.onSurface.withValues(alpha: 0.25);
      lineColor = scheme.onSurface.withValues(alpha: 0.10);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: lineColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isActive
                        ? scheme.primary.withValues(alpha: 0.12)
                        : scheme.surfaceContainerHighest.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive
                          ? scheme.primary.withValues(alpha: 0.35)
                          : scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    color: isActive
                        ? scheme.primary
                        : scheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: isDone || isActive
                          ? scheme.onSurface
                          : scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

