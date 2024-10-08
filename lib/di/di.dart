import 'package:get_it/get_it.dart';
import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/random_algorithm.dart';

GetIt sl = GetIt.instance;

/// Injects a algorithm instance that confirms to the [IAlgorithm] interface to be consumed by the app
class DependencyInjection {
  static void init() {
    sl.registerSingleton<IAlgorithm>(RandomAlgo(), signalsReady: true);
  }
}
