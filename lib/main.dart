import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munch_test/di/di.dart';
import 'package:munch_test/game/bloc/game_bloc.dart';
import 'package:munch_test/game/widgets/game_page.dart';
import 'package:munch_test/styling/styling.dart';
import 'package:munch_test/engine/engine.dart';

void main() {
  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      home: BlocProvider(
        create: (context) => GameBloc(sl<IAlgorithm>()),
        child: const GamePage(),
      ),
    );
  }
}
