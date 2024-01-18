// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'setPushAlarm.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'listData.dart';

// class MyInfo extends StatefulWidget {
//   const MyInfo({Key? key}) : super(key: key);

//   @override
//   _MyInfoState createState() => _MyInfoState();
// }

// int alarmCycle = 3; // 유통기한 만료 알림 기간

// class _MyInfoState extends State<MyInfo> {
//   final _alarmCycleList = List.generate(10, (i) => i);

//   final _textFormController = TextEditingController();

//   static bool _alarmIsOn = true; // 유통기한 만료 알림 여부
//   late List<ListData> listDatas = [];
//   int profileSelect = 0;
//   int alarmHour = 10;
//   int alarmMinute = 0;
//   @override
//   void initState() {
//     super.initState();

//     // myController에 리스너 추가료
//     _textFormController.addListener(_printLatestValue);
//     setState(() {
//       _readAlarmData();
//       _readListData();
//       _readAlarmTime();
//     });
//   }

//   // myController의 텍스트를 콘솔에 출력하는 메소드
//   void _printLatestValue() {
//     print("Second text field: ${_textFormController.text}");
//   }

//   // _MyCustomFormState가 제거될 때 호출
//   @override
//   void dispose() {

//     // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
//     _textFormController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('알림 설정')),
//       body: Center(
//         child: Container(
//           width: _width * 0.9,
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "알림설정",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               ),
//               alarmSetting(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   alarmTimeSetting() {
//     Builder(builder: (context) {
//       return OutlinedButton(
//           onPressed: () {
//             showTimePicker(
//                 context: context,
//                 initialTime: TimeOfDay(hour: alarmHour, minute: alarmMinute));
//           },
//           child: Text("알람 시간 변경"));
//     });
//   }

//   // 알림 설정 위젯
//   Widget alarmSetting() {
//     _readAlarmData();
//     // 컨테이너 가운데 정렬
//     return Center(
//       child: Container(
//         // 컨테이너 화면 비율 기준 가로 90% 만 차지
//         width: MediaQuery.of(context).size.width * 0.9,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "유통기한 만료 알림",
//                   style: TextStyle(fontSize: 14),
//                 ),
//                 // on off 스위치
//                 CupertinoSwitch(
//                   value: _alarmIsOn,
//                   onChanged: (bool value) {
//                     setState(() {
//                       // 스위치가 꺼진다면 알림 사이클을 0으로 켜진다면 3으로 디폴트값
//                       print("value = $value");
//                       alarmCycle = value ? 3 : 0;
//                       _alarmIsOn = value;
//                       _saveAlarmData();
//                       pushNotif(listDatas, -1);
//                     });
//                   },
//                 ),
//               ],
//             ),
//             // CuperionoPopup에 있는 context가 상위 context를 의미하기 때문에 builder로 상위 context 만들어줌
//             Builder(builder: (BuildContext context) {
//               // _readAlarmData();
//               return OutlinedButton(onPressed: () async {
//                 await showCupertinoModalPopup(
//                     context: context,
//                     builder: (context) => Container(
//                       height: 200.0,
//                       child: CupertinoPicker(
//                         backgroundColor: Colors.white,
//                         children: _alarmCycleList
//                             .map((e) => Text("$e일 전"))
//                             .toList(),
//                         itemExtent: 50.0,
//                         scrollController:
//                         FixedExtentScrollController(initialItem: 1),
//                         onSelectedItemChanged: (int index) {
//                           setState(() {
//                             // _readAlarmData();
//                             // 알림이 꺼져있는데 기간을 조정하면 알림 켬
//                             if (!_alarmIsOn) _alarmIsOn = true;
//                             // 알람 주기를 0으로 설정하면 알림 끔
//                             if (index == 0) _alarmIsOn = false;
//                             alarmCycle = _alarmCycleList[index];
//                             _saveAlarmData();
//                             pushNotif(listDatas, 1);
//                           });
//                         },
//                       ),
//                     ));
//               }, child: Builder(builder: (BuildContext context) {
//                 // _readAlarmData();
//                 // print("alarm cycle == $_alarmCycle");
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("만료 $alarmCycle일 전",
//                         style: TextStyle(fontSize: 15, color: Colors.black)),
//                     Icon(
//                         Icons.expand_more
//                     ),
//                   ],
//                 );
//               }));
//             }),
//             Builder(builder: (context) {
//               var alarmTime =
//               DateFormat('HH:mm').parse("$alarmHour:$alarmMinute");
//               return OutlinedButton(
//                   onPressed: () {
//                     Future<TimeOfDay?> selectedTime = showTimePicker(
//                         context: context,
//                         initialTime:
//                         TimeOfDay(hour: alarmHour, minute: alarmMinute));
//                     selectedTime.then((selectedTime) {
//                       setState(() {
//                         alarmHour = selectedTime!.hour;
//                         alarmMinute = selectedTime.minute;
//                         _saveAlarmTime();
//                         print(alarmHour);
//                         print(alarmMinute);
//                       });
//                     });
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("알림 시간: ${DateFormat('HH:mm').format(alarmTime)}",
//                           style: TextStyle(fontSize: 15, color: Colors.black)),
//                       Icon(
//                           Icons.expand_more
//                       ),
//                     ],
//                   ));
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   _saveAlarmData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'alarmCycle';
//     final value = alarmCycle;
//     prefs.setInt(key, value);
//     // print('saved $value');
//   }

//   _readAlarmData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'alarmCycle';
//     final value = prefs.getInt(key);
//     alarmCycle = value ?? 3;
//     // print("read: ${_alarmCycle}");
//   }

//   _saveAlarmTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'alarmTime';
//     final value = "$alarmHour:$alarmMinute";
//     prefs.setString(key, value);
//     // print('saved $value');
//   }

//   _readAlarmTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'alarmTime';
//     final value = prefs.getString(key);
//     if (value == null) {
//       alarmHour = 3;
//       alarmMinute = 30;
//     } else {
//       alarmHour = int.parse(value.split(':')[0]);
//       alarmMinute = int.parse(value.split(':')[1]);
//     }
//   }

//   _readListData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'ListData';
//     final value = prefs.getStringList(key);
//     try {
//       if (listDatas.isEmpty) {
//         for (int i = 0; i < value!.length; i++) {
//           print(value[i]);
//           var list = value[i].split('/');
//           listDatas.add(ListData(
//               purchaseDate: list[0],
//               expirationDate: list[1],
//               itemName: list[2]));
//         }
//       }
//     } catch (e) {
//       return 0;
//     }
//   }
// }