import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/point_report_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/my/my_account_management.dart';
import 'package:yab_v2/src/page/my/social_account_linking.dart';
import 'package:yab_v2/src/page/my/userinfo/user_point_report.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class HeaderMenuWidget extends GetView<UserController> {
  const HeaderMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileRow(),
      ],
    );
  }

  Widget _buildProfileRow() {
    var f = NumberFormat('###,###,###,###');
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "로그인 정보\n",
                            style: Get.theme.textTheme.subtitle1,
                          ),
                          TextSpan(
                              text: controller.userModel.value.email ==
                                      DATA_ANONYMOUS
                                  ? controller.userModel.value.userKey
                                      ?.substring(0, 10)
                                  : controller.userModel.value.email,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => controller.userModel.value.email != null &&
                      controller.userModel.value.email ==
                          DATA_ANONYMOUS // 로그아웃 이후 바로 재 실행시 data null이 넘어오는 경우 발생되어 해당부분 차단
                  ? SizedBox(
                      child: TextButton(
                          onPressed: () async {
                            await Get.to(() => const SocialAccountLinking());
                          },
                          child: const Text('연결하기',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold))))
                  : controller.userModel.value.email != null &&
                          controller.userModel.value.email != DATA_ANONYMOUS &&
                          controller.userModel.value.email !=
                              '' // 로그아웃 이후 바로 재 실행시 data null이 넘어오는 경우 발생되어 해당부분 차단
                      ? SizedBox(
                          child: Row(
                            children: [
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
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.providerData[0]
                                                      .providerId ==
                                                  'google.com'
                                              ? const AssetImage(
                                                  'assets/images/icons/googlelogin_icon.png')
                                              : const AssetImage(
                                                  'assets/images/icons/applelogin_icon.png'))),
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await Get.to(
                                        () => const MyAccountManagement());
                                  },
                                  child: const Text('관리',
                                      style: TextStyle(fontSize: 13))),
                            ],
                          ),
                        )
                      : Container())
            ],
          ),
          Obx(
            () => Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      'YAB 적립 금액',
                      style: Get.theme.textTheme.subtitle1,
                    )),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: AutoSizeText(
                              (controller.userModel.value.coin == null
                                  ? ''
                                  : '\u{1F4B0} ${f.format(controller.userModel.value.coin!.floor())} YAB'),
                              maxLines: 1,
                              minFontSize: 1,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'rubikMonoOne'),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              PointReportController.to.reload();
                              await Get.to(() => const UserPointReport());
                            },
                            child: const Text('내역 확인'))
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
