import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munch_test/engine/src/constants.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';
import 'package:munch_test/game/widgets/action_button.dart';

extension on Status {
  String wording(int? winner) {
    switch (this) {
      case Status.won:
        return winner == EngineConstants.computerMarker ? 'You Lost' : 'You Won!';
      case Status.draw:
        return 'It\'s A Draw';
      default:
        return '';
    }
  }
}

class GameStatusSheet extends StatelessWidget {
  const GameStatusSheet({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent == true && state.status == Status.init) {
          Navigator.of(context).pop();
        }
      },
      builder: (BuildContext context, GameState state) {
        if (state.status != Status.draw && state.status != Status.won) {
          return const SizedBox.shrink();
        }
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Container(
              height: MediaQuery.sizeOf(context).height * .4,
              padding: const EdgeInsets.all(32),
              width: double.infinity,
              decoration: BoxDecoration(color: theme.colorScheme.onSurface),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset(_getImagePath(state)),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Center(
                      child: Text(state.status.wording(state.winner),
                          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.inversePrimary)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ActionButton(status: state.status),
                  ),
                ],
              )),
        );
      },
    );
  }

  String _getImagePath(GameState state) {
    switch (state.status) {
      case Status.won:
        return state.winner == EngineConstants.computerMarker
            ? 'assets/images/loss_image.png'
            : 'assets/images/win_image.png';
      case Status.draw:
        return 'assets/images/draw_image.png';
      default:
        return '';
    }
  }
}
