import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:job/features/app/presentation/cameraCubit/cubitTest/state.dart';
import 'package:job/features/app/presentation/widgets/component.dart';
import 'package:job/utils/colors.dart';

import 'cubit.dart';
import 'package:flutter/material.dart';

class Gallary extends StatefulWidget {
  @override
  _GallaryState createState() => _GallaryState();
}
class _GallaryState extends State<Gallary> {

  late Box box=FaceDetectionCubit().box as Box;





  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<FaceDetectionCubit,FaceDetectionState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            CLevelMain,
            "Gallary",
            context,
          ),
          body: GridView.builder(
            itemCount: FaceDetectionCubit().screenshotPath.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              // final filePath = FaceDetectionCubit().screenshotPath[index];
              // final file = File(filePath);
              return Card(
                child: Image.asset(
                  FaceDetectionCubit().screenshotPath[index],
                  fit: BoxFit.cover,
                ),
              );


            },
          ),
        );
     // }
   // );
  }
}