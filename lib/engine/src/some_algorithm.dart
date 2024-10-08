import 'package:munch_test/engine/engine.dart';
import 'package:munch_test/engine/src/constants.dart';

class SomeAlgorithm extends IAlgorithm {
  SomeAlgorithm() : super(EngineConstants.computerMarker);

  @override
  (int?, GameStatus) checkStatus(List<MarkedPoint> givenPositions) {
    throw UnimplementedError();
  }

  @override
  List<MarkedPoint> processMove(List<MarkedPoint> givenPositions) {
    throw UnimplementedError();
  }
}
