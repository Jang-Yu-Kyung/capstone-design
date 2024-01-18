import 'package:flutter/material.dart';
import '../foodItem.dart';

class FirstApp extends StatelessWidget {
  final List<Food>? list; // Food List 선언
  FirstApp({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, position) {
                return GestureDetector(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          list![position].imagePath!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                        Text(list![position].foodName!)
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertDialog dialog = AlertDialog(
                      content: Text(
                        '유통기한 알림창',
                        style: TextStyle(fontSize: 13.0),
                      ),
                    );
                    showDialog(context: context, builder: (BuildContext context) => dialog);
                  },
                );
              },
              itemCount: list!.length),
        ),
      ),
    );
  }
}
