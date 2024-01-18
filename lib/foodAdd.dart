import 'package:flutter/material.dart';//firebase할때 만든거
import 'package:firebase_database/firebase_database.dart';
import 'food.dart';

class FoodAddPage extends StatefulWidget {
  final DatabaseReference reference;
  final List<Food> foods;

  const FoodAddPage({
    Key? key,
    required this.reference,
    required this.foods,
  }) : super(key: key);

  @override
  _FoodAddPageState createState() => _FoodAddPageState();

}
class _FoodAddPageState extends State<FoodAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식 추가'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '음식 이름'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '음식 이름을 입력해주세요.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '음식 설명'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '음식 설명을 입력해주세요.';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // 입력된 데이터를 Firebase에 저장
                  widget.reference.push().set({
                    'title': _titleController.text,
                    'content': _contentController.text
                  });

                  // 입력된 데이터를 앱 내부의 데이터 저장소에도 저장
                  setState(() {
                    Food newFood = Food(
                      title: _titleController.text,
                      content: _contentController.text,
                    );
                    Navigator.pop(context);
                    widget.foods.add(newFood);
                  });

                  // 입력 완료 후 이전 화면으로 이동
                }
              },
              child: Text('저장'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FoodAddPage(
                reference: widget.reference,
                foods: widget.foods,
              )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}