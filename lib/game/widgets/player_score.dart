import 'package:flutter/material.dart';
import 'package:munch_test/styling/marker_extension.dart';

class PlayerScore extends StatelessWidget {
  final int score;
  final int marker;
  final String playerLabel;
  const PlayerScore({required this.marker, required this.score, required this.playerLabel, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Flexible(
            child: Text(
              marker.toDisplayValue(),
              style: theme.textTheme.titleSmall?.copyWith(color: marker.toColor(theme)),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Text(playerLabel),
                Text(
                  score.toString(),
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
