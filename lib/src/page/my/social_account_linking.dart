import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';

class SocialAccountLinking extends StatelessWidget {
  const SocialAccountLinking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('소셜 연동하기'),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close))),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Image.asset('assets/images/logo/yab-logo_final2.png'),
            ),
            SizedBox(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
                      child:
                          Text('로그인', style: Get.theme.textTheme.titleLarge)),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text('기존에 사용하시던 계정으로 로그인 하세요',
                          style: Get.theme.textTheme.bodyText2)),
                  SizedBox(
                    // 구글 로그인
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side:
                              const BorderSide(width: 1, color: Colors.black)),
                      onPressed: () async {
                        OAuthCredential? _userCredential =
                            await AuthController.to.anonymousToGoogle();
                        if (AuthController.to.errorCode.value == "Success") {
                          // 작업이 성공 게스트 계정 변경 가능
                          Get.back();
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "provider-already-linked") {
                          //공급자가 이미 연결되어 있음
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "invalid-credential") {
                          //유효하지 않은 자격 증명
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "credential-already-in-use") {
                          // 이미 있는 계정
                          await credentialAlreadyInUse(
                              '/GoogleLogin', _userCredential);
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "Unknown") {
                          // 알수 없는 에러
                          await unknown();
                          return;
                        } else if (_userCredential == null) {
                          // 알수 없는 에러
                          await unknown();
                          return;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(1),
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ), // 버튼 테두리 정의
                            child: Container(
                              // 안족 아이콘의 이미지 사이즈 조절을 위한 컨테이너 생성
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/googlelogin_icon.png'))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 44),
                              child: const Text(
                                'Goole 로그인',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // 애플 로그인
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        // Anonymous -> Apple 로그인
                        OAuthCredential? _userCredential =
                            await AuthController.to.anonymousToApple();
                        if (AuthController.to.errorCode.value == "Success") {
                          // 작업이 성공 게스트 계정 변경 가능
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "provider-already-linked") {
                          //공급자가 이미 연결되어 있음
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "invalid-credential") {
                          //유효하지 않은 자격 증명
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "credential-already-in-use") {
                          // 이미 있는 계정
                          await credentialAlreadyInUse(
                              '/AppleLogin', _userCredential);
                          return;
                        } else if (AuthController.to.errorCode.value ==
                            "Unknown") {
                          // 알수 없는 에러
                          await unknown();
                          return;
                        } else if (_userCredential == null) {
                          // 알수 없는 에러
                          await unknown();
                          return;
                        }
                      },
                      // logger.i(controller.user.value.userKey);,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ), // 버튼 테두리 정의
                            child: Container(
                              // 안족 아이콘의 이미지 사이즈 조절을 위한 컨테이너 생성
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/applelogin_icon.png'))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 44),
                              child: const Text(
                                'Apple 로그인',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '로그인 시 ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            TextSpan(
                              text: '개인정보처리방침',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await Get.toNamed('/PrivacyPolicy');
                                },
                            ),
                            const TextSpan(
                              text: ' 과 ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            TextSpan(
                              text: '서비스이용약관',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await Get.toNamed('/PrivacyPolicy');
                                },
                            ),
                            const TextSpan(
                              text: '에 동의한 것으로 간주 합니다.',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 이미 등록된 계정에 로그인하는 알림
  // 예 버튼을 누르면 게스트 계정 삭제와 로그인 계정 진입
  credentialAlreadyInUse(String url, OAuthCredential? userCredential) async {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 17),
      title: '계정 변경',
      middleText:
          '등록된 계정이 있습니다.\n등록된 계정으로 연동할 경우\n\n게스트계정의 데이터는 삭제 됩니다.\n\n계정 변경을 원하시면\n앱을 다시 실행해 주세요\n\n앱이 종료 됩니다.',
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
              if (url == '/GoogleLogin') {
                await AuthController.to.alredyGoogleLogin(userCredential);
                Get.back(); // 팝업창 닫기
                exit(0);
              } else {
                await AuthController.to.alredyAppleLogin(userCredential);
                Get.back(); // 팝업창 닫기
                exit(0);
              }
            },
            child: const Text('예')),
      ],
    );
  }

  unknown() async {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 17),
      title: '알수 없는 에러',
      middleText: '로그인 중 에러가 발생 되었습니다.\nselldydeveloper@gmail.com으로 문의 주세요.',
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
              Get.back(); // 팝업창 닫기
            },
            child: const Text('예')),
      ],
    );
  }
}
