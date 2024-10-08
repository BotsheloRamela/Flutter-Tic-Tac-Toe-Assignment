import 'dart:math';

import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';

class SomeAlgorithm extends IAlgorithm {
  SomeAlgorithm() : super(EngineConstants.computerMarker);

  @override
  (int?, GameStatus) checkStatus(List<MarkedPoint> givenPositions) {
    throw UnimplementedError();
  }

  /// Checks if three points form a winning line
  bool _checkLine(List<MarkedPoint> givenPositions, Point a, Point b, Point c) {
    var pointA = givenPositions.firstWhere((p) => p.position == a, orElse: () => MarkedPoint(value: -1, position: a));
    var pointB = givenPositions.firstWhere((p) => p.position == b, orElse: () => MarkedPoint(value: -1, position: b));
    var pointC = givenPositions.firstWhere((p) => p.position == c, orElse: () => MarkedPoint(value: -1, position: c));

    return pointA.value != -1 && pointA.value == pointB.value && pointB.value == pointC.value;
  }
}
