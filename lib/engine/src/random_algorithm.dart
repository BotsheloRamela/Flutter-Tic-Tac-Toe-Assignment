import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:munch_test/engine/src/algorithm_interface.dart';
import 'package:munch_test/engine/src/constants.dart';
import 'package:munch_test/engine/src/models/game_status.dart';
import 'package:munch_test/engine/src/models/point.dart';

class RandomAlgo extends IAlgorithm {
  final Random _random = Random();
  RandomAlgo() : super(EngineConstants.computerMarker);

  @override
  List<MarkedPoint> processMove(List<MarkedPoint> givenPositions) {
    if (givenPositions.length == EngineConstants.maxPositions) {
      return givenPositions;
    }

    MarkedPoint newComputerPoint = _determineNextComputerMove(givenPositions);

    givenPositions.add(newComputerPoint);
    return givenPositions;
  }

  MarkedPoint _determineNextComputerMove(List<MarkedPoint> givenPositions) {
    List<Point> unoccupiedPositions = _unoccupiedPositions(givenPositions);

    int randomIndex = _random.nextInt(unoccupiedPositions.length);

    Point newPosition = unoccupiedPositions[randomIndex];

    return MarkedPoint(
      value: EngineConstants.computerMarker,
      position: newPosition,
    );
  }

  List<Point> _unoccupiedPositions(List<MarkedPoint> givenPositions) {
    return EngineConstants.maxGridPoints
        .where((gridPosition) => givenPositions.existsOnGrid(gridPosition) == null)
        .toList();
  }

  @override
  (int? winner, GameStatus status) checkStatus(List<MarkedPoint> givenPositions) {
    //Still inefficient, all checks can be done in o(n) - looping once, and doing all checks in the loop;
    bool xAxis = _axisCheck(Axis.horizontal, givenPositions);
    bool yAxis = _axisCheck(Axis.vertical, givenPositions);
    bool positiveDiagonal = _positiveDiagonalCheck(positive: true, givenPositions: givenPositions);
    bool negativeDiagonal = _positiveDiagonalCheck(positive: false, givenPositions: givenPositions);

    GameStatus status =
        (yAxis || xAxis || positiveDiagonal || negativeDiagonal) ? GameStatus.won : GameStatus.inProgress;

    if (status == GameStatus.inProgress && givenPositions.length == EngineConstants.maxPositions) {
      return (null, GameStatus.draw);
    }

    return (status == GameStatus.won ? givenPositions.last.value : null, status);
  }

  bool _axisCheck(Axis axis, List<MarkedPoint> givenPositions) {
    MarkedPoint lastMove = givenPositions.last;
    return givenPositions.where((currentPoint) {
          bool pointIsAlongAxisLine = axis == Axis.horizontal
              ? lastMove.position.y == currentPoint.position.y
              : lastMove.position.x == currentPoint.position.x;
          return currentPoint.value == lastMove.value && pointIsAlongAxisLine;
        }).length ==
        3;
  }

  bool _positiveDiagonalCheck({
    required bool positive,
    required List<MarkedPoint> givenPositions,
  }) {
    MarkedPoint lastMove = givenPositions.last;
    return givenPositions.where((currentPoint) {
          bool pointIsAlongAxisLine = positive
              ? currentPoint.position.y == currentPoint.position.x
              : (currentPoint.position.y == (-currentPoint.position.x + 2));
          return currentPoint.value == lastMove.value && pointIsAlongAxisLine;
        }).length ==
        3;
  }
}
