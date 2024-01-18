import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firstMain.dart';
import 'secondMain.dart';
import 'thirdMain.dart';
import 'fourthMain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //stless 코드입력후 tap키 하면 클래스 생성됨
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(scaffoldBackgroundColor: Colors.white70),
      home: First(),
    );
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('사용자 냉장고')),
        body: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstMain()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('냉장고 내부'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FirstMain()),
                    );
                  },
                ),
                width: 380,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodListPage()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('푸드리스트'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FoodListPage()),
                    );
                  },
                ),
                width: 380,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ThirdMain()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('레시피 추천'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ThirdMain()),
                    );
                  },
                ),
                width: 380,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FourthMain()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('일추일치 식단 추천'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FourthMain()),
                    );
                  },
                ),
                width: 380,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ));
  } // Widget
}