part of 'game_bloc.dart';

enum Status { init, inProgress, won, draw }
// enum ScoreSheetStatus { initial, changed }

extension on GameStatus {
  Status toBlocStatus() {
    switch (this) {
      case GameStatus.inProgress:
        return Status.inProgress;
      case GameStatus.won:
        return Status.won;
      case GameStatus.draw:
        return Status.draw;
    }
  }
}

@immutable
class GameState extends Equatable {
  final List<MarkedPoint> positions;
  final Map<int, int> scoreSheet;
  final int gamesCounter;
  final int? winner;
  final Status status;
  final bool canResetScoreSheet;
  const GameState({
    required this.positions,
    required this.winner,
    required this.status,
    required this.scoreSheet,
    required this.gamesCounter,
    this.canResetScoreSheet = false
  });

  factory GameState.init() => const GameState(
        positions: [],
        status: Status.init,
        scoreSheet: {},
        gamesCounter: 0,
        winner: null,
      );

  factory GameState.reset({
    required int gamesCounter,
    required Map<int, int> scoreSheet,
  }) =>
      GameState(
        positions: [],
        status: Status.init,
        scoreSheet: scoreSheet,
        gamesCounter: gamesCounter,
        winner: null,
      );

  @override
  List<Object?> get props => [positions, winner, status, canResetScoreSheet];

  // returns true if any of the players has a score greater than 0
  bool get showScoreResetBtn {
    return scoreSheet.values.any((score) => score > 0);
  }

  GameState copyWith({
    List<MarkedPoint>? positions,
    Map<int, int>? scoreSheet,
    int? winner,
    Status? status,
    bool? canResetScoreSheet,
    int? gamesCounter,
  }) {
    return GameState(
      positions: positions ?? this.positions,
      winner: winner ?? this.winner,
      scoreSheet: scoreSheet ?? this.scoreSheet,
      gamesCounter: gamesCounter ?? this.gamesCounter,
      status: status ?? this.status,
      canResetScoreSheet: canResetScoreSheet ?? this.canResetScoreSheet,
    );
  }

  bool validatePosition(MarkedPoint point) => positions.where((pos) => pos.position == point.position).isEmpty;

  int? get getComputerScore => scoreSheet[EngineConstants.computerMarker];
  int? get getPlayerScore => scoreSheet[EngineConstants.playerMarker];

}
