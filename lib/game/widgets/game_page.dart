import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';

import 'widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state.status == Status.won || state.status == Status.draw) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => BlocProvider.value(
                value: context.read<GameBloc>(),
                child: const GameStatusSheet(),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .35,
                    child: ScoreHeader(state: state),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .4,
                    child: Grid(positions: state.positions),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .07,
                    child: ActionButton(status: state.status),
                  ),
                  const SizedBox(height: 20),
                  if (state.canResetScoreSheet)
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .07,
                      child: ActionButton(status: state.status,
                          isResetScoreSheetButton: true),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
