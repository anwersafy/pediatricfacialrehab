import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:job/features/app/domain/usecases/app_cubit/login_%20cubit.dart';
import 'package:job/features/app/domain/usecases/app_cubit/login_state.dart';
import 'package:job/utils/colors.dart';
import 'package:job/features/app/domain/repositories/cach_helper.dart';

import '../../data/repositories/notification_manager.dart';
import '../widgets/component.dart';

class reminder extends StatefulWidget {
  const reminder({Key? key}) : super(key: key);

  @override
  State<reminder> createState() => _reminderState();
}

class _reminderState extends State<reminder> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(CLevelMain, 'Reminder', context),
            body: Column(
              children: [
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      DateFormat('hh:mm a')
                          .format(DateTime(0, 0, 0, value!.hour, value.minute));
                      setState(() {
                        cubit.hourController = value.hour ?? 9;
                        cubit.minuteController = value.minute ?? 00;

                        CacheHelper.saveData(
                            key: 'hour_reminder', value: value.hour ?? 9);
                        CacheHelper.saveData(
                            key: 'minute_reminder', value: value.minute ?? 00);
                        cubit.hour_reminder =
                            CacheHelper.getData(key: 'hour_reminder');
                        cubit.minute_reminder =
                            CacheHelper.getData(key: 'minute_reminder');
                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 0);
                        cubit.timeController =
                        '${cubit.hour_reminder ?? 9}:${cubit.minute_reminder ??
                            00}';
                      });
                    });
                  },
                  child: reminderWidget(
                      context: context,
                      title: 'Reminder',
                      subtitle: 'Reminder',
                      color: CLevelMain,
                      time: cubit.timeController ??
                          '${cubit.hourController ?? 9}:${cubit.minuteController ?? 00}'),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        DateFormat('hh:mm a').format(
                            DateTime(0, 0, 0, value!.hour, value.minute));
                        setState(() {

                        cubit.hourController1 = value.hour ?? 9;
                        cubit.minuteController1 = value.minute ?? 00;

                        CacheHelper.saveData(
                            key: 'hour_reminder', value: value.hour ?? 9);
                        CacheHelper.saveData(
                            key: 'minute_reminder', value: value.minute ?? 00);
                        cubit.hour_reminder1 =
                            CacheHelper.getData(key: 'hour_reminder');
                        cubit.minute_reminder1 =
                            CacheHelper.getData(key: 'minute_reminder');
                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 1);
                        cubit.timeController1 =
                            '${cubit.hour_reminder1 ?? 9}:${cubit.minute_reminder1 ?? 00}';
                        });

                      });
                    },
                    child: reminderWidget(
                        context: context,
                        title: 'Reminder',
                        subtitle: 'Reminder',
                        color: CLevelMain,
                        time: cubit.timeController1 ??
                            '${cubit.hourController1 ?? 9}:${cubit.minuteController1 ?? 00}')),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        DateFormat('hh:mm a').format(
                            DateTime(0, 0, 0, value!.hour, value.minute));
                        setState(() {
                        cubit.hourController2 = value.hour ?? 9;
                        cubit.minuteController2 = value.minute ?? 00;

                        CacheHelper.saveData(
                            key: 'hour_reminder2', value: value.hour ?? 9);
                        CacheHelper.saveData(
                            key: 'minute_reminder2', value: value.minute ?? 00);
                        cubit.hour_reminder2 =
                            CacheHelper.getData(key: 'hour_reminder2');
                        cubit.minute_reminder2 =
                            CacheHelper.getData(key: 'minute_reminder2');
                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 2);
                        cubit.timeController2 =
                            '${cubit.hour_reminder2 ?? 9}:${cubit.minute_reminder2 ?? 00}';
                        });

                      });
                    },
                    child: reminderWidget(
                        context: context,
                        title: 'Reminder',
                        subtitle: 'Reminder',
                        color: CLevelMain,
                        time: cubit.timeController2 ??
                            '${cubit.hourController2 ?? 9}:${cubit.minuteController2 ?? 00}')),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      DateFormat('hh:mm a')
                          .format(DateTime(0, 0, 0, value!.hour, value.minute));
                      setState(() {
                      cubit.hourController3 = value.hour ?? 9;
                      cubit.minuteController3 = value.minute ?? 00;

                      CacheHelper.saveData(
                          key: 'hour_reminder3', value: value.hour ?? 9);
                      CacheHelper.saveData(
                          key: 'minute_reminder3', value: value.minute ?? 00);
                      cubit.hour_reminder3 =
                          CacheHelper.getData(key: 'hour_reminder3');
                      cubit.minute_reminder3 =
                          CacheHelper.getData(key: 'minute_reminder3');
                      cubit.scheduledNotification(
                          hour: value.hour, minutes: value.minute, id: 3);
                      cubit.timeController3 =
                          '${cubit.hour_reminder3 ?? 9}:${cubit.minute_reminder3 ?? 00}';
                      });

                    });
                  },
                  child: reminderWidget(
                      context: context,
                      title: 'Reminder',
                      subtitle: 'Reminder',
                      color: CLevelMain,
                      time: cubit.timeController3 ??
                          '${cubit.hourController3 ?? 9}:${cubit.minuteController3 ?? 00}'),
                ),
              ],
            ),
          );
        });
  }

  reminderWidget(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required String time,
      required Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CLevelMain,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: CLevelMain,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CLevelMain,
            ),
          ),
        ],
      ),
    );
  }
}
