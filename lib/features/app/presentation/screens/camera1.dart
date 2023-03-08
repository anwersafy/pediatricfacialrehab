// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:job/features/app/domain/usecases/app_cubit/login_%20cubit.dart';
// import 'package:job/features/app/presentation/widgets/component.dart';
// import 'package:job/utils/colors.dart';
// import 'package:learning_face_detection/learning_face_detection.dart';
// import 'package:learning_input_image/learning_input_image.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
//
//
//
//
// class FaceDetectionPage extends StatefulWidget {
//   @override
//   _FaceDetectionPageState createState() => _FaceDetectionPageState();
// }
//
// class _FaceDetectionPageState extends State<FaceDetectionPage> {
//   FaceDetectionState get state => Provider.of(context, listen: false);
//
//   FaceDetector _detector = FaceDetector(
//     mode: FaceDetectorMode.accurate,
//     detectLandmark: true,
//     detectContour: true,
//     enableClassification: true,
//     enableTracking: true,
//   );
//
//   @override
//   void dispose() {
//     _detector.dispose();
//     super.dispose();
//   }
//   String output='';
//   int _smileCounter = 0;
//   Timer? _intervalTimer;
//   double _smileThreshold = 0.5;
//
//
//   Future detectEmotions(
//       image,
//       ) async {
//     var faces = await FaceDetector().detect(image);
//     for (final face in faces) {
//       final smileProb = face.smilingProbability ?? 0.0;
//       if (smileProb > _smileThreshold) {
//         // Increment the smile counter
//         setState(() {
//           output='happy';
//           _smileCounter++;
//           AppCubit.get(context).progress=_smileCounter;
//         });
//
//
//         if (_smileCounter == 1) {
//           // Start the 10-second interval
//           _intervalTimer = Timer(Duration(seconds: 10), () {
//             // Output the number of times the user smiled
//             setState(() {
//               output='sad';
//               AppCubit.get(context).progress=_smileCounter;
//             });
//             print('Number of smiles: $_smileCounter');
//             // Reset the smile counter
//             _smileCounter = 0;
//           });
//           if(_smileCounter==10){
//             AppCubit.get(context).progress=10;
//             Navigator.pop(context);
//           }
//         }
//       }
//     }
//   }
//
//
//   Future<void> _detectFaces(InputImage image) async {
//     if (state.isNotProcessing) {
//       state.startProcessing();
//       state.image = image;
//
//       state.data = await _detector.detect(image);
//
//       state.stopProcessing();
//     }
//   }
//   var _controller = VideoPlayerController.asset('assets/video.mp4');
//
// @override
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//              Scaffold(
//                body: Stack(
//                  children: [
//
//
//
//                    InputCameraView(
//         title: output,
//         onImage: _detectFaces,
//         resolutionPreset: ResolutionPreset.high,
//         overlay: Consumer<FaceDetectionState>(
//           builder: (_, state, __) {
//             if (state.isEmpty) {
//                     return Container();
//             }
//
//             Size originalSize = state.size!;
//             Size size = MediaQuery.of(context).size;
//
//             // if image source from gallery
//             // image display size is scaled to 360x360 with retaining aspect ratio
//             if (state.notFromLive) {
//                     if (originalSize.aspectRatio > 1) {
//                       size = Size(360.0, 360.0 / originalSize.aspectRatio);
//                     } else {
//                       size = Size(360.0 * originalSize.aspectRatio, 360.0);
//                     }
//             }
//
//             return FaceOverlay(
//                     size: size,
//                     originalSize: originalSize,
//                     rotation: state.rotation,
//                     faces: state.data,
//                     contourColor: Colors.white.withOpacity(0.8),
//                     landmarkColor: Colors.lightBlue.withOpacity(0.8),
//             );
//           },
//         ),
//
//     ),
//                    Positioned(top: 3,left: 3,child: InkWell(
//                      onTap:(){
//                        setState(() {
//                          // If the video is playing, pause it.
//                          if (_controller.value.isPlaying) {
//                            _controller.pause();
//                          } else {
//                            // If the video is paused, play it.
//                            _controller.play();
//                          }
//                        });
//                      },
//                      child: Container(
//                        height: 300,
//                        width: 200,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(20),
//                        ),child:FutureBuilder(
//                        future: _controller.initialize(),
//                        builder: (context, snapshot) {
//                          if (snapshot.connectionState == ConnectionState.done) {
//                            // If the VideoPlayerController has finished initialization, use
//                            // the data it provides to limit the aspect ratio of the video.
//                            return AspectRatio(
//                              aspectRatio: _controller.value.aspectRatio,
//                              // Use the VideoPlayer widget to display the video.
//                              child: VideoPlayer(_controller),
//                            );
//                          } else {
//                            // If the VideoPlayerController is still initializing, show a
//                            // loading spinner.
//                            return const Center(
//                              child: CircularProgressIndicator(),
//                            );
//                          }
//                        },
//                      ) ,
//                       ),
//                    ),
//                    ),
//                  ],
//                ),
//              );
//   }
// }
//
// class FaceDetectionState extends ChangeNotifier {
//   InputImage? _image;
//   List<Face> _data = [];
//   bool _isProcessing = false;
//
//   InputImage? get image => _image;
//   List<Face> get data => _data;
//
//   String? get type => _image?.type;
//   InputImageRotation? get rotation => _image?.metadata?.rotation;
//   Size? get size => _image?.metadata?.size;
//
//   bool get isNotProcessing => !_isProcessing;
//   bool get isEmpty => data.isEmpty;
//   bool get isFromLive => type == 'bytes';
//   bool get notFromLive => !isFromLive;
//
//   void startProcessing() {
//     _isProcessing = true;
//     notifyListeners();
//   }
//
//   void stopProcessing() {
//     _isProcessing = false;
//     notifyListeners();
//   }
//
//   set image(InputImage? image) {
//     _image = image;
//
//     if (notFromLive) {
//       _data = [];
//     }
//     notifyListeners();
//   }
//
//   set data(List<Face> data) {
//     _data = data;
//     notifyListeners();
//   }
// }