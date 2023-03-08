import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:job/features/app/presentation/widgets/component.dart';
import 'package:job/utils/colors.dart';

import '../camerScreens/CamerL1.dart';
import '../camerScreens/CamerL2.dart';
import '../camerScreens/CameraL3.dart';
import '../camerScreens/CameraL4.dart';
import '../camerScreens/CameraL5.dart';
import '../cameraCubit/cubitTest/cubit.dart';
import '../cameraCubit/cubitTest/mainLayout.dart';
import 'camera1.dart';

class levelFive extends StatefulWidget {
  levelFive({Key? key}) : super(key: key);

  @override
  State<levelFive> createState() => _levelFiveState();
}

class _levelFiveState extends State<levelFive> {
  double rating =0 ;
  double rating2 = 0 ;
  double rating3 = 0 ;
  double rating4 = 0 ;
  double rating5 = 0;
  double rating6 = 0;

  var color=CLevel5;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppBar(CLevel5, "Level 5",context),
        body: ListView(
          children: [

            Row(
              children: [

                Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rating=4.5;
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
                        rating2=3;
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


                    }, icon:  CircleAvatar(
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
                        updateOnDrag: false,
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
                          rating6=2.5;
                        });
                        Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL4(

                        )));

                      }, icon:   CircleAvatar(
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
    
    
      ),
    );
  }
}
