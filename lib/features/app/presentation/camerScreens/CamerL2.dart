import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:chewie/chewie.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:job/features/app/presentation/screens/levels.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../cameraCubit/cubitTest/cubit.dart';
import '../cameraCubit/cubitTest/data.dart';
import '../cameraCubit/cubitTest/state.dart';



class CameraScreenL2 extends StatefulWidget {



  @override
  State<CameraScreenL2> createState() => _CameraScreenL2State();
}

class _CameraScreenL2State extends State<CameraScreenL2> {
  String? AssetVide;

  var detect;
  var stream;

  var score;
  //int? score;


  late VideoPlayerController _videoPlayerController;



  @override
  void initState() {
    super.initState();


    _videoPlayerController = VideoPlayerController.asset(AssetVide??'video/angry.mp4'
      //??
      // 'video/smile.mp4'
    )
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
      });





  }

  @override
  void dispose() {
    FaceDetectionCubit().close();
    stream?.close();
    StreamController().close();
    FaceDetectionCubit().faceDetector.dispose();
    _videoPlayerController.dispose();



    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<FaceDetectionCubit, FaceDetectionState>(
        listener: (context, state) {

        }, builder: (context, state) {
        var cubit = FaceDetectionCubit();
        //cubit. loadVideoPlayer(videoAsset:AssetVide??'assets/video/smile.mp4');
        return StreamBuilder(
            stream: cubit.smileStream,
            builder: (context, snapshot) {
              return  Screenshot(
                  controller: cubit.ScreenShotController,
                  child:Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 70,
                        backgroundColor: Colors.deepOrange,
                        centerTitle: true,
                        title: Text( '${cubit.smileCount}'),
                        actions: [
                          CircularCountDownTimer(
                            duration: 10,
                            initialDuration: 0,
                            controller: CountDownController(),
                            width: 50,
                            height: 50,
                            ringColor: Colors.grey[300]!,
                            // ringGradient: null,
                            fillColor: Colors.blue[400]!,
                            //fillGradient: null,
                            backgroundColor: Colors.teal[400]!,
                            //backgroundGradient: null,
                            strokeWidth: 10.0,
                            strokeCap: StrokeCap.round,
                            textStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.S,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              debugPrint('Countdown Started');
                            },
                            onComplete: () async{
                              Box box = await Hive.openBox('game_data');
                              GameData gameData = box.get('game_data', defaultValue: GameData(level: 1, score: 0));
                              gameData.score = gameData.score! + cubit.randomCount;
                              box.put('game_data', gameData);



                              // debugPrint('Countdown Ended');
                              cubit.ScreenShotController.capture().then((Uint8List? image) async {
                                var imageGallerySaver = await ImageGallerySaver.saveImage(image!);
                                setState(() {
                                  FaceDetectionCubit().imageFile=image ;
                                });
                                final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
                                String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                                var path = '$directory';

                                FaceDetectionCubit().ScreenShotController.captureAndSave(
                                    path, //set path where screenshot will be saved
                                    fileName:fileName
                                );
                                var imgPath= '$path/$fileName.png';


                                File imgFile =  File(imageGallerySaver['filePath']);
                                var imagePath = imageGallerySaver['filePath'];
                                cubit.Screenshots.add(imgFile);
                                cubit.screenshotPath.add(imgPath);
                                // _smileStreamController.add(ScreenshotsTaken());
                                // emit(ScreenshotsTaken());
                              }).catchError((onError) {
                                print(onError);
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => levelsScreen()));

                              // RenderRepaintBoundary boundary = cubit
                              //     .previewContainer.currentContext
                              //     .findRenderObject();
                              // ui.Image image = await boundary.toImage();
                              // final directory =
                              //     (await getApplicationDocumentsDirectory())
                              //         .path;
                              // ByteData? byteData = await image.toByteData(
                              //     format: ui.ImageByteFormat.png);
                              // Uint8List? pngBytes =
                              //     byteData?.buffer.asUint8List();
                              // print(pngBytes);
                              // File imgFile =
                              //     new File('$directory/screenshot.png');
                              // cubit.ScreenshotPath.add(imgFile.path);
                              // cubit.Screenshots.add(imgFile);
                              // imgFile.writeAsBytes(pngBytes!);

                            },
                            onChange: (String timeStamp) {
                              debugPrint('Countdown Changed $timeStamp');
                            },
                            timeFormatterFunction:
                                (defaultFormatterFunction, duration) {
                              if (duration.inSeconds == 0) {
                                return "Great";
                              } else {
                                return Function.apply(
                                    defaultFormatterFunction, [duration]);
                              }
                            },
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),
                      body: InputCameraView(
                        title: 'Face Detection',
                        onImage:  (image)=> cubit.detectSmiles(image),
                        resolutionPreset: ResolutionPreset.high,
                        overlay: Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (cubit.videoController.value.isPlaying) {
                                  cubit.videoController.pause();
                                } else {
                                  cubit.videoController.play();
                                }
                              },
                              child: AspectRatio(
                                aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            ),
                          ),
                        ),
                      )

                  )
              );
            }
        );

      },

      );
  }
}
