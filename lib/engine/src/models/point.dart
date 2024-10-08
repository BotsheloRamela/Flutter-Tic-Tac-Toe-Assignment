import 'dart:math';

import 'package:munch_test/engine/src/constants.dart';

///Represents a single block on the grid
class MarkedPoint {
  /// 0 = 'O', 1 == 'X'
  final int value;

  /// X, Y coordinate on the grid
  final Point position;

  MarkedPoint({required this.value, required this.position});

  factory MarkedPoint.pointByPlayer({required Point position}) =>
      MarkedPoint(position: position, value: EngineConstants.playerMarker);
}

extension GridExt on List<MarkedPoint> {
  MarkedPoint? existsOnGrid(Point position) {
    for (var i = 0; i < length; i++) {
      if (this[i].position == position) {
        return this[i];
      }
    }
    return null;
  }
}
