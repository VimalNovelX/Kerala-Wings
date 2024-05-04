
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAlert{
static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{

  var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
  //var iOSInitialize = new IOSInitializationSettings();
  var initializationsSettings = new InitializationSettings(android: androidInitialize);
  await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
}

static Future showBigTextNotification({var id =0, required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln})
async
{
  AndroidNotificationDetails androidPlatformChannelSpecifics =

      new AndroidNotificationDetails('Kerala Wings', 'Kerala Wings notification',playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        priority: Priority.high,

      );

  var not = NotificationDetails(android: androidPlatformChannelSpecifics);

  await fln.show(0,title,body,not);


}




}
