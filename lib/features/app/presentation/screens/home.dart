import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/utils/colors.dart';

import '../../data/repositories/notification_manager.dart';
import '../../domain/usecases/app_cubit/login_ cubit.dart';
import '../../domain/usecases/app_cubit/login_state.dart';
import '../cameraCubit/cubitTest/cubit.dart';
import '../widgets/component.dart';
import 'camera1.dart';
import 'levels.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final Widget? startwidget;
  MyApp({
    this.startwidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
          return MultiBlocProvider(providers: [

        BlocProvider<AppCubit>(create: (_) => AppCubit(),),
        BlocProvider<FaceDetectionCubit>(create: (_) => FaceDetectionCubit(),),

    ],
            child:MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          debugShowCheckedModeBanner: false,
          home: startwidget,
          )
          );


  }
}
