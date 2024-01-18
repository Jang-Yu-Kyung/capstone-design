import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class FirstMain extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("냉장고 내부"),),
//       body: Column(
//         children:[
//           Container(child: Text('냉장고 내부 페이지')),
//         ],
//       ),
//     );
//   }
// }

/*  여기서 추가해야됨.
void uploadImage(File imageFile) async {
  // 사진을 업로드할 서버 엔드포인트 URL
  var url = Uri.parse('http://your-server-url/upload');

  // Multipart 요청 생성
  var request = http.MultipartRequest('POST', url);

  // 이미지 파일 추가
  var image = await http.MultipartFile.fromPath('image', imageFile.path);
  request.files.add(image);

  // 요청 보내기
  var response = await request.send();

  // 응답 처리
  if (response.statusCode == 200) {
    print('이미지 업로드 성공');
  } else {
    print('이미지 업로드 실패');
  }
}
void fetchImage() async {
  // 사진을 가져올 서버 엔드포인트 URL
  var url = Uri.parse('http://your-server-url/image');

  // GET 요청 보내기
  var response = await http.get(url);

  // 응답 처리
  if (response.statusCode == 200) {
    // 응답 데이터 파싱
    var imageData = jsonDecode(response.body);

    // 이미지 데이터를 사용하여 앱에서 사진 표시
    // 예시: Image.network(imageData['url'])
  } else {
    print('이미지 가져오기 실패');
  }
}
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirstMain extends StatefulWidget {
  @override
  _ImageDisplayPageState createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<FirstMain> {
  String imageUrl = 'http://hyunssoo.asuscomm.com:44339/refresh_app/image/get/';

  Future<http.Response> fetchImage() async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to fetch image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('냉장고 내부'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<http.Response>(
          future: fetchImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return Image.memory(snapshot.data!.bodyBytes);
            } else {
              return Center(
                child: Text('No image data'),
              );
            }
          },
        ),
      ),
    );
  }
}