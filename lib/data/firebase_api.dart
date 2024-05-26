import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/constants.dart';

// class FirebaseApi{
//
// final _firebaseMessaging = FirebaseMessaging.instance;
//
// Future<void> initNotifications() async{
// await _firebaseMessaging.requestPermission();
// final fCMToken = await _firebaseMessaging.getToken();
// print('FirebaseToken: $fCMToken');
//
// }
//
// }


class NotificationServices{

FirebaseMessaging messaging = FirebaseMessaging.instance;

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<String> getDeviceToken()async{
  String? token = await messaging.getToken();
  fcmToken = await messaging.getToken();
  return token!;
}

void isRefreshToken()async{

  messaging.onTokenRefresh.listen((event) {
    event.toString();
  });

}

void requestNotificationPermissions()async{
  if(Platform.isIOS){
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

  }

  NotificationSettings notificationSettings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    sound: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
  );
if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
  print('user  already granted permissions');
  print('fcmToken=>$fcmToken');

}else if(notificationSettings.authorizationStatus ==AuthorizationStatus.provisional){

  print('user already granted provisional permissions');
  print('fcmToken=>$fcmToken');

}else{

  print('User has denied permission');
}

}

Future foregroundMessage() async{
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true
  );



}

void firebaseInit(BuildContext context){

  FirebaseMessaging.onMessage.listen((message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;

    print("Notification title: ${notification!.title}");
    print("Notification title: ${notification!.body}");
    print("Notification title: ${message.data.toString()}");


 if(Platform.isIOS){
   foregroundMessage();
 }
 if(Platform.isAndroid){
initLocalNotifications(context, message);
showNotification(message);
 }

  });

}


void initLocalNotifications(BuildContext context, RemoteMessage message)async{
  var androidInitSettings = const AndroidInitializationSettings('@mipmap-hdpi/ic_launcher');
var iosInitSettings = const DarwinInitializationSettings();

var initSettings = InitializationSettings(

  android: androidInitSettings,
  iOS: iosInitSettings,

);
 await _flutterLocalNotificationsPlugin.initialize(initSettings,onDidReceiveNotificationResponse: (payload){
   handleMessage(context, message);
 });



}

void handleMessage(BuildContext context, RemoteMessage message){
  print('In HandleMessage function');
  if(message.data['type']=='text'){

  }
}
Future<void> showNotification(RemoteMessage message)async{
  AndroidNotificationChannel androidNotificationChannel =
  AndroidNotificationChannel(message.notification!.android!.channelId.toString(),
    message.notification!.android!.channelId.toString(),importance: Importance.max,
      showBadge: true,
        playSound: true,

      );
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(androidNotificationChannel.id.toString(), androidNotificationChannel.name.toString(),
  channelDescription: "Flutter Noti",
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    ticker: 'ticker',
    //sound:  androidNotificationChannel.sound
    sound: RawResourceAndroidNotificationSound('notification')
  );


  const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
 );

  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails, iOS: darwinNotificationDetails
  );

  Future.delayed(Duration.zero,(){
    _flutterLocalNotificationsPlugin.show(0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
       notificationDetails);

  });

}

}