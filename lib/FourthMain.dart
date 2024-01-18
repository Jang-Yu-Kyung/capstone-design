import 'package:first_flutter_app2/recommendationPage(alone).dart';
import 'package:first_flutter_app2/recommendationPage(health).dart';
import 'package:flutter/material.dart';
import 'recommendationPage(diet).dart';

void main() async {
  runApp(FourthMain());
}

class FourthMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _FourthMain(),
    );
  }
}

class _FourthMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('일주일치 식단 추천')),
        body: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendationPageDiet()),
                );
              },
              child: Container(
                // ignore: sort_child_properties_last
                child: ElevatedButton(
                  child: Text('일주일 다이어트 & 고단백 식단'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecommendationPageDiet()),
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
                      builder: (context) => RecommendationPageHealth()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('일주일 건강식 식단'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecommendationPageHealth()),
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
                      builder: (context) => RecommendationPageAlone()),
                );
              },
              child: Container(
                child: ElevatedButton(
                  child: Text('일주일 자취생 식단'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecommendationPageAlone()),
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
  }
}