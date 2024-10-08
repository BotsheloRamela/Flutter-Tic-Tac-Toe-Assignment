import 'models/models.dart';

/// This interface assumes the algorithm implementation performs the following key steps
/// 1) Evaluate given points
/// 2) Determine the next move to make. The last element in [givenPositions] is the latest move
/// 3) Apply the computer move, append new [MarkedPoint] in [givenPositions]
/// 4) Provide means to query the state of the game by implementing the [IAlgorithm.checkStatus] function
abstract class IAlgorithm {
  final int computerValue;

  IAlgorithm(this.computerValue);

  /// 1) Evaluate given points
  /// 2) Determine the next move to make. The last element in [givenPositions] is the latest move
  /// 3) Apply the computer move, append new [MarkedPoint] in [givenPositions]
  /// 5) Returned populated [givenPositions]
  List<MarkedPoint> processMove(List<MarkedPoint> givenPositions);

  /// [winner] should have [EngineConstants.playerMarker] or [EngineConstants.computerMarker] or null if the game hs still in progress
  /// as well as the correct status depending on populated points [givenPositions]
  (int? winner, GameStatus status) checkStatus(List<MarkedPoint> givenPositions);
}
