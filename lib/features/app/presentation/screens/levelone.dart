import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:job/features/app/presentation/cameraCubit/cubitTest/cubit.dart';
import 'package:job/features/app/presentation/widgets/component.dart';
import 'package:job/utils/colors.dart';
import '../camerScreens/CamerL1.dart';
import '../camerScreens/CamerL2.dart';
import '../camerScreens/CameraL3.dart';
import '../camerScreens/CameraL4.dart';
import '../camerScreens/CameraL5.dart';
import '../cameraCubit/cubitTest/state.dart';
import 'camera1.dart';
import 'package:job/features/app/presentation/cameraCubit/cubitTest/mainLayout.dart';

class levelOne extends StatefulWidget {
   levelOne({Key? key}) : super(key: key);

  @override
  State<levelOne> createState() => _levelOneState();
}

class _levelOneState extends State<levelOne> {
  double rating =0 ;
  double rating2 = 0 ;
  double rating3 = 0 ;
  double rating4 = 0 ;
  double rating5 = 0;
  double rating6 = 0;

  var assetVide=FaceDetectionCubit().videoAssets;
  var color=CLevel1;


  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<FaceDetectionCubit, FaceDetectionState>(
        listener: (context, state) {

    },

      builder: (context, state) {
        return
    SafeArea(
    child: Scaffold(
    backgroundColor: Colors.white,
    appBar: defaultAppBar( CLevel1,"Level 1",context),
    body:ListView(
    children: [

    Row(
    children: [

    Column(
    children: [
    IconButton(
    onPressed: () {
      setState(() {
        rating=3;
      });
    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreen(

    )));
    },
    icon: CircleAvatar(
    backgroundColor: color,
    radius: 65,
    child: CircleAvatar(

    radius: 60,
    backgroundImage: AssetImage('images/asset-1.png'),
    ),
    ),
    iconSize: 150,
    ),
    SizedBox(
    height:MediaQuery.of(context).size.height *0.01,
    ),
    RatingBar.builder(
    initialRating: rating,

    minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false,
    itemSize: 24,
    onRatingUpdate: (rating)=> rating

    )
    ]),
    SizedBox(width: MediaQuery.of(context).size.width *0.05,),
    Column(
    children: [
    IconButton(onPressed: () {
      setState(() {
        rating2=4;
      });
    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL1(

    )));


    },
    icon: CircleAvatar(
    backgroundColor: color,
    radius: 65,
    child: CircleAvatar(
    radius: 60,
    backgroundImage: AssetImage('images/asset-2.png'),
    ),
    ),
    iconSize: 150,
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height *0.01,
    ),
    RatingBar.builder(
        initialRating: rating2,

        minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false,
    itemSize: 24,
    onRatingUpdate: (rating)=> rating )
    ],
    ),

    ],
    ),
    SizedBox(height: MediaQuery.of(context).size.height *0.01,),
    Row(
    children: [
    SizedBox(width: MediaQuery.of(context).size.width *0.05,),

    Column(
    children: [
    IconButton(onPressed: () {
      setState(() {
        rating3=5;
      });

    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL5(

    )));

    },
    icon:
    CircleAvatar(
    backgroundColor: color,
    radius: 65,
    child: CircleAvatar(
    radius: 60,
    backgroundImage: AssetImage('images/asset-3.png'),
    ),
    ),
    iconSize: 140,

    ),
    SizedBox(
    height: MediaQuery.of(context).size.height *0.001,
    ),
    RatingBar.builder(
        initialRating: rating3,

        minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false,
    itemSize: 24,
    onRatingUpdate: (rating)=> rating )
    ],
    ),
    SizedBox(width: MediaQuery.of(context).size.width *0.05,),
    Column(
    children: [
    IconButton(onPressed: (){
      setState(() {
        rating4=3;

      });
    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreen(


    ))
    );


    }, icon: CircleAvatar(
    backgroundColor: color,
    radius: 65,
    child: CircleAvatar(

    radius: 60,
    backgroundImage: AssetImage('images/asset-4.png'),
    ),
    ),iconSize: 140,),
    SizedBox(
    height: MediaQuery.of(context).size.height *0.001,
    ),
    RatingBar.builder(
      initialRating: rating4,

        minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false,
    itemSize: 24,
    onRatingUpdate: (rating)=> rating )
    ],
    ),

    ],
    ),
    SizedBox(height: MediaQuery.of(context).size.height *0.01,),
    Row(
    children: [
    Column(
    children: [
    IconButton(onPressed: (){
      setState(() {
        rating5=2;
      });

    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL2(

    )));


    }, icon: CircleAvatar(
    backgroundColor: color,
    radius: 65,
    child: CircleAvatar(
    radius: 60,
    backgroundImage: AssetImage('images/angry_.jpg'),
    ),
    ),
    iconSize: 140,
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height *0.001,
    ),
    RatingBar.builder(
      initialRating: rating5,
    minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false ,
    itemSize: 24,
    onRatingUpdate: (rating)=> rating )
    ],
    ),
    SizedBox(width: MediaQuery.of(context).size.width *0.1),
    Column(
    children: [
    IconButton(
    onPressed: () {
      setState(() {
        rating6=5;
      });
    Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL4(

    )));

    }, icon: CircleAvatar(
    radius: 65,
    backgroundColor: color,
    child: CircleAvatar(
    radius: 60,
    backgroundImage: AssetImage('images/asset-5.png'),
    ),
    ),
    iconSize: 140,
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height *0.001,
    ),
    RatingBar.builder(
      initialRating: rating6,
    minRating: 1,
    itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
    updateOnDrag: false,
    itemSize: 24,
    onRatingUpdate: (rating)=>rating),
    ],
    ),

    ],
    ),
    SizedBox(height: MediaQuery.of(context).size.height *0.01,),


    ],
    )
    ,


    ),
    );


    }
    );
    }
    }








