part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

@immutable
class MoveEvent extends GameEvent {
  final MarkedPoint position;

  MoveEvent(this.position);
}

@immutable

/// prompt computer to make a move
class PromptComputerMoveEvent extends GameEvent {}

@immutable
class ResetEvent extends GameEvent {}
