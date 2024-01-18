import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'food.dart';
import 'foodAdd.dart';

class FoodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoodPage();
}

class _FoodPage extends State<FoodPage> {
  FirebaseDatabase? _database;
  late DatabaseReference reference;
  String _databaseURL = 'https://example-78891-default-rtdb.firebaseio.com/';
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('food');

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        foods.add(Food.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('푸드리스트'),
      ),
      body: Container(
        child: Center(
          child: foods.length == 0
              ? Text('No Data')
              : ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  foods[index].title!,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Container(
                  child: Column(
                    children: <Widget>[
                      Text(foods[index].content!),
                      Container(
                        height: 1,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                onLongPress: () {
                  // 여기에 길게 클릭 시 메모 삭제 기능 추가 예정
                },
              );
            },
            itemCount: foods.length,
          ),
        ),
      ),
      //여기에 플로팅액션버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FoodAddPage(
                reference: reference,
                foods: foods,
              )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
