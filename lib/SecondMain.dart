// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'setPushAlarm.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'listData.dart';
// import 'alarmSetting.dart';

// Future<bool> checkPermission() async {
//   Map<Permission, PermissionStatus> statuses = await [
//     Permission.manageExternalStorage,
//   ].request();
//   bool per = true;
//   statuses.forEach((permission, permissionStatus) {
//     if (!permissionStatus.isGranted) {
//       per = false;
//     }
//   });
//   return per;
// }

// void main() {
//   runApp(SecondMain());
// }

// class SecondMain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SecondMainState(),
//     );
//   }
// }

// class SecondMainState extends StatefulWidget {
//   const SecondMainState({Key? key}) : super(key: key);

//   @override
//   _SecondMainState createState() => _SecondMainState();
// }

// class _SecondMainState extends State<SecondMainState> {
//   static List<ListData> listDatas = [];
//   String _itemName = '음식을 입력하세요';
//   String _expirationDate = DateTime.now().toString().split(' ')[0];
//   String _purchaseDate = DateTime.now().toString().split(' ')[0];

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _readListData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('푸드리스트'),
//           actions: <Widget>[
//             FloatingActionButton(
//                 onPressed: () async {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => MyInfo())
//                   );
//                 },
//                 child: Icon(Icons.menu)
//             )
//           ],
//         ),
//         body: Container(
//           height: _height,
//           width: _width,
//           padding: EdgeInsets.all(5),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       padding: EdgeInsets.all(12),
//                       width: _width * 0.8,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: SingleChildScrollView(
//                           child: DataTable(
//                             columnSpacing: _width * 0.4,
//                             showCheckboxColumn: false,
//                             showBottomBorder: true,
//                             columns: [
//                               DataColumn(
//                                   label: Text(
//                                     '음식',
//                                     style: TextStyle(
//                                         fontSize: 16),
//                                   )),
//                               DataColumn(
//                                   label: Text(
//                                     '유통기한',
//                                     style: TextStyle(
//                                         fontSize: 16),
//                                   )),
//                             ],
//                             rows: listDatas
//                                 .map((data) => DataRow(
//                                 onSelectChanged: (bool? selected) {
//                                   if (selected!) {
//                                     setState(() {
//                                       showDetail(
//                                           context, data, _width, _height);
//                                     });
//                                   }
//                                 },
//                                 cells: [
//                                   DataCell(Text(data.itemName)),
//                                   DataCell(Text(
//                                     data.calLastDate(data),
//                                     style: TextStyle(
//                                         color: data.calColor(data)),
//                                   )),
//                                 ]))
//                                 .toList(),
//                           ),
//                         ),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: Column(
//           children: <Widget>[
//             FloatingActionButton(
//               onPressed: () async {
//                 setState(() {
//                   directInput(context); // 음식 직접 입력
//                 });
//               },
//               heroTag: null,
//               child: Icon(Icons.add),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.end,
//         ));
//   }

//   showDetail(BuildContext context, ListData data, double _width,
//       double _height) async {
//     setState(() {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return StatefulBuilder(builder: (context, setState) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(32.0))),
//                 content: Container(
//                   width: _width * 0.85,
//                   height: _height * 0.53,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "음식",
//                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data.itemName,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   nameModify(context, data);
//                                   _saveListData();
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.grey,
//                               )),
//                         ],
//                       ),
//                       Text(
//                         "구매날짜",
//                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data.purchaseDate,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   showModifyCalender(context, data, "purchase");
//                                   _saveListData();
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.grey,
//                               )),
//                         ],
//                       ),
//                       Text(
//                         "유통기한",
//                         style: TextStyle(color: Colors.grey, fontSize: 16),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data.expirationDate,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   showModifyCalender(context, data, "expire");
//                                   //sortListData(_selectedValue);
//                                   _saveListData();
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.grey,
//                               )),
//                         ],
//                       ),
//                       Center(
//                         child: DialogButton(
//                           child: Text(
//                             "삭제",
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                           onPressed: () {
//                             print("click");
//                             setState(() {
//                               listDatas.remove(data);
//                               pushNotif(listDatas, 1);
//                               _saveListData();
//                               Navigator.pop(context);
//                             });
//                           },
//                           width: _width * 0.5,
//                         ),
//                       )
//                       // ignore: deprecated_member_use
//                     ],
//                   ),
//                 ),
//               );
//             });
//           }).then((value) {
//         setState(() {});
//       });
//     });
//   }

//   void nameModify(BuildContext context, ListData change) async {
//     await showCupertinoDialog(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return CupertinoAlertDialog(
//             title: Text("음식 이름 변경"),
//             actions: <Widget>[
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                     child: CupertinoTextField(
//                       placeholder: "음식",
//                       onChanged: (text) {
//                         setState(() {
//                           change.itemName = text;
//                         });
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       CupertinoButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.pop(context, "저장");
//                             });
//                           },
//                           child: Text(
//                             "저장",
//                           )),
//                       CupertinoButton(
//                           onPressed: () {
//                             setState(() {
//                               Navigator.pop(context, "취소");
//                             });
//                           },
//                           child: Text("취소",
//                               style: TextStyle(color: Colors.red, fontSize: 15))
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   void nameDirectInput(BuildContext context) async {
//     await showCupertinoDialog(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return CupertinoAlertDialog(
//             title: Text("음식 이름을 입력하시오."),
//             actions: <Widget>[
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                     child: CupertinoTextField(
//                       placeholder: "음식",
//                       onChanged: (text) {
//                         _itemName = text;
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       CupertinoButton(
//                           onPressed: () {
//                             Navigator.pop(context, "저장");
//                           },
//                           child: Text("저장",
//                           )
//                       ),
//                       CupertinoButton(
//                           onPressed: () {
//                             Navigator.pop(context, "취소");
//                           },
//                           child: Text("취소",
//                               style: TextStyle(color: Colors.red, fontSize: 15))
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           );
//         });
//   }

//   void showModifyCalender(
//       BuildContext context, ListData data, String selected) async {
//     if (selected == 'purchase')
//       selected = data.purchaseDate;
//     else
//       selected = data.expirationDate;

//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.parse(selected),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selected) {
//       setState(() {
//         if (selected == data.purchaseDate)
//           data.purchaseDate = picked.toString().split(' ')[0];
//         else
//           data.expirationDate = picked.toString().split(' ')[0];
//       });
//     }
//   }

//   void directInput(BuildContext context) async {
//     bool purchaseFlag = false;
//     bool expireFlag = false;
//     bool nameFlag = false;
//     await showCupertinoDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(builder: (context, setState) {
//             return CupertinoAlertDialog(
//               title: Text("음식 추가"),
//               content: Text("음식에 대한 정보를 입력하시오."),
//               actions: <Widget>[
//                 CupertinoDialogAction(
//                     onPressed: () {
//                       setState(() {
//                         showDirectCalender(context, "purchase");
//                         purchaseFlag = true;
//                       });
//                     },
//                     child: Text(
//                       purchaseFlag ? _purchaseDate : "구매한 날짜 입력하기",
//                     )),
//                 CupertinoDialogAction(
//                     onPressed: () {
//                       setState(() {
//                         showDirectCalender(context, "expire");
//                         expireFlag = true;
//                       });
//                     },
//                     child: Text(
//                       expireFlag ? _expirationDate : "유통기한 입력하기",
//                     )),
//                 CupertinoDialogAction(
//                     onPressed: () {
//                       setState(() {
//                         nameDirectInput(context);
//                         nameFlag = true;
//                       });
//                     },
//                     child: Text(nameFlag ? _itemName : "음식 입력하기")),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     CupertinoButton(
//                         onPressed: () {
//                           setState(() {
//                             listDatas.add(ListData(
//                                 purchaseDate: _purchaseDate,
//                                 expirationDate: _expirationDate,
//                                 itemName: _itemName));
//                             //sortListData(_selectedValue);
//                             Navigator.pop(context, "저장");
//                           });
//                           pushNotif(listDatas, 1);
//                           _saveListData();
//                         },
//                         child: Text("저장")),
//                     CupertinoButton(
//                         onPressed: () {
//                           Navigator.pop(context, "취소");
//                         },
//                         child: Text("취소",
//                             style: TextStyle(color: Colors.red, fontSize: 15))),
//                   ],
//                 ),
//               ],
//             );
//           });
//         }).then((value) {
//       setState(() {});
//     });
//   }

//   void showDirectCalender(BuildContext context, String selected) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selected) {
//       setState(() {
//         if (selected == 'purchase')
//           _purchaseDate = picked.toString().split(' ')[0];
//         else
//           _expirationDate = picked.toString().split(' ')[0];
//       });
//     }
//   }

//   List<String> toStringList(List<ListData> data) {
//     List<String> ret = [];
//     for (int i = 0; i < data.length; i++) {
//       ret.add(data[i].toString());
//     }
//     return ret;
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

//   _saveListData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'ListData';
//     final value = toStringList(listDatas);
//     prefs.setStringList(key, value);
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<dynamic> foodList = [];
  // List<String> foodList = [];

  Future<void> fetchFoodList() async {
    final response = await http.get(Uri.parse('http://hyunssoo.asuscomm.com:44339/refresh_app/foodlist/'),headers: {'Accept-Charset': 'utf-8'});
    if (response.statusCode == 200) {
      setState(() {
        // print(response.bodyBytes);
        // print(utf8.decode(response.bodyBytes));
        // foodList = json.decode(response.body);
        // foodList = utf8.decode(response.bodyBytes);
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        foodList = decodedResponse;
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
        title: Text('푸드리스트'),
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
                Text('유통기한 : ${food['expire_date']}'),
                Text('구매일자 : ${food['buy_date']}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddFoodDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // void openAddFoodDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       String? foodName;
  //       String? expireDate;
  //       String? purchaseDate;

  //       return AlertDialog(
  //         title: Text('음식추가'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               decoration: InputDecoration(labelText: '음식명'),
  //               onChanged: (value) => foodName = value,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(labelText: '유통기한'),
  //               onChanged: (value) => expireDate = value,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(labelText: '구매일자'),
  //               onChanged: (value) => purchaseDate = value,
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               if (foodName != null && expireDate != null && purchaseDate != null) {
  //                 final food = {
  //                   '음식명': foodName,
  //                   '유통기한': expireDate,
  //                   '구매일자': purchaseDate,
  //                 };
  //                 addFoodToList(food);
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void openAddFoodDialog(BuildContext context) {
    String? foodName;
    DateTime? expireDate;
    DateTime? buyDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('음식추가'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: '음식명'),
                    onChanged: (value) => foodName = value,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        setState(() {
                          expireDate = selectedDate;
                        });
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        expireDate != null
                            ? DateFormat('yyyy-MM-dd').format(expireDate!)
                            : '유통기한',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        setState(() {
                          buyDate = selectedDate;
                        });
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        buyDate != null
                            ? DateFormat('yyyy-MM-dd').format(buyDate!)
                            : '구매일자',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (foodName != null && expireDate != null && buyDate != null) {
                      final food = {
                        'food_name': foodName,
                        'expire_date': DateFormat('yyyy-MM-dd').format(expireDate!),
                        'buy_date': DateFormat('yyyy-MM-dd').format(buyDate!),
                      };
                      // addFoodToList(food);
                      print(food);
                      sendFoodData(food);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void addFoodToList(Map<String, dynamic> food) {
    setState(() {
      foodList.add(food);
    });
  }

  // Future<void> sendFoodData(Map<String, dynamic> food) async {
  //   final url = 'http://hyunssoo.asuscomm.com:44339/refresh_app/food/';
  //   final headers = {'Content-Type': 'application/json'};

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: jsonEncode(food),
  //   );
  //   print("test2");
  //   print(jsonEncode(food));
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     // Success
  //     print('Food data sent successfully');
  //   } else {
  //     // Error
  //     print('Failed to send food data');
  //   }
  // }
  Future<void> sendFoodData(Map<String, dynamic> food) async {
    final url = 'http://hyunssoo.asuscomm.com:44339/refresh_app/food/';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['food_name'] = food['food_name'];
    request.fields['expire_date'] = food['expire_date'];
    request.fields['buy_date'] = food['buy_date'];

    final response = await request.send();

    if (response.statusCode == 200) {
      // Success
      print('Food data sent successfully');
      fetchFoodList();
    } else {
      // Error
      print('Failed to send food data');
    }
  }
}

// class FoodListBuilder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Food List'),
//       ),
//       body: FutureBuilder(
//         future: http.get(Uri.parse('http://hyunssoo.asuscomm.com:44339/refresh_app/foodlist/'),headers: {'Accept-Charset': 'utf-8'}),
//         builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             if (snapshot.data!.statusCode == 200) {
//               final foodList = json.decode(snapshot.data!.body);
//               return ListView.builder(
//                 itemCount: foodList.length,
//                 itemBuilder: (context, index) {
//                   final food = foodList[index];
//                   return ListTile(
//                     title: Text(food['food_name']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('유통기한 : ${food['expire_date']}'),
//                         Text('구매일자: ${food['buy_date']}'),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(
//                 child: Text('Failed to fetch food list'),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }
