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
    ThemeData theme = Theme.of(context);
    Color? pointColor = point?.value.toColor(theme);
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

class Grid extends StatefulWidget {
  List<MarkedPoint> positions;
  Grid({required this.positions, super.key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        List<MarkedPoint> gridPositions = state.positions;
        return SizedBox(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.count(
              padding: EdgeInsets.all(10),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: EngineConstants.maxGridPoints.map(
                (position) {
                  MarkedPoint? currentPoint = gridPositions.existsOnGrid(position);
                  return _MarkerBlock(
                    point: currentPoint,
                    position: position,
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
