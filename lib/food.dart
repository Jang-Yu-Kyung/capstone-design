import 'package:firebase_database/firebase_database.dart';

class Food {
  String? key;
  String? title;
  String? content;

  Food({this.title, this.content,});

  Food.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = (snapshot.value as Map<String, dynamic>)['title'],
        content = (snapshot.value as Map<String, dynamic>)['content'];

  toJson() {
    return {
      'title' : title,
      'content' : content,
    };
  }
}
