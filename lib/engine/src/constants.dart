import 'dart:math';

class EngineConstants {
  static int maxPositions = 9;

  /// 0 = "O"
  static int playerMarker = 0;

  /// 1 = "X"
  static int computerMarker = 1;

  static const maxGridPoints = [
    Point(0, 0),
    Point(1, 0),
    Point(2, 0),
    Point(0, 1),
    Point(1, 1),
    Point(2, 1),
    Point(0, 2),
    Point(1, 2),
    Point(2, 2),
  ];
}
