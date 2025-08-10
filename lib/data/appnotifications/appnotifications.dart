


import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:iot/allpaths.dart';

Future<void> initializednotifications()async{
  await AwesomeNotifications().initialize(
      null, [
     NotificationChannel(
         channelKey: "iotelectric",
         channelName: "iotelectric",
         channelDescription: "iotelectric",
       channelGroupKey: "iotelectric",
       defaultColor: Colors.blue,
       importance: NotificationImportance.Max,
       onlyAlertOnce: true,
       ledColor: Colors.blue,
       playSound: true,
       channelShowBadge: true,
       criticalAlerts: true,
     ),
  ],debug: true,channelGroups: [
    NotificationChannelGroup(channelGroupKey: "iotelectric",
        channelGroupName: "iotelectric"),
  ]);

  await AwesomeNotifications().isNotificationAllowed().then((isallowed)async{
    if(!isallowed){
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().setListeners(
      onActionReceivedMethod: onNotificationcreatedmethod,
    onDismissActionReceivedMethod:onDismissActionReceivedMethod ,
    onNotificationCreatedMethod:onNotificationCreatedMethod ,
    onNotificationDisplayedMethod:onActionReceivedMethod ,
  );
}

Future<void>onNotificationCreatedMethod(ReceivedNotification action)async{
  print("");
}

Future<void>onActionReceivedMethod(ReceivedNotification action)async{
  print("");
}
 Future<void>onDismissActionReceivedMethod(ReceivedAction action)async{
  debugPrint("");
 }

 Future<void>onNotificationcreatedmethod(ReceivedAction action)async{
  debugPrint("");
  final payload = action.payload??{};
  if(payload["navigate"] == "true"){
    MyApp.navigatorKey.currentState?.pushNamed(RoutesNames.homescreen);
  }
 }


 Future<void>shownotifications({
  required String title,
   required String body,
   String?summary,
   String?bigpicture,
   Map<String,String>?payload,
   ActionType actiontype = ActionType.Default,
   NotificationLayout notificationlayout = NotificationLayout.Default,
   NotificationCategory?categry,
   final List<NotificationActionButton>? actionbutton,
   final bool schlod = false,
   final Duration?interval
})async{
    assert(!schlod ||(schlod && interval != null));
   await AwesomeNotifications().createNotification(
  content: NotificationContent(
id: -1,
channelKey: "iotelectric",
actionType:actiontype ,
bigPicture: bigpicture,
category: categry,
notificationLayout:notificationlayout ,
payload: payload,
summary: summary,
body: body,
title: title,
),actionButtons: actionbutton,
     schedule: schlod?NotificationInterval(interval: interval,
     timeZone:await AwesomeNotifications.localTimeZoneIdentifier ,
     repeats: true,
     preciseAlarm: true):null
   );
}