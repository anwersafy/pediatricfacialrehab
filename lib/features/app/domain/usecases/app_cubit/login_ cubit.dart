import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hive/hive.dart';
import 'package:learning_face_detection/learning_face_detection.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/user.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/database_helper.dart';
import '../../../data/repositories/notification_manager.dart';
import '../../../presentation/screens/levels.dart';
import '../../../presentation/widgets/component.dart';
import '../../repositories/cach_helper.dart';
import '../../repositories/constant.dart';
import 'login_state.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(LoginInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // void signUp(
  //     {required String username,
  //     required String password,
  //     required BuildContext context}) async {
  //   emit(LoginLoadingState());
  //   await insertDatabase(username: username, password: password).then((value) {
  //     if (value != null) {
  //       // CacheHelper.saveData(key: "username", value: username);
  //       // CacheHelper.saveData(key: 'password', value: password);
  //       navigateTo(
  //         context: context,
  //         widget: levelsScreen(),
  //       );
  //
  //       CacheHelper.putBoolean(key: 'active', value: true).then((value) {
  //         emit(LoginSuccessState());
  //       });
  //     } else {
  //       emit(LoginFailureState(error: 'Error'));
  //     }
  //   });
  // }
  var playerName;
  var playerPassword;

  void login({required String username, required String password}) async {
    emit(LoginLoadingState());
    CacheHelper.saveData(key: "username", value: username);
    CacheHelper.saveData(key: 'password', value: password);
    CacheHelper.saveData(key: "active", value: true);
    playerName=CacheHelper.getData(key: 'username');
    playerPassword=CacheHelper.getData(key: 'password');
    emit(LoginSuccessState());
  }

  void logout() {
    CacheHelper.putBoolean(key: 'active', value: false);
    CacheHelper.removeData(key: 'username');
    CacheHelper.removeData(key: 'password');

    usernameController.clear();
    passwordController.clear();
    emit(LoginInitial());
  }
//    FlutterLocalNotificationsPlugin notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   static final onNotificationClick = BehaviorSubject<String?>();
//
//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max,
//             icon: "@mipmap/ic_launcher"),
//         iOS: DarwinNotificationDetails());
//   }
//   Future initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings("@mipmap/ic_launcher");
//
//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});
//
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     await notificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (payload) async {
//           // if (payload != null) {
//           //   print('notification payload: ' + payload);
//           // }
//            onNotificationClick.add(payload.payload);
//
//         }
//     );
//   }
//   listenToNotificationClick(context) {
//     return onNotificationClick.stream.listen(onClickNotification(context: context));
//   }
//
//
// onClickNotification({required BuildContext context}) =>
//
//
//    navigateToAndFinish(context: context, widget: levelsScreen());
//
//
// Future<void> showNotification(
//   {
//     int id = 0,
//     required String title,
//     required String body,
//     required String payload,
//
// }
//
//     ) async {
//     var androidDetails = AndroidNotificationDetails(
//         'channelId', 'channelName', channelDescription: 'channelDescription',
//         importance: Importance.max,
//         icon: "@mipmap/ic_launcher",
//         // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
//     );
//     var iosDetails = DarwinNotificationDetails();
//     var generalNotificationDetails =
//         NotificationDetails(android: androidDetails, iOS: iosDetails);
//     await notificationsPlugin.show(
//         id, title, body, generalNotificationDetails,
//         payload: payload);
//   }
//   Future showNotifications({int id=3, required String title, required String body,required String payload}) async {
//     await notificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
//       await notificationDetails(),//schedule the notification to show after 2 seconds.
// payload: payload,
//         // iOS details
//         // iOS: IOSNotificationDetails(
//         //   sound: 'default.wav',
//         //   presentAlert: true,
//         //   presentBadge: true,
//         //   presentSound: true,
//         // ),
// matchDateTimeComponents: DateTimeComponents.time,
//
//       // Type of time interpretation
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true, // To show notification even when the app is closed
//     );
//   }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    // const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("app_icon");
     var initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {

      }
    );

     InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,

    );
    emit(InitializeNotificationState());

  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    emit(SetTimeNotificationState());

    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Scheduled Notification
  scheduledNotification({
    required int hour,
    required int minutes,
    required int id,
    //required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'It\'s time to Play',
      'See you there',
      _convertTime(hour, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          //'your channel id $sound',
          'your channel id',
          'your channel name',
           channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
        //iOS: IOSNotificationDetails(sound: '$sound.mp3'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'It could be anything you pass',
    );
    emit(ScheduledNotificationState());
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    emit(RequestIOSPermissionState());
  }

  cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    emit(CancelAllNotificationState());
  }
  cancel(id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    emit(CancelNotificationState());
  }

  List? images = [];

  List? pickedImages;
  List imagesAsBytes = [];//List of images converted to bytes
  var imageObj = UserModel();
  List<UserModel> useModelList=[];
  //var userBox = Hive.box('users');
  userLogin(
      UserModel  model

      ){
    emit(UserLoginLoadingState());
    {
     // var users = Hive.box('users');
      //users.put('user', model);
      useModelList.add(model);
      emit(UserLoginSuccessState());
    }
  }


var timeController;
var hourController;
var minuteController ;
var hour_reminder;
var minute_reminder;

  var timeController1;
  var hourController1;
  var minuteController1 ;
  var hour_reminder1;
  var minute_reminder1;

  var timeController2;
  var hourController2;
  var minuteController2 ;
  var hour_reminder2;
  var minute_reminder2;

  var timeController3;
  var hourController3;
  var minuteController3 ;
  var hour_reminder3;
  var minute_reminder3;

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    emit(OnSelectNotificationState());
    return Future.value(0);
  }

  void onDidReceiveNotificationResponse( notificationResponse,BuildContext context) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => levelsScreen()),
    );
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
var faceDetector =FaceDetector();
  // var image;
  // var smileCounter = 0;
  // var smileThreshold = 0.5;
  // var intervalTimer;
  // var _smileCounter = 0;
  int progress = 0;
  Future detectEmotion(
  {
    required File imageFile,
    required int smileCounter,
    required double smileThreshold,
    required Timer intervalTimer,
    required dynamic face,
    //required int smileCounter,


}
      )async{


      final smileProb = face.smilingProbability ?? 0.0;
      if (smileProb > smileThreshold) {
        // Increment the smile counter
        smileCounter++;
        emit(DetectEmotionSmileState());

        if (smileCounter == 1) {
          // Start the 10-second interval
          intervalTimer = Timer(Duration(seconds: 10), () {
            // Output the number of times the user smiled
            progress=smileCounter;
            print('Number of smiles: $smileCounter');
            // Reset the smile counter
            smileCounter = 0;
            if(smileCounter==10){
              progress=smileCounter;

              emit(DetectEmotionSmileSuccessState());
            }
          });
        }
      }
    }

    var videoPlayerController;
  //var videoPlayerController=videoPlayerController.asset('assets/videos/1.mp4');

  }



