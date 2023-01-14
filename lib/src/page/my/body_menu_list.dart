import 'package:flutter/material.dart';

class BodyMenuList {
  final String title; // 메뉴 제목
  final IconData iconData; // 메뉴 아이콘
  final String image; // 메뉴 이미지 아이콘 경로
  final String url; // 메뉴 경로

  BodyMenuList(
      {required this.title,
      required this.iconData,
      required this.image,
      required this.url});
}
