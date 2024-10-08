import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';

part 'game_event.dart';
part 'game_state.dart';

/// Main objective of this bloc is to reactive to the main game events and manage the following state
/// * User and computed populated positions
/// * Score sheet
/// * Total number of games played
/// * Current status of the game
class GameBloc extends Bloc<GameEvent, GameState> {
  final IAlgorithm _algorithm;

  GameBloc(IAlgorithm algorithm)
      : _algorithm = algorithm,
        super(GameState.init()) {
    on<MoveEvent>(_handleMoveEvent);
    on<PromptComputerMoveEvent>(_handlePromptComputerMoveEvent);
    on<ResetEvent>(_handleResetEvent);
  }

  void _handleMoveEvent(MoveEvent event, Emitter<GameState> emit) {
    if (state.status == Status.won || state.status == Status.draw || state.validatePosition(event.position) == false) {
      return;
    }

    final postUserPositions = [...state.positions, event.position];

    var (int? winner, GameStatus status) = _algorithm.checkStatus(postUserPositions);

    if (status == GameStatus.draw || status == GameStatus.won) {
      Map<int, int>? scoreSheet = state.scoreSheet;
      if (status == GameStatus.won) {
        var currentPlayerScore = state.getPlayerScore ?? 0;
        var currentComputerScore = state.getComputerScore ?? 0;

        scoreSheet = {
          EngineConstants.playerMarker:
              winner == EngineConstants.playerMarker ? currentPlayerScore + 1 : currentPlayerScore,
          EngineConstants.computerMarker:
              winner == EngineConstants.computerMarker ? currentComputerScore + 1 : currentComputerScore
        };
      }

      emit(state.copyWith(
        gamesCounter: state.gamesCounter + 1,
        positions: postUserPositions,
        status: status.toBlocStatus(),
        winner: winner,
        scoreSheet: scoreSheet,
      ));

      return;
    }

    List<MarkedPoint> postComputerMovePositions = _algorithm.processMove(postUserPositions);

    (winner, status) = _algorithm.checkStatus(postUserPositions);

    Map<int, int>? scoreSheet = state.scoreSheet;

    if (status == GameStatus.won) {
      var currentPlayerScore = state.getPlayerScore ?? 0;
      var currentComputerScore = state.getComputerScore ?? 0;

      scoreSheet = {
        EngineConstants.playerMarker:
            winner == EngineConstants.playerMarker ? currentPlayerScore + 1 : currentPlayerScore,
        EngineConstants.computerMarker:
            winner == EngineConstants.computerMarker ? currentComputerScore + 1 : currentComputerScore
      };
    }

    emit(state.copyWith(
      gamesCounter: status == GameStatus.won || status == GameStatus.draw ? state.gamesCounter + 1 : state.gamesCounter,
      positions: postComputerMovePositions,
      status: status.toBlocStatus(),
      winner: winner,
      scoreSheet: scoreSheet,
    ));
    return;
  }

  void _handleResetEvent(ResetEvent event, Emitter<GameState> emit) {
    emit(GameState.reset(
      gamesCounter: state.gamesCounter,
      scoreSheet: state.scoreSheet,
    ));
  }

  void _handlePromptComputerMoveEvent(PromptComputerMoveEvent event, Emitter<GameState> emit) {
    List<MarkedPoint> outputPositions = _algorithm.processMove([]);

    final (winner, status) = _algorithm.checkStatus(outputPositions);

    emit(state.copyWith(
      positions: outputPositions,
      status: status.toBlocStatus(),
      winner: winner,
    ));
  }
}

class Initial {}
