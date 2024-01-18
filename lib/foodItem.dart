import 'package:flutter/material.dart';

class Food {
  String? imagePath; // 음식 사진
  String? foodName; // 음식 이름
  String? kind; // 음식 종류

  Food({
    required this.foodName,
    required this.kind,
    required this.imagePath,
  });
}