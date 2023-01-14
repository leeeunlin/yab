import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('준비중인 페이지'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(child: Icon(Icons.construction, size: 50)),
                Text('페이지 준비중 입니다..', style: Get.theme.textTheme.titleLarge),
              ],
            ),
          )
        ],
      ),
    );
  }
}
