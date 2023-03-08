import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:job/features/app/presentation/widgets/component.dart';
import 'package:job/utils/colors.dart';
import '../../../../utils/colors.dart';
import '../camerScreens/CamerL2.dart';
import '../camerScreens/CameraL3.dart';
import '../camerScreens/CameraL5.dart';
import '../cameraCubit/cubitTest/cubit.dart';
import '../cameraCubit/cubitTest/mainLayout.dart';
import 'camera1.dart';

class levelSix extends StatefulWidget {
  levelSix({Key? key}) : super(key: key);

  @override
  State<levelSix> createState() => _levelSixState();
}

class _levelSixState extends State<levelSix> {
  double rating =0 ;
  double rating2 = 0 ;
  double rating3 = 0 ;  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(CLevel6, "Level 6",context),
      body: ListView(
        children: [
          
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          rating=5;
                        });
                        Navigator.push (context, MaterialPageRoute(builder: (context)=>

                        CameraScreen(

                        )));
                      },
                      icon: CircleAvatar(
                        backgroundColor: CLevel6,
                        radius: 65,
                        child: CircleAvatar(

                          radius: 60,
                          backgroundImage: AssetImage('images/1.png'),
                        ),
                      ),
                      iconSize: 150,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ]),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              RatingBar.builder(
                initialRating: rating,
                  minRating: 1,
                  itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
                  updateOnDrag: false,
                  itemSize: 30,
                  onRatingUpdate: (rating)=> setState(() {
                    this.rating = rating ;
                  }) )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          rating2=3;
                        });
                        Navigator.push (context, MaterialPageRoute(builder: (context)=>
                            CameraScreenL2(

                        )

                        ));
                      },
                      icon: CircleAvatar(
                        backgroundColor: CLevel6,
                        radius: 65,
                        child: CircleAvatar(
                          backgroundColor: Colors.cyanAccent,
                          radius: 60,
                          backgroundImage: AssetImage('images/2.png'),
                        ),
                      ),
                      iconSize: 150,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ]),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              RatingBar.builder(
                initialRating: rating2,
                  minRating: 1,
                  itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
                  updateOnDrag: false,
                  itemSize: 30,
                  onRatingUpdate: (rating)=> setState(() {
                    this.rating = rating ;
                  }) )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          rating3=4.5;
                        });
                        Navigator.push (context, MaterialPageRoute(builder: (context)=>CameraScreenL5(

                        )));
                      },
                      icon: CircleAvatar(
                        backgroundColor: CLevel6,
                        radius: 65,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/3.png'),
                        ),
                      ),
                      iconSize: 150,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ]),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              RatingBar.builder(
                initialRating: rating3,
                  minRating: 1,
                  itemBuilder: (context, _)=>Icon(Icons.star,color: Colors.amber,),
                  updateOnDrag: false,
                  itemSize: 30,
                  onRatingUpdate: (rating)=> setState(() {
                    this.rating = rating ;
                  }) )
            ],
          ),

        ],
      ),


    );
  }
}
