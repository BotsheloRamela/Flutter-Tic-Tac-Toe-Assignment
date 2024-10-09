import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';
import 'package:munch_test/styling/styling.dart';

class _MarkerBlock extends StatelessWidget {
  final MarkedPoint? point;
  final Point position;
  const _MarkerBlock({
    required this.point,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();
    final ThemeData theme = Theme.of(context);
    final Color? pointColor = point?.value.toColor(theme);

    return GestureDetector(
      onTap: () => gameBloc.add(MoveEvent(MarkedPoint.pointByPlayer(position: position))),
      child: Container(
        color: theme.colorScheme.surface,
        child: point == null
            ? null
            : Center(
                child: Text(
                  point!.value.toDisplayValue(),
                  style: theme.textTheme.titleLarge?.copyWith(color: pointColor),
                ),
              ),
      ),
    );
  }
}

class Grid extends StatelessWidget {
  final List<MarkedPoint> positions;

  const Grid({required this.positions, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final List<MarkedPoint> gridPositions = state.positions;

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: EngineConstants.maxGridPoints.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final position = EngineConstants.maxGridPoints[index];
              final currentPoint = gridPositions.existsOnGrid(position);
              return _MarkerBlock(point: currentPoint, position: position);
            },
          ),
        );
      },
    );
  }
}
