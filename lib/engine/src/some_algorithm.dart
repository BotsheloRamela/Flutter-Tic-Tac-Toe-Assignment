import 'dart:math';

import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';

class SomeAlgorithm extends IAlgorithm {
  SomeAlgorithm() : super(EngineConstants.computerMarker);

  @override
  (int?, GameStatus) checkStatus(List<MarkedPoint> givenPositions) {
    // Check rows and columns for a win
    for (int i = 0; i < 3; i++) {
      if (_checkLine(givenPositions, Point(i, 0), Point(i, 1), Point(i, 2)) ||
          _checkLine(givenPositions, Point(0, i), Point(1, i), Point(2, i))) {
        return (givenPositions.last.value, GameStatus.won);
      }
    }

    // Check diagonals for a win
    if (_checkLine(givenPositions, const Point(0, 0), const Point(1, 1), const Point(2, 2)) ||
        _checkLine(givenPositions, const Point(0, 2), const Point(1, 1), const Point(2, 0))) {
      return (givenPositions.last.value, GameStatus.won);
    }

    // Check for a draw
    if (givenPositions.length == EngineConstants.maxPositions) {
      return (null, GameStatus.draw);
    }

    // Game is still in progress
    return (null, GameStatus.inProgress);
  }

  /// Checks if three points form a winning line
  bool _checkLine(List<MarkedPoint> givenPositions, Point a, Point b, Point c) {
    var pointA = givenPositions.firstWhere((p) => p.position == a, orElse: () => MarkedPoint(value: -1, position: a));
    var pointB = givenPositions.firstWhere((p) => p.position == b, orElse: () => MarkedPoint(value: -1, position: b));
    var pointC = givenPositions.firstWhere((p) => p.position == c, orElse: () => MarkedPoint(value: -1, position: c));

    return pointA.value != -1 && pointA.value == pointB.value && pointB.value == pointC.value;
  }
}
