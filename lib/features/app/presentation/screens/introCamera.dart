// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:job/features/app/data/models/user_model.dart';
// import 'package:job/features/app/presentation/screens/levels.dart';
//
// import '../../domain/usecases/app_cubit/login_ cubit.dart';
// import '../../domain/usecases/app_cubit/login_state.dart';
//
// class CameraIntro extends StatelessWidget {
//   const CameraIntro({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppState>(
//         listener: (context, state) {
//           if (state is LoginSuccessState) {
//             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => levelsScreen()), (route) => false);
//           }
//         },
//       builder: (context,state) {
//         return Scaffold(
//             body: SmartFaceCamera(
//               showCameraLensControl: false,
//               showCaptureControl: false,
//               showControls: false,
//               autoCapture: true,
//               defaultCameraLens: CameraLens.front,
//               message: 'Center your face in the square',
//               onCapture: (File? image){
//           if (image == null) return;
//
//           for (var i in AppCubit.get(context).images!) {
//             File file = File(i.path);
//             AppCubit.get(context).imagesAsBytes.add(file.readAsBytesSync());
//           }
//           AppCubit.get(context).imageObj.image = AppCubit.get(context).imagesAsBytes;
//           var model=UserModel(
//             name: AppCubit.get(context).usernameController.text,
//             image: AppCubit.get(context).imageObj.image,
//             password: AppCubit.get(context).passwordController.text
//           );
//           AppCubit.get(context).userBox.put('image', AppCubit.get(context).imageObj.image);
//           AppCubit.get(context).userLogin(model);
//
//
//         }
//
//
//
//             )
//         );
//       }
//     );
//   }
// }