import 'package:flutter/material.dart';
import 'dart:math';

class RecommendationPageAlone extends StatefulWidget {
  @override
  _RecommendationPageAloneState createState() => _RecommendationPageAloneState();
}

class _RecommendationPageAloneState extends State<RecommendationPageAlone> {
  List<String> selectedFoods = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("일주일치 식단 추천"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '일주일 자취생 식단 추천',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedFoods = generateRecommendation1(41, 60, 7);
                  });
                },
                child: Text('추천 식단 보기'),
              ),
              SizedBox(height: 16.0),
              Text(
                '추천 식단:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              for (var food in selectedFoods)
                Text(
                  food,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> generateRecommendation1(int start, int end, int count) {
    final random = Random();
    final menuList = [
      "1: 그릭요거트", "2: 매쉬드포테이토샐러드", "3: 치킨스테이크 후무스 샐러드", "4: 쉬림프 갈릭버터구이 샐러드", "5: 베트남식 월남쌈 샐러드", "6: 감바스 알 아히요 샐러드", "7: 두부 포크소보로 샐러드",
      "8: 불고기 부리또", "9: 스리라차치킨 샐러드", "10: 분짜 샐러드& 분짜 드레싱", "11: 바질페스토 치킨샐러드& 발사믹 비네거 드레싱", "12: 우삼겹덮밥&팽이장국 세트", "13: 커리&닭안심가라아게 세트",
      "14: 낙지볶음& 콩나물 세트", "15: 고기듬뿍렌틸콩비빔밥 & 황태국", "16: 고기듬뿍 유산슬 덮밥 & 얼큰두부백짬뽕탕 세트", "17: 제육 오므라이스 & 두부양배추 샐러드", "18: 브로콜리 참깨 두부 무침", "19: 전복 현미리조또", "20: 달가슴살 죽",
      //여기까지 다이어트 & 고단백 식단 1번부터 20번까지
      "21: 캐슈넛깐풍두부강정", "22: 돼지고기덮밥", "23: 반반불고기&쌈 세트", "24: 소고기샤브전골&부추잡채 세트", "25: 묵말랭이 돼지고기 들깨볶음", "26: 마제덮밥", "27: 흑마늘 데리야끼 소불고기",
      "28: 전복내장솥밥", "29: 수제고기 완자구이", "30: 순한 마파두부덮밥", "31: 돼지고기 생강볶음", "32: 고사리 오일 파스타 & 흑임자 닭구이 세트", "33: 녹차불고기 해초쌈 & 두부 고사리조림 세트", "34: 오야코동 세트",
      "35: 소고기 육개장 & 계란말이 세트", "36: 코다리조림 & 돼지고기 우엉 들깨 조림", "37: 강된장 나물비빔", "38: 연근찜닭", "39: 소고기 가지 된장볶음 & 연근 깨소스 무침", "40: 대파 듬뿍 두부조림 & 연자육 소불고기 세트",
      //여기까지 건강식 식단 21번부터 40번까지
      "매운 돼지고기 삼채볶음& 두부조림 세트", "짜장면 키트& 고추잡채 세트", "콩비지 김치찜", "돼지고기 우엉채 불고기", "파채 돼지 불고기", "토마토 견과 카레", "두부구이",
      "까르보우동", "불닭 새송이덮밥", "매콤 순두부 카레", "김치 스팸 볶음밥", "버터 마늘 볶음밥", "차슈덮밥", "고추장 팽이버섯 무침",
      "묵은지 참치 김밥", "순두부찌개", "베이컨 치즈 말이", "두부 유부 초밥", "순두부 그라탕", "사라다 치즈 토스트",
      //여기까지 자취생 식단 41번부터 60번까지
    ];

    final selectedFoods = List<String>.from(menuList.sublist(start - 1, end))..shuffle(random);

    return selectedFoods.sublist(0, count);
  }

  menu() {
    final studentMenu = generateRecommendation1(41, 60, 7);

    final daysOfWeek = [
      '월요일:',
      '화요일:',
      '수요일:',
      '목요일:',
      '금요일:',
      '토요일:',
      '일요일:'
    ];

    for (var i = 0; i < daysOfWeek.length; i++) {
      final day = daysOfWeek[i];
      final studentRecommendation = studentMenu[i];


      print('$day - 자취생 식단: $studentRecommendation');
      print('-----------------------------------');
    }
  }
}