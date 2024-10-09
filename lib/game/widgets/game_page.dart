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
      body: BlocListener<GameBloc, GameState>(
        listenWhen: (previous, current) =>
          current.status == Status.won || current.status == Status.draw,
        listener: (context, state) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => BlocProvider.value(
              value: context.read<GameBloc>(),
              child: const GameStatusSheet(),
            ),
          );
        },
        child: BlocBuilder<GameBloc, GameState>(
          buildWhen: (previous, current) =>
          previous.canResetScoreSheet != current.canResetScoreSheet ||
              previous.status != current.status ||
              previous.positions != current.positions,
          builder: (context, state) {
            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return _buildPortraitLayout(context, state);
                } else {
                  return _buildLandscapeLayout(context, state);
                }
              },
            );
          },
        )
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, GameState state) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: ScoreHeader(state: state),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Grid(positions: state.positions),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
              child: ActionButton(status: state.status),
            ),
            const SizedBox(height: 20),
            if (state.showScoreResetBtn)
              SizedBox(
                height: MediaQuery.of(context).size.height * .07,
                child: ActionButton(status: state.status, isResetScoreSheetButton: true),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, GameState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(flex: 4, child: ScoreHeader(state: state)),
                    const SizedBox(height: 10),
                    Flexible(flex: 1, child: ActionButton(status: state.status)),
                    if (state.showScoreResetBtn)
                      Flexible(
                          flex: 1,
                          child: ActionButton(
                          status: state.status,
                          isResetScoreSheetButton: true
                        )
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Grid(positions: state.positions),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
