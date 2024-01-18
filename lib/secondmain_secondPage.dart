import 'package:flutter/material.dart';
import '../foodItem.dart';

class SecondApp extends StatefulWidget {
  final List<Food>? list; // Food List 선언
  SecondApp({Key? key, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  final nameController = TextEditingController();

  int? _radioValue = 0;
  String? _imagePath; // 음식 이미지 선택

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),

                // 음식 종류 선택 라디오 버튼
                Row(children: <Widget>[
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
                  Text('유제품'),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                  Text('계란'),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                  Text('과일'),
                  Radio(value: 3, groupValue: _radioValue, onChanged: _radioChange),
                  Text('육류'),
                  Radio(value: 4, groupValue: _radioValue, onChanged: _radioChange),
                  Text('채소'),
                ], mainAxisAlignment: MainAxisAlignment.spaceAround),
                // 양쪽 여백 사이에 균일하게 배치

                // 음식 이미지 선택
                Row(children: <Widget>[
                  GestureDetector(
                    child: Image.asset('repo/image/dairyProducts.png', width: 50),
                    onTap: () {
                      _imagePath = 'repo/image/dairyProducts.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/image/eggs.png', width: 50),
                    onTap: () {
                      _imagePath = 'repo/image/eggs.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/image/fruits.png', width: 50),
                    onTap: () {
                      _imagePath = 'repo/image/fruits.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/image/meats.png', width: 50),
                    onTap: () {
                      _imagePath = 'repo/image/meats.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/image/vegetables.png', width: 50),
                    onTap: () {
                      _imagePath = 'repo/image/vegetables.png';
                    },
                  ),
                ], mainAxisAlignment: MainAxisAlignment.spaceAround),

                ElevatedButton(
                    child: Text('음식 추가하기'),
                    onPressed: () {
                      showAlertDialog(context);
                    })
              ],
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    var food = Food(
        foodName: nameController.value.text,
        kind: getKind(_radioValue),
        imagePath: _imagePath);

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("아니오"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("예"),
      onPressed:  () {
        //widget.list?.add(food);
        //print('음식 추가됨: $food');
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("음식 추가하기"),
      content: Text("이 음식을 추가하시겠습니까?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  getKind(int? radioValue) {
    switch (radioValue) {
      case 0:
        return "유제품";
      case 1:
        return "계란";
      case 2:
        return "과일";
      case 3:
        return "육류";
      case 4:
        return "채소";
    }
  }
}