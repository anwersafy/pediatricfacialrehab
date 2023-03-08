import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:job/main.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../cubitTest/state.dart';
import 'state.dart';

class FaceDetectionCubit extends Cubit<FaceDetectionState> {
  FaceDetectionCubit() : super(FaceDetectionInitial());

  static get(context) => BlocProvider.of(context);

  VideoPlayerController videoController =
  VideoPlayerController.asset("assets/video/smile.mp4");

  List<String> videoAssets = [
    "video/smile.mp4",
    "video/O2.mp4",
    'video/Blown3.mp4',
    "video/angry.mp4",
    "video/madmada5_.mp4",
    "video/karmasha6.mp4",
  ];
  int Rcounter = 0;
  conter() {

    if(Rcounter<=100) {
      Timer.periodic
        (Duration(seconds: 2), (timer) {
        Rcounter++;

        debugPrint('Counter: $Rcounter');

        // Add your loop code here
      });
    }else{
      Rcounter=0;
    }
}
  loadVideoPlayer({String videoAsset = 'video/smile.mp4'}) async {
    videoController = VideoPlayerController.asset(
      videoAsset ?? 'assets/video/smile.mp4',
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    videoController!.addListener(() {
      if (videoController!.value.position == videoController!.value.duration) {
        videoController!.seekTo(Duration.zero);
        videoController!.pause();
        emit(FaceDetectionInitial());
      }
    });
    videoController!.initialize().then((value) {
      videoController!.play();
      videoController!.setLooping(true);
      emit(FaceDetectionInitial());
    });
  }

  var Screenshots = [];
  var screenshotPath = [];

  // ScreenshotController screenshotController = ScreenshotController();
  var ScreenShotController = ScreenshotController();

  FaceDetector faceDetector = FaceDetector(
    enableClassification: true,
    enableTracking: true,
    detectContour: true,
    detectLandmark: true,
    minFaceSize: 0.15,
    mode: FaceDetectorMode.accurate,
  );

  final _smileStreamController = StreamController();

  Stream get smileStream => _smileStreamController.stream;


  //int countReact=Rcounter;

  detectSmiles(inputImage) async {
    var faces = await faceDetector.detect(inputImage);

    bool isSmiling = false;

    for (Face face in faces) {
      //counterRandom();
      conter();
      if (face.smilingProbability != null && face.smilingProbability! > 0.5) {
        //isSmiling = true;
        smileCount++;

        _smileStreamController.add(SmileDetected(isSmiling));

        if (smileCount == 1) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            // Check for smile in the faces collection
            for (Face face in faces) {

              if (face.smilingProbability != null &&
                  face.smilingProbability! > 0.7) {
                smileCount++;
                _startSmileTimer();


                _smileStreamController.add(SmileDetected(isSmiling));
                if (smileCount == 1) {

                  _smileStreamController.add(SmileDetected(isSmiling));
                  emit(SmileDetected(isSmiling));

                }
                emit(SmileDetected(isSmiling));
                break;
              }
            }
          });
        }

        emit(SmileDetected(isSmiling));

        break;
      }
    }
  }




  var smileCount = 0;
  var smileTimer;

  void _startSmileTimer() {
    smileTimer = Timer.periodic(Duration(seconds: 1), onSmileTimerTick);
  }

  onSmileTimerTick(Timer timer) async {
    if (smileCount >= 10) {
      ScreenShotController.captureAndSave(pathImages,
      fileName: "image_$smileCount.png",
        delay: Duration(milliseconds: 0),
      ).then((value) async {
        screenshotPath.add(value);


        // var image = await value.readAsBytes();
      // then((Uint8List? image) async {






        _smileStreamController.add(ScreenshotsTaken());
        emit(ScreenshotsTaken());
      }).catchError((onError) {
        print(onError);
      });
      await captureAndSave();
      smileCount = 0;
      _smileStreamController.add(MaxSmileCountReached());
      smileTimer?.cancel();
    } else {
      await captureAndSave();
      smileCount++;
      _smileStreamController.add(SmileCount(smileCount));
    }
  }
  Future<String> get imagePath async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    return '$directory/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}-${DateTime.now().hour}-${DateTime.now().minute}.png';
  }

  Future<Image> _loadImage() async {
    return imagePath.then((imagePath) => Image.asset(imagePath));
  }

  Future<void> captureAndSave() async {
    final path = await imagePath;
    await ScreenShotController.captureAndSave(path);
    // It always returns false, although I'm saving the file using `captureAndSave` .
    screenshotPath.add(path);
    doesTheImageExist = File(path).existsSync();
  }

Image? imageGallary;
var doesTheImageExist = false;

  var imageFile;

  final _happyStreamController = StreamController();
  Stream get happyStream => _happyStreamController.stream;
  var happyCount = 0;
  var happyTimer;

  detectHappy(inputImage) async {
    var faces = await faceDetector.detect(inputImage);
    bool isHappy = false;
    var count = happyCount;
    for (Face face in faces) {
      if (face.smilingProbability != null && face.smilingProbability! > 0.5) {
        isHappy = true;
        happyCount++;
        if (happyCount == 1) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            // Check for smile in the faces collection
            for (Face face in faces) {
              if (face.smilingProbability != null &&
                  face.smilingProbability! > 0.7) {
                happyCount++;

                //_startHappyTimer();

                _happyStreamController.add(HappyDetected(isHappy));
                if (happyCount == 1) {
                  _happyStreamController.add(HappyDetected(isHappy));
                  emit(HappyDetected(isHappy));
                }
                emit(HappyDetected(isHappy));
                break;
              }
            }
          });
          _happyStreamController.add(HappyDetected(isHappy));
        }
      }
      // await Future.delayed(Duration(seconds: 2));
      // if (happyCount == count) {
      //   happyCount += 2;
      emit(HappyDetected(isHappy));
      // break;
    }
  }


  final _sadStreamControler = StreamController();
  Stream get sadStream => _sadStreamControler.stream;
  var sadCount = 0;
  var sadTimer;
  detectSad(inputImage) async {
    var faces = await faceDetector.detect(inputImage);
    bool isSad = false;
    var count = sadCount;
    for (Face face in faces) {
      if (face.leftEyeOpenProbability != null &&
          face.rightEyeOpenProbability != null &&
          face.leftEyeOpenProbability! < 0.1 &&
          face.rightEyeOpenProbability! < 0.1) {
        isSad = true;
        sadCount++;
        if (sadCount == 1) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            for (Face face in faces) {
              if (face.leftEyeOpenProbability != null &&
                  face.rightEyeOpenProbability != null &&
                  face.leftEyeOpenProbability! < 0.1 &&
                  face.rightEyeOpenProbability! < 0.1) {
                isSad = true;
                sadCount++;
                _sadStreamControler.add(SadDetected(isSad));
                emit(SadDetected(isSad));
                break;
              }
            }
          });
          _sadStreamControler.add(SadDetected(isSad));
        }
        await Future.delayed(Duration(seconds: 2));
        if (sadCount == count) {
          sadCount += 2;
        }
        emit(SadDetected(isSad));
        break;
      }
    }
  }


      final _angryStreamController = StreamController();
      Stream get angryStream =>
      _angryStreamController.stream;
      var angryCount = 0;
      var angryTimer;
      detectAngry(inputImage) async {
        var faces = await faceDetector.detect(inputImage);
        bool isAngry = false;
        var count = angryCount;
        for (Face face in faces) {
          if (face.rightEyeOpenProbability != null &&
              face.rightEyeOpenProbability! > 0.7 &&
              face.leftEyeOpenProbability != null &&
              face.leftEyeOpenProbability! > 0.7 &&
              face.smilingProbability != null ||
              face.smilingProbability! < 0.1) {
            isAngry = true;
            angryCount+1;
            if (angryCount == 1) {
              Timer.periodic(Duration(seconds: 1), (timer) {
                for (Face face in faces) {
                  if (face.rightEyeOpenProbability != null &&
                      face.rightEyeOpenProbability! > 0.7 &&
                      face.leftEyeOpenProbability != null &&
                      face.leftEyeOpenProbability! > 0.7 &&
                      face.smilingProbability != null ||
                      face.smilingProbability! < 0.1) {
                    isAngry = true;
                    angryCount++;
                    _angryStreamController.add(AngryDetected(isAngry));
                    emit(AngryDetected(isAngry));
                    //break;
                  }

                }
              });

              _angryStreamController.add(AngryDetected(isAngry));
              emit(AngryDetected(isAngry));
            }
            emit(AngryDetected(isAngry));
            await Future.delayed(Duration(seconds: 2));
            if (angryCount == count) {
              angryCount += 2;
            }
            break;
          }
        }
      }




  final _SurprisedStreamController = StreamController();
  Stream get surprisedStream => _SurprisedStreamController.stream;
  var surprisedCount = 0;
  var surprisedTimer;
  detectSurprised(inputImage) async {
    var faces = await faceDetector.detect(inputImage);
    bool isSurprised = false;
    var count = surprisedCount;
    for (Face face in faces) {
      if (face.rightEyeOpenProbability != null &&
          face.rightEyeOpenProbability! < 0.1 &&
          face.leftEyeOpenProbability != null &&
          face.leftEyeOpenProbability! < 0.1 &&
          face.smilingProbability != null &&
          face.smilingProbability! < 0.1) {
        isSurprised = true;
        surprisedCount++;
        if (surprisedCount == 1) {
          Timer.periodic(Duration(seconds: 1), (timer) {
            for (Face face in faces) {
              if (face.rightEyeOpenProbability != null &&
                  face.rightEyeOpenProbability! < 0.1 &&
                  face.leftEyeOpenProbability != null &&
                  face.leftEyeOpenProbability! < 0.1 &&
                  face.smilingProbability != null &&
                  face.smilingProbability! < 0.1) {
                isSurprised = true;
                surprisedCount++;
                _SurprisedStreamController.add(SurprisedDetected(isSurprised));
                emit(SurprisedDetected(isSurprised));

                break;
              }
            }
          });
          _SurprisedStreamController.add(SurprisedDetected(isSurprised));
          emit(SurprisedDetected(isSurprised));
        }
        // await Future.delayed(Duration(seconds: 2));
        // if (surprisedCount == count) {
        //   surprisedCount += 1;
        }
        emit(SurprisedDetected(isSurprised));
        break;
      }
      }



//   final _mouthLipsStreamController = StreamController();
//
//   Stream get mouthLipsStream => _mouthLipsStreamController.stream;
//   var mouthLipsCount = 0;
//   var mouthLipsTimer;
//
//   void _startMouthLipsTimer() {
//     mouthLipsTimer = Timer.periodic(Duration(seconds: 1), onMouthLipsTimerTick);
//     Timer(Duration(seconds: 10), () {
//       mouthLipsTimer?.cancel();
//     });
//   }
//
//   void onMouthLipsTimerTick(Timer timer) {
//     if (mouthLipsCount >= 20) {
//       screenshotController.capture().then((Uint8List? image) async {
//         var imageGallerySaver = await ImageGallerySaver.saveImage(image!);
//         var imagePath = imageGallerySaver['filePath'];
//         Screenshots.add(imagePath);
//         _mouthLipsStreamController.add(ScreenshotsTaken());
//         emit(ScreenshotsTaken());
//       }).catchError((onError) {
//         print(onError);
//       });
//       mouthLipsCount = 0;
//       _mouthLipsStreamController.add(MaxMouthLipsCountReached());
//       mouthLipsTimer?.cancel();
//     } else {
//       mouthLipsCount++;
//       _mouthLipsStreamController.add(MouthLipsCount(mouthLipsCount));
//     }
//   }
//
//   detectMouthLips(inputImage) async {
//     var faces = await faceDetector.detect(inputImage);
//     bool isMouthMove = false;
//     for (Face face in faces) {
//       final mouth = face.landmarks[FaceLandmarkType.MOUTH_BOTTOM];
//       final leftMouth = face.landmarks[FaceLandmarkType.MOUTH_LEFT];
//       final rightMouth = face.landmarks[FaceLandmarkType.MOUTH_RIGHT];
//       final mouthWidth = rightMouth!.point.dx - leftMouth!.point.dx;
//       final mouthHeight = mouth!.point.dy - leftMouth.point.dy;
//       final mouthAspectRatio = mouthWidth / mouthHeight;
//       if (face.smilingProbability != null && face.smilingProbability! < 0.1) {
//         // if (mouthAspectRatio > 1.8) {
//         //   // Mouth is open horizontally
//         //   if (rightMouth.point.dx - leftMouth.point.dx > mouthWidth * 0.6) {
//         //     isMouthMove = true;
//         //     mouthLipsCount++;
//         //     if (mouthLipsCount == 1) {
//         //       _mouthLipsStreamController.add(MouthLipsDetected(isMouthMove));
//         //       _startMouthLipsTimer();
//         //     }
//         //     emit(MouthLipsDetected(isMouthMove));
//         //   }
//         // } else if (leftMouth.point.dx - rightMouth.point.dx > mouthWidth * 0.6) {
//         isMouthMove = true;
//         mouthLipsCount++;
//         if (mouthLipsCount == 1) {
//           _mouthLipsStreamController.add(MouthLipsDetected(isMouthMove));
//           _startMouthLipsTimer();
//         }
//         emit(MouthLipsDetected(isMouthMove));
//       } else {
//         isMouthMove = false;
//         mouthLipsCount = 0;
//         _mouthLipsStreamController.add(MouthLipsDetected(isMouthMove));
//         emit(MouthLipsDetected(isMouthMove));
//       }
//     }
//   }
//
//   final _browStreamController = StreamController();
//
//   Stream get browStream => _browStreamController.stream;
//
//   detectBrows(inputImage) async {
//     var faces = await faceDetector.detect(inputImage);
//
//     for (Face face in faces) {
//       if (face.leftEyeOpenProbability != null &&
//               face.rightEyeOpenProbability != null &&
//               face.leftEyeOpenProbability! < 0.00000001 ||
//           face.rightEyeOpenProbability! < 0.00000001) {
//         isbrowMovement = true;
//         browMovementCount + 1;
//         _browStreamController.add(BrowMovementDetected(isbrowMovement));
//         _startBrowTimer();
//         _browStreamController.add(BrowMovementDetected(isbrowMovement));
//         emit(BrowMovementDetected(isbrowMovement));
//       }
//     }
//   }
//
//   bool isbrowMovement = false;
//   var browMovementCount = 0;
//   var browTimer;
//
//   _startBrowTimer() async {
//     browTimer = Timer.periodic(Duration(seconds: 1), onBrowTimerTick);
//     Timer(Duration(seconds: 10), () {
//       browTimer?.cancel();
//       _browStreamController.add(MaxBrowCountReached());
//     });
//   }
//
//   void onBrowTimerTick(Timer timer) {
//     if (browMovementCount >= 20) {
//       screenshotController.capture().then((Uint8List? image) async {
//         var imageGallerySaver = await ImageGallerySaver.saveImage(image!);
//         var imagePath = imageGallerySaver['filePath'];
//         Screenshots.add(imagePath);
//         _browStreamController.add(ScreenshotsTaken());
//         emit(ScreenshotsTaken());
//       }).catchError((onError) {
//         print(onError);
//       });
//       browMovementCount = 0;
//
//       _browStreamController.add(MaxBrowCountReached());
//       browTimer?.cancel();
//     } else {
//       browMovementCount++;
//       _browStreamController.add(BrowCount(browMovementCount));
//     }
//   }
//
//   var eyebrowLiftCount = 0;
//   var _eyebrowLiftTimer;
//
//   double _calculateEyebrowY(List<Offset> points) {
//     double sumY = 0;
//     for (var point in points) {
//       sumY += point.dy;
//     }
//     return sumY / points.length;
//   }
//
//   double _getDistance(Offset p1, Offset p2) {
//     final dx = p2.dx - p1.dx;
//     final dy = p2.dy - p1.dy;
//     return sqrt(dx * dx + dy * dy);
//   }
//
//   isOMouth(inputImage) async {
//     final faces = await faceDetector.detect(inputImage);
//     if (faces.isEmpty) {
//       return false;
//     }
//     for (var face in faces) {
//       var distance = face.landmarks[FaceLandmarkType.MOUTH_BOTTOM]!.point.dy -
//           face.landmarks[FaceLandmarkType.NOSE_BASE]!.point.dy;
//       if (distance > 10) {
//         emit(IsOMouth(true));
//         smileCount + 1;
//         return true;
//       }
//     }
//   }
//   // takeScreenShot() async{
//   //   RenderRepaintBoundary boundary = ScreenshotController.currentContext.findRenderObject();
//   //   ui.Image image = await boundary.toImage();
//   //   final directory = (await getApplicationDocumentsDirectory()).path;
//   //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   //   Uint8List pngBytes = byteData.buffer.asUint8List();
//   //   print(pngBytes);
//   //   File imgFile =new File('$directory/screenshot.png');
//   //   imgFile.writeAsBytes(pngBytes);
//   // }
// }
  var game = Hive.openBox('game');
  var dlevel1 = Hive.openBox('Level1');
  var dlevel2 = Hive.openBox('Level2');
  var dlevel3 = Hive.openBox('Level3');
  var dlevel4 = Hive.openBox('Level4');
  var dlevel5 = Hive.openBox('Level5');
  var dleve6 = Hive.openBox('Level6');

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final allBytes = WriteBuffer();
    for (final plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  var randomCount = 0;
  counterRandom() async {
    var random = Random();
    var randomNumber = random.nextInt(5);
    for (var i = 0; i < 10; i++) {
      randomCount = i + randomNumber;
      await Future.delayed(Duration(seconds: 1));
      _smileStreamController.add(RandomNumber(randomCount));
      Timer(Duration(seconds: 1), () {
        emit(RandomNumber(randomCount));
      });
    }
    emit(RandomNumber(randomNumber));
  }

  Future<void> takeScreenshotAndSave() async {
    try {
      // Take the screenshot
      final imageFile = await ScreenShotController.capture();

      // Save the file to local storage
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(imageFile!);
emit(ScreenshotsTaken());
      // Store the file path in Hive
      final box = await Hive.openBox('screenshots');
      box.add(filePath);
      emit(ScreenshotsTaken());
    } catch (e) {
      print('Failed to take screenshot: $e');
    }
  }
  var box = Hive.openBox('screenshots');

   storeScreenShot(Uint8List image) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/screenshot.png');
    screenshotPath.add(imgFile.path);
    imgFile.writeAsBytes(image);
    emit(ScreenshotsTaken());

  }
  showScreenShot() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/screenshot.png');
    emit(ScreenshotsTaken());
  }


}
