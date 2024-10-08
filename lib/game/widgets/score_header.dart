import 'package:flutter/material.dart';
import 'package:munch_test/engine/src/constants.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';

import 'player_score.dart';

class ScoreHeader extends StatelessWidget {
  final GameState state;
  const ScoreHeader({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int playerMarker = EngineConstants.playerMarker;
    int computerMarker = EngineConstants.computerMarker;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text(
              'TIC-TAC-TOE',
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.onSurface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Games Played'),
                Text('${state.gamesCounter}', style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          flex: 3,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: PlayerScore(playerLabel: 'You', marker: playerMarker, score: state.getPlayerScore ?? 0)),
                const SizedBox(width: 16),
                Expanded(
                    child: PlayerScore(
                        playerLabel: 'Computer', marker: computerMarker, score: state.getComputerScore ?? 0)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
