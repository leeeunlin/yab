import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/my/economicinfo/user_economicinfo_page.dart';
import 'package:yab_v2/src/page/my/personalityinfo/user_personalityinfo_page.dart';
import 'package:yab_v2/src/page/my/userbasicinfo/user_basicinfo_page.dart';
import 'package:yab_v2/src/page/my/userbodyinfo/user_bodyinfo_page.dart';
import 'package:yab_v2/src/page/my/usereducationinfo/user_educationinfo_page.dart';
import 'package:yab_v2/src/page/my/userhealthinfo/user_healthinfo_page.dart';

class UserInfoPage extends GetView<UserController> {
  const UserInfoPage({Key? key}) : super(key: key);

  InkWell userinfopage(String path, Widget page, String count) {
    return InkWell(
        onTap: () async {
          await Get.to(() => page);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                width: Get.size.width / 2.5,
                height: Get.size.height / 10,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(path))),
              ),
              Text(
                count,
                style: Get.theme.textTheme.titleMedium,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle:
              false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
          title: const Text('내 정보'),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.getUser(AuthController.to.userModel.value.userKey!);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Obx(
          () => ListView(children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 기본정보 7개 항목
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const UserBasicInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userBasicInfoCount.value < 7
                                            ? 'assets/images/icons/basicinfo_null.png'
                                            : 'assets/images/icons/basicinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '기본 정보 ${controller.userBasicInfoCount.value}/7',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),
                          // 신체정보 5개 항목
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const UserBodyInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userBodyInfoCount.value < 5
                                            ? 'assets/images/icons/bodyinfo_null.png'
                                            : 'assets/images/icons/bodyinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '신체 정보 ${controller.userBodyInfoCount.value}/5',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    // issues: #45 건강정보 입력 탭
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const UserHealthInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userHealthInfoCount.value < 3
                                            ? 'assets/images/icons/healthinfo_null.png'
                                            : 'assets/images/icons/healthinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '건강 정보 ${controller.userHealthInfoCount.value}/3',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),
                          // issues: #46 학력정보 입력 탭
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const UserEducationInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userEducationInfoCount
                                                    .value <
                                                1
                                            ? 'assets/images/icons/educationinfo_null.png'
                                            : 'assets/images/icons/educationinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '학력 정보 ${controller.userEducationInfoCount.value}/1',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // issues: #51 성격정보 입력, 검색 생성 - ellee
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const PersonalityInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userPersonalityInfoCount
                                                    .value <
                                                2
                                            ? 'assets/images/icons/personalityinfo_null.png'
                                            : 'assets/images/icons/personalityinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '성격 정보 ${controller.userPersonalityInfoCount.value}/2',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),

                          // issues: #55 경제정보 입력 생성
                          InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => const UserEconomicInfoPage(),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: Get.size.width / 2.5,
                                      height: Get.size.height / 10,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                        controller.userEconomicInfoCount.value <
                                                2
                                            ? 'assets/images/icons/economicinfo_null.png'
                                            : 'assets/images/icons/economicinfo.png',
                                      ))),
                                    ),
                                    Text(
                                        '경제 정보 ${controller.userEconomicInfoCount.value}/2',
                                        style: Get.theme.textTheme.subtitle1),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),

                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            '신규 배지는 다음 업데이트에 추가될 예정이며\n추가 포인트 지급방식은 공지사항을 통해 안내드리겠습니다.',
                            style: Get.theme.textTheme.subtitle2))
                  ],
                ))
          ]),
        ));
  }
}
