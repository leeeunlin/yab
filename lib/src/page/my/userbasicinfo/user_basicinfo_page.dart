import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/gender.dart';
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/page/my/address_info/address_search_page.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserBasicInfoPage extends GetView<UserController> {
  const UserBasicInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController birthInput = TextEditingController();
    if (controller.birth.value != '') {
      if (controller.birth.value != 'none') {
        DateTime birth = DateTime.parse(controller.birth.value);
        birthInput.text = '${birth.year}년 ${birth.month}월 ${birth.day}일';
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('기본 정보'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              controller.getUser(AuthController.to.userModel.value.userKey!);
            }),
      ),
      body: Obx(
        () => ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('이메일', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 15,
                    ),
                    child: Text(
                      UserController.to.userModel.value.email.toString(),
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text('생년 월일', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: TextField(
                      decoration:
                          const InputDecoration(hintText: '생년월일을 선택하세요.'),
                      controller: birthInput,
                      readOnly: true,
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          locale: LocaleType.ko,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          onConfirm: (date) {
                            birthInput.text =
                                '${date.year.toString()}년 ${date.month.toString()}월 ${date.day.toString()}일';
                            controller.birth = date.toString().obs;
                            controller.setBirth(date.toString(), 50);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text('주소', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 15,
                    ),
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: controller.address.value != ''
                                ? Colors.white
                                : Colors.deepPurple),
                        child: AutoSizeText(
                          controller.address.value != ''
                              ? controller.address.value
                              : '주소 찾기',
                          style: TextStyle(
                              color: controller.address.value != ''
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        onPressed: () async {
                          await Get.to(() => const AddressSearchPage());
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text('성별', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: controller.genderMale.value
                                    ? Colors.deepPurple
                                    : Colors.white),
                            child: AutoSizeText(
                              genderMapEngToKor.values.elementAt(1),
                              style: TextStyle(
                                  color: controller.genderMale.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.genderMale.value == false) {
                                controller.genderMale.value = true;
                                controller.genderWoman.value = false;
                                await controller.setGender(
                                    genderMapKorToEng.values.elementAt(1), 50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: controller.genderWoman.value
                                    ? Colors.deepPurple
                                    : Colors.white),
                            child: AutoSizeText(
                              genderMapEngToKor.values.elementAt(2),
                              style: TextStyle(
                                  color: controller.genderWoman.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.genderWoman.value == false) {
                                controller.genderWoman.value = true;
                                controller.genderMale.value = false;
                                await controller.setGender(
                                    genderMapKorToEng.values.elementAt(2), 50);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('국적', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.nationalityLocal.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              nationalityMapEngToKor.values.elementAt(1),
                              style: TextStyle(
                                  color: controller.nationalityLocal.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.nationalityLocal.value == false) {
                                controller.nationalityLocal.value = true;
                                controller.nationalityForeigner.value = false;
                                await controller.setNationality(
                                    nationalityMapKorToEng.values.elementAt(1),
                                    50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.nationalityForeigner.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              nationalityMapEngToKor.values.elementAt(2),
                              style: TextStyle(
                                  color: controller.nationalityForeigner.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.nationalityForeigner.value ==
                                  false) {
                                controller.nationalityForeigner.value = true;
                                controller.nationalityLocal.value = false;
                                await controller.setNationality(
                                    nationalityMapKorToEng.values.elementAt(2),
                                    50);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('결혼 여부', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.maritalstatusMarried.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              maritalstatusMapEngToKor.values.elementAt(1),
                              style: TextStyle(
                                  color: controller.maritalstatusMarried.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.maritalstatusMarried.value ==
                                  false) {
                                controller.maritalstatusMarried.value = true;
                                controller.maritalstatusSingle.value = false;
                                await controller.setMaritalstatus(
                                    maritalstatusMapKorToEng.values
                                        .elementAt(1),
                                    50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.maritalstatusSingle.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              maritalstatusMapEngToKor.values.elementAt(2),
                              style: TextStyle(
                                  color: controller.maritalstatusSingle.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.maritalstatusSingle.value ==
                                  false) {
                                controller.maritalstatusSingle.value = true;
                                controller.maritalstatusMarried.value = false;
                                await controller.setMaritalstatus(
                                    maritalstatusMapKorToEng.values
                                        .elementAt(2),
                                    50);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('자녀 유무', style: Get.theme.textTheme.subtitle1),
                  ),
                  Container(
                    height: 50,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.childrenExistence.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              childrenMapEngToKor.values.elementAt(1),
                              style: TextStyle(
                                  color: controller.childrenExistence.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.childrenExistence.value == false) {
                                controller.childrenExistence.value = true;
                                controller.childrenNonexistence.value = false;
                                await controller.setChildren(
                                    childrenMapKorToEng.values.elementAt(1),
                                    50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 2.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.childrenNonexistence.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              childrenMapEngToKor.values.elementAt(2),
                              style: TextStyle(
                                  color: controller.childrenNonexistence.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.childrenNonexistence.value ==
                                  false) {
                                controller.childrenNonexistence.value = true;
                                controller.childrenExistence.value = false;
                                await controller.setChildren(
                                    childrenMapKorToEng.values.elementAt(2),
                                    50);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
