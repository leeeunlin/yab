import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Text('로그인', style: Get.theme.textTheme.titleLarge)),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('기존에 사용하시던 계정으로 로그인 하세요',
                        style: Get.theme.textTheme.bodyText2)),
                SizedBox(
                  // 익명 로그인
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side:
                              const BorderSide(width: 1, color: Colors.black)),
                      onPressed: () async {
                        controller.loginButtonAnonymous();
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
                              child: const Icon(
                                Icons.account_circle,
                                color: Colors.black,
                              )),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 44),
                              child: const Text(
                                'Guest 로그인',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // 구글 로그인
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(width: 1, color: Colors.black)),
                    onPressed: () async {
                      await controller.loginButtonGoogle();
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      await controller.loginButtonApple();
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
    ));
  }
}
