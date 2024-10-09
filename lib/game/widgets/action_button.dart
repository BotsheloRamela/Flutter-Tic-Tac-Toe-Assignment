import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';

extension on Status {
  String get label {
    if (this == Status.init) {
      return 'Start Game';
    }
    if (this == Status.inProgress) {
      return 'Reset Game';
    }
    return 'Play Again';
  }

  IconData get icon {
    if (this == Status.inProgress) {
      return Icons.undo_outlined;
    }
    return Icons.play_arrow_outlined;
  }
}

class ActionButton extends StatelessWidget {
  final Status status;
  const ActionButton({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return FilledButton(
      onPressed: () {
        switch (status) {
          case Status.init:
            gameBloc.add(PromptComputerMoveEvent());
          case Status.inProgress:
          case Status.won:
          case Status.draw:
            gameBloc.add(ResetEvent());
            break;
          default:
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colorScheme.inversePrimary),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(status.icon, size: 32),
          const SizedBox(width: 8),
          Text(
            status.label,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.surfaceContainerLowest),
          ),
        ],
      ),
    );
  }
}
