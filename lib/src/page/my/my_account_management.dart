import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';

class MyAccountManagement extends StatelessWidget {
  const MyAccountManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    return Scaffold(
      appBar: AppBar(
          title: const Text('계정 관리'),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close))),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('가입 계정', style: Get.theme.textTheme.bodyText2)),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ), // 버튼 테두리 정의
                      child: Container(
                        // 안족 아이콘의 이미지 사이즈 조절을 위한 컨테이너 생성
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FirebaseAuth.instance.currentUser
                                            ?.providerData[0].providerId ==
                                        'google.com'
                                    ? const AssetImage(
                                        'assets/images/icons/googlelogin_icon.png')
                                    : const AssetImage(
                                        'assets/images/icons/applelogin_icon.png'))),
                      ),
                    ),
                    Text(UserController.to.userModel.value.email.toString(),
                        style: Get.theme.textTheme.subtitle1),
                  ],
                )),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('가입일', style: Get.theme.textTheme.bodyText2)),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Text(
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(UserController
                            .to.userModel.value.createdDate
                            .toString()))
                        .toString(),
                    style: Get.theme.textTheme.subtitle1)),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('보유 포인트', style: Get.theme.textTheme.bodyText2)),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Text(
                    '${f.format(UserController.to.userModel.value.coin!.floor())}  YAB',
                    style: Get.theme.textTheme.subtitle1)),
            const SizedBox(height: 60),
            // 로그아웃 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    await Get.defaultDialog(
                      titlePadding: const EdgeInsets.all(20),
                      titleStyle: const TextStyle(fontSize: 17),
                      title: '로그아웃',
                      middleText: '로그아웃 하시겠습니까?\n\n앱이 종료됩니다.',
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red,
                                backgroundColor: Colors.black.withOpacity(0),
                                shadowColor: Colors.black.withOpacity(0)),
                            onPressed: () async {
                              Get.back(); // 팝업창 닫기
                            },
                            child: const Text('아니오')),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.black.withOpacity(0),
                                shadowColor: Colors.black.withOpacity(0)),
                            onPressed: () async {
                              // issues: #50 로그아웃 시 FCM 토큰 초기화 - ellee
                              await UserController.to.logoutDeleteFCMToken();
                              await FirebaseAuth.instance.signOut();
                              await GoogleSignIn().signOut();

                              Get.back(); // 팝업창 닫기
                              exit(0);
                            },
                            child: const Text('예')),
                      ],
                    );
                    return;
                  },
                  child: const Text('로그아웃'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.5))),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'YAB을 탈퇴하려면 ',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextSpan(
                        text: '여기',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await Get.defaultDialog(
                              titlePadding: const EdgeInsets.all(20),
                              titleStyle: const TextStyle(fontSize: 17),
                              title: '회원 탈퇴',
                              middleText:
                                  '모든 데이터가 삭제됩니다.\n탈퇴하시겠습니까?\n\n앱이 종료됩니다.',
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        backgroundColor:
                                            Colors.black.withOpacity(0),
                                        shadowColor:
                                            Colors.black.withOpacity(0)),
                                    onPressed: () async {
                                      Get.back(); // 팝업창 닫기
                                    },
                                    child: const Text('아니오')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        backgroundColor:
                                            Colors.black.withOpacity(0),
                                        shadowColor:
                                            Colors.black.withOpacity(0)),
                                    onPressed: () async {
                                      await UserController.to
                                          .deleteUser(); // 삭제
                                      await FirebaseAuth.instance.signOut();
                                      await GoogleSignIn().signOut();

                                      Get.back(); // 팝업창 닫기
                                      exit(0);
                                    },
                                    child: const Text('예')),
                              ],
                            );
                          },
                      ),
                      const TextSpan(
                          text: '를 눌러주세요',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              '탈퇴 시 누적된 포인트는 소멸되며 복구가 불가능 합니다.',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
