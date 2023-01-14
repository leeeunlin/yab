import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/my/body_menu_list.dart';
import 'package:yab_v2/src/size_config.dart';

final List<BodyMenuList> iconLoginMenu = [
  BodyMenuList(
    title: '내 정보',
    iconData: Icons.arrow_forward_ios,
    image: 'assets/images/icons/icon_Account.png',
    url: '/UserInfoPage',
  ),
];
final List<BodyMenuList> iconMenu2 = [
  BodyMenuList(
    title: '내글 관리',
    iconData: Icons.arrow_forward_ios,
    image: 'assets/images/icons/icon_Advertising.png',
    url: '/SendItemListPage',
  ),
];

final List<BodyMenuList> logOutMenu = [
  BodyMenuList(
    title: '고객센터 문의하기',
    iconData: Icons.arrow_forward_ios,
    image: 'assets/images/icons/icon_Servicecenter.png',
    url: '/SendEmail',
  ),
  BodyMenuList(
    title: '서비스 이용약관',
    iconData: Icons.arrow_forward_ios,
    image: 'assets/images/icons/icon_TermsofService.png',
    url: '/TermsOfService',
  ),
  BodyMenuList(
    title: '개인정보 처리방침',
    iconData: Icons.arrow_forward_ios,
    image: 'assets/images/icons/icon_privacypolicy.png',
    url: '/PrivacyPolicy',
  ),
  // BodyMenuList(
  //   title: '로그아웃',
  //   iconData: Icons.logout,
  //   url: '/',
  // ),
  // BodyMenuList(
  //     title: '회원탈퇴', iconData: Icons.person_remove_alt_1, url: '/delete'),
];

class BodyMenuWidget extends StatelessWidget {
  BodyMenuWidget({required this.bodyMenuList});
  final List<BodyMenuList> bodyMenuList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(right: 10, left: 10), // 메뉴 버튼 주위 마진

      child: Column(
        children: List.generate(
          bodyMenuList.length,
          (index) => _buildRowIconItem(
            bodyMenuList[index].title,
            bodyMenuList[index].iconData,
            bodyMenuList[index].image,
            bodyMenuList[index].url,
          ),
        ),
      ),
    );
  }

  Widget _buildRowIconItem(
      String title, IconData iconData, String image, String url) {
    return InkWell(
      onTap: () async {
        if (url == '/') {
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
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();

                    Get.back(); // 팝업창 닫기
                    exit(0);
                  },
                  child: const Text('예')),
            ],
          );
          return;
        }
        if (url == '/delete') {
          await Get.defaultDialog(
            titlePadding: const EdgeInsets.all(20),
            titleStyle: const TextStyle(fontSize: 17),
            title: '회원 탈퇴',
            middleText: '모든 데이터가 삭제됩니다.\n탈퇴하시겠습니까?\n\n앱이 종료됩니다.',
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
                    await UserController.to.deleteUser(); // 삭제
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();

                    Get.back(); // 팝업창 닫기
                    exit(0);
                  },
                  child: const Text('예')),
            ],
          );
          return;
        }
        if (url == '/SendItemListPage') {
          SendBoardController.to.reload(); // 내가 보낸 게시글 진입 할때 이 함수를 호출해야 불러짐.
          await Get.toNamed(url);
          return;
        }
        if (url == '/SendEmail') {
          _sendEmail();
          return;
        }
        if (url == '/GoogleLogin') {
          // Anonymous -> Google 로그인
          OAuthCredential? _userCredential =
              await AuthController.to.anonymousToGoogle();
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
            await credentialAlreadyInUse(url, _userCredential);
            return;
          } else if (AuthController.to.errorCode.value == "Unknown") {
            // 알수 없는 에러
            await unknown();
            return;
          } else if (_userCredential == null) {
            // 알수 없는 에러
            await unknown();
            return;
          }
        }
        if (url == '/AppleLogin') {
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
            await credentialAlreadyInUse(url, _userCredential);
            return;
          } else if (AuthController.to.errorCode.value == "Unknown") {
            // 알수 없는 에러
            await unknown();
            return;
          } else if (_userCredential == null) {
            // 알수 없는 에러
            await unknown();
            return;
          }
        }
        await Get.toNamed(url);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: getProportionateScreenHeight(20), // 메뉴 버튼 크기
          child: Row(
            children: [
              Image.asset(image),
              SizedBox(
                  width: getProportionateScreenWidth(
                      10)), // 메뉴 버튼 안에 아이콘과 내용의 가운데 크기
              Text(title, style: Get.theme.textTheme.subtitle1),
              const Spacer(),
              Icon(iconData,
                  size: getProportionateScreenWidth(15)), // 메뉴 버튼 안에 아이콘 크기
            ],
          ),
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

  void _sendEmail() async {
    final Email email = Email(
      body: '- 문의내용:\n\n\n\n공휴일 제외한 72시간 이내 보내주신 이메일 주소로 회신드리겠습니다.',
      subject: '[일반문의]',
      recipients: ['sales@selldy.co.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = '기본 메일 앱을 사용할 수 없습니다.';
      String message = '아래 이메일로 연락주시면 답변드리겠습니다.\nsales@selldy.co.kr';
      detectorDialog(title, message);
    }
  }

  void detectorDialog(String title, String message) async {
    await Get.defaultDialog(
      title: title,
      middleText: message,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () {
              Get.back(); // 팝업창 닫기
            },
            child: const Text('닫기')),
      ],
    );
  }
}
