import 'dart:math';

import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';

class SomeAlgorithm extends IAlgorithm {
  SomeAlgorithm() : super(EngineConstants.computerMarker);

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
    // Try to win
    MarkedPoint? winningMove = _findWinningMove(givenPositions, EngineConstants.computerMarker);
    if (winningMove != null) return winningMove;

    // Block opponent's winning move
    MarkedPoint? blockingMove = _findWinningMove(givenPositions, EngineConstants.playerMarker);
    if (blockingMove != null) return blockingMove;
    
    // Take center if available
    if (_isPositionEmpty(givenPositions, const Point(1, 1))) {
      return MarkedPoint(value: EngineConstants.computerMarker, position: const Point(1, 1));
    }
    
    // Take a corner if available
    List<Point> corners = const [Point(0, 0), Point(0, 2), Point(2, 0), Point(2, 2)];
    for (var corner in corners) {
      if (_isPositionEmpty(givenPositions, corner)) {
        return MarkedPoint(value: EngineConstants.computerMarker, position: corner);
      }
    }
    
    // Take any available position
    List<Point> emptyPositions = _unoccupiedPositions(givenPositions);
    return MarkedPoint(
        value: EngineConstants.computerMarker,
        position: emptyPositions[Random().nextInt(emptyPositions.length)]
    );
  }

  /// Finds a winning move for the given player marker
  MarkedPoint? _findWinningMove(List<MarkedPoint> givenPositions, int playerMarker) {
    List<Point> emptyPositions  = _unoccupiedPositions(givenPositions);

    for (var position in emptyPositions) {
      // Create a test board with the player's move
      List<MarkedPoint> testPositions = List.from(givenPositions)
        ..add(MarkedPoint(value: playerMarker, position: position));

      // Check if this move wins the game
      var (winner, status) = checkStatus(testPositions);
      if (status == GameStatus.won && winner == playerMarker) {
        return MarkedPoint(value: EngineConstants.computerMarker, position: position);
      }
    }

    return null;
  }

  bool _isPositionEmpty(List<MarkedPoint> givenPositions, Point position) {
    return givenPositions.existsOnGrid(position) == null;
  }

  /// Returns a list of unoccupied positions on the board
  List<Point> _unoccupiedPositions(List<MarkedPoint> givenPositions) {
    return EngineConstants.maxGridPoints
        .where((gridPosition) => givenPositions.existsOnGrid(gridPosition) == null)
        .toList();
  }

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
