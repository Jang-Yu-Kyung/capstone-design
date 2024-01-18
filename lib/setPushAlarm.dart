// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'listData.dart';
// import 'alarmSetting.dart';

// //int alarmCycle = 3; // 유통기한 만료 알림 기간

// Future pushNotif(List<ListData> listDatas, int check) async {
//   final notiTitle = '냉장고'; // 알림 제목
//   final notiDesc = '유통기한이 임박한 식품이 있어요!'; // 알림 설명

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final result = await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       IOSFlutterLocalNotificationsPlugin>()
//       ?.requestPermissions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   var android = AndroidNotificationDetails(
//     'id', // 채널 ID
//     notiDesc, // 채널 설명
//     importance: Importance.max,
//     priority: Priority.max,
//   );
//   var detail = NotificationDetails(android: android);

//   if (result!) {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.deleteNotificationChannelGroup('id'); // 안드로이드에서 기존의 채널 그룹 삭제
//   }
//   if (check != -1) {
//     for (int i = 0; i < listDatas.length; i++) {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         0, // 알림 ID
//         notiTitle,
//         notiDesc,
//         _setNotiTime(i, listDatas), // 알림이 설정될 시간
//         detail,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }
// }

// tz.TZDateTime _setNotiTime(int index, List<ListData> listDatas) {
//   tz.initializeTimeZones();
//   tz.setLocalLocation(tz.getLocation('Asia/Seoul')); // 로컬 시간대를 'Asia/Seoul'로 설정
//   var tmp = listDatas[index].expirationDate.split('-');
//   var alarmDate = [
//     int.parse(tmp[0]), // 연도
//     int.parse(tmp[1]), //월
//     int.parse(tmp[2]), //일
//   ];
//   if (alarmDate[2] - alarmCycle < 0) {
//     alarmDate[1]--; // 월을 하나 줄임
//     if (alarmDate[1] <= 7 && alarmDate[1] % 2 == 1 ||
//         alarmDate[1] > 7 && alarmDate[1] % 2 == 0)
//       alarmDate[2] = 31 + alarmDate[2] - alarmCycle; // 일을 유통기한 만료 알림 주기만큼 뺌
//     else
//       alarmDate[2] = 30 + alarmDate[2] - alarmCycle; // 일을 유통기한 만료 알림 주기만큼 뺌
//   } else {
//     alarmDate[2] -= alarmCycle; // 일을 유통기한 만료 알림 주기만큼 뺌
//   }
//   return tz.TZDateTime(
//       tz.local, alarmDate[0], alarmDate[1], alarmDate[2], 10, 00); // 알림이 설정될 시간을 반환
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<dynamic> foodList = [];

  Future<void> fetchFoodList() async {
    final response = await http.get(Uri.parse('http://hyunssoo.asuscomm.com:44339/refresh_app/foodlist/'));
    if (response.statusCode == 200) {
      setState(() {
        foodList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch food list');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          final food = foodList[index];
          return ListTile(
            title: Text(food['food_name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expire Date: ${food['expire_date']}'),
                Text('Purchase Date: ${food['purchase_date']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
