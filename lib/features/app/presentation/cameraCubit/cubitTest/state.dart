import 'cubit.dart';
import 'package:learning_input_image/learning_input_image.dart';


abstract class FaceDetectionState{}

class FaceDetectionInitial extends FaceDetectionState{}

class FaceDetectionLoading extends FaceDetectionState{}

class FaceDetectionSuccess extends FaceDetectionState{}

class FaceDetectionError extends FaceDetectionState{
  final String message;
  FaceDetectionError(this.message);
}

class IsSmiling extends FaceDetectionState{
  final bool isSmiling;
  IsSmiling(this.isSmiling);
}

class IsMouthBlowing extends FaceDetectionState{
  final bool isMouthBlowing;
  IsMouthBlowing(this.isMouthBlowing);
}
class EyebrowLiftDetected extends FaceDetectionState{
  final bool isEyebrowLifted;
  EyebrowLiftDetected(this.isEyebrowLifted);
}
class IsOMouth extends FaceDetectionState{
  final bool isMouth;
  IsOMouth(this.isMouth);
}
class MaxSmileCountReached extends FaceDetectionState{
  MaxSmileCountReached();
}
class SmileCount extends FaceDetectionState{
  final int smileCount;
  SmileCount(this.smileCount);
}
class SmileDetected extends FaceDetectionState{
  final bool isSmileDetected;
  SmileDetected(this.isSmileDetected);
}
class ScreenshotsTaken extends FaceDetectionState{
  ScreenshotsTaken();
}
class BrowMovementDetected extends FaceDetectionState{
  final bool isBrowMovementDetected;
  BrowMovementDetected(this.isBrowMovementDetected);
}
class MaxBrowCountReached extends FaceDetectionState{
  MaxBrowCountReached();
}
class BrowCount extends FaceDetectionState{
  final int browCount;
  BrowCount(this.browCount);
}
class MouthLipsDetected extends FaceDetectionState{
  final bool isMouthLipsDetected;
  MouthLipsDetected(this.isMouthLipsDetected);
}
class MaxMouthLipsCountReached extends FaceDetectionState{
  MaxMouthLipsCountReached();
}

class MouthLipsCount extends FaceDetectionState{
  final int mouthLipsCount;
  MouthLipsCount(this.mouthLipsCount);
}

class HappyDetected extends FaceDetectionState{
  final bool isHappyDetected;
  HappyDetected(this.isHappyDetected);
}
class MaxHappyCountReached extends FaceDetectionState{
  MaxHappyCountReached();
}
class HappyCount extends FaceDetectionState{
  final int happyCount;
  HappyCount(this.happyCount);
}
class SadDetected extends FaceDetectionState{
  final bool isSadDetected;
  SadDetected(this.isSadDetected);
}
class MaxSadCountReached extends FaceDetectionState{
  MaxSadCountReached();
}
class SadCount extends FaceDetectionState{
  final int sadCount;
  SadCount(this.sadCount);
}
class AngryDetected extends FaceDetectionState{
  final bool isAngryDetected;
  AngryDetected(this.isAngryDetected);
}
class MaxAngryCountReached extends FaceDetectionState{
  MaxAngryCountReached();
}
class AngryCount extends FaceDetectionState{
  final int angryCount;
  AngryCount(this.angryCount);
}
class SurprisedDetected extends FaceDetectionState{
  final bool isSurprisedDetected;
  SurprisedDetected(this.isSurprisedDetected);
}
class MaxSurprisedCountReached extends FaceDetectionState{
  MaxSurprisedCountReached();
}
class SurprisedCount extends FaceDetectionState{
  final int surprisedCount;
  SurprisedCount(this.surprisedCount);
}
class RandomNumber extends FaceDetectionState{
  final int randomNumber;
  RandomNumber(this.randomNumber);
}
