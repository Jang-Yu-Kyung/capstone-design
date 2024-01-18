import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:html/parser.dart' show parse;

void main() => runApp(ThirdMain());

class ThirdMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  @override
  _HttpAppState createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List data = [];

  TextEditingController _editingController = TextEditingController();

  final Xml2Json xml2json = Xml2Json();

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: Center(
          child: data.length == 0
              ? Text(
            '데이터가 없습니다.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
              : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(data[index]['RCP_NM'].toString()),
                      Text(data[index]['RCP_PARTS_DTLS'].toString()),
                      Text(data[index]['RCP_WAY2'].toString()),
                      Text(data[index]['INFO_ENG'].toString()),
                      Text(data[index]['MANUAL01'].toString()),
                      Text(data[index]['MANUAL02'].toString()),
                      Text(data[index]['MANUAL03'].toString()),
                      Text(data[index]['MANUAL04'].toString()),
                      Text(data[index]['MANUAL05'].toString()),
                      Text(data[index]['MANUAL06'].toString()),
                      Text(data[index]['MANUAL07'].toString()),
                      Text(data[index]['MANUAL08'].toString()),
                      Text(data[index]['MANUAL09'].toString()),
                      Text(data[index]['MANUAL10'].toString()),
                      Text(data[index]['MANUAL11'].toString()),
                      Text(data[index]['MANUAL12'].toString()),
                      Text(data[index]['MANUAL13'].toString()),
                      Text(data[index]['MANUAL14'].toString()),
                      Text(data[index]['MANUAL15'].toString()),
                      Text(data[index]['MANUAL16'].toString()),
                      Text(data[index]['MANUAL17'].toString()),
                      Text(data[index]['MANUAL18'].toString()),
                      Text(data[index]['MANUAL19'].toString()),
                      Text(data[index]['MANUAL20'].toString()),
                    ],
                  ),
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getJSONData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = Uri.parse(
        'http://openapi.foodsafetykorea.go.kr/api/56ba888e0b134119949c/COOKRCP01/xml/'
            '1/1000?PRDUCT_NM=${Uri.encodeQueryComponent(_editingController.text)}');

    var response = await http.get(url);
    var data = xml2json.parse(utf8.decode(response.bodyBytes));
    var jsonResult = jsonDecode(xml2json.toParker());
    var resultData = jsonResult['COOKRCP01']['row'];
    var xmlResult = utf8.decode(response.bodyBytes);
    xml2json.parse(xmlResult);

    setState(() {
      if (resultData != null) {
        this.data = resultData.where((recipe) => recipe['RCP_NM'].toString().contains(_editingController.text)).toList();
      } else {
        print('검색 결과가 없습니다.');
      }
    });

    return response.body;
  }
}

//감자만 음식 입력하면 감자 관련된 레시피만 나옴 근데 재료만 나옴-> 만드는법 조금