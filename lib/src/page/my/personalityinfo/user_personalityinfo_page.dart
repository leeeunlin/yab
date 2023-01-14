import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PersonalityInfoPage extends GetView<UserController> {
  const PersonalityInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int birthDay = 0;
    if (controller.birth.value != '') {
      birthDay = int.parse(
          DateFormat('MMdd').format(DateTime.parse(controller.birth.value)));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('성격 정보'),
        leading: IconButton(
            onPressed: () {
              Get.back();
              controller.getUser(AuthController.to.userModel.value.userKey!);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text('자신의 MBTI를 선택해 주세요',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Column(children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityISTJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ISTJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityISTJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityISTJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = true;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ISTJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityISTP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ISTP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityISTP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityISTP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = true;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ISTP', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityISFJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ISFJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityISFJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityISFJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = true;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ISFJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityISFP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ISFP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityISFP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityISFP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = true;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ISFP', 50);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityINTJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'INTJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityINTJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityINTJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = true;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'INTJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityINTP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'INTP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityINTP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityINTP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = true;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'INTP', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityINFJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'INFJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityINFJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityINFJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = true;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'INFJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityINFP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'INFP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityINFP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityINFP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = true;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'INFP', 50);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityESTJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ESTJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityESTJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityESTJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = true;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ESTJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityESTP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ESTP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityESTP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityESTP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = true;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ESTP', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityESFJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ESFJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityESFJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityESFJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = true;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ESFJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityESFP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ESFP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityESFP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityESFP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = true;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ESFP', 50);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityENTJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ENTJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityENTJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityENTJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = true;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ENTJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityENTP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ENTP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityENTP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityENTP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = true;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ENTP', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityENFJ.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ENFJ',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityENFJ.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityENFJ.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = true;
                                      controller.personalityENFP.value = false;
                                      await controller.setPersonalityMBTI(
                                          'ENFJ', 50);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.size.width / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.personalityENFP.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  child: AutoSizeText(
                                    'ENFP',
                                    maxLines: 1,
                                    minFontSize: 1,
                                    style: TextStyle(
                                        color: controller.personalityENFP.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  onPressed: () async {
                                    if (controller.personalityENFP.value ==
                                        false) {
                                      controller.personalityISTJ.value = false;
                                      controller.personalityISTP.value = false;
                                      controller.personalityISFJ.value = false;
                                      controller.personalityISFP.value = false;
                                      controller.personalityINTJ.value = false;
                                      controller.personalityINTP.value = false;
                                      controller.personalityINFJ.value = false;
                                      controller.personalityINFP.value = false;
                                      controller.personalityESTJ.value = false;
                                      controller.personalityESTP.value = false;
                                      controller.personalityESFJ.value = false;
                                      controller.personalityESFP.value = false;
                                      controller.personalityENTJ.value = false;
                                      controller.personalityENTP.value = false;
                                      controller.personalityENFJ.value = false;
                                      controller.personalityENFP.value = true;
                                      await controller.setPersonalityMBTI(
                                          'ENFP', 50);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text('별자리 정보를 확인해 주세요',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => SizedBox(
                        child: !controller.personalityStarSign.value
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (birthDay != 0) {
                                    String starSign = '';
                                    controller.personalityStarSign.value = true;
                                    if (birthDay >= 120 && birthDay <= 218) {
                                      starSign = 'Aquarius';
                                    }
                                    if (birthDay >= 219 && birthDay <= 320) {
                                      starSign = 'Pisces';
                                    }
                                    if (birthDay >= 321 && birthDay <= 419) {
                                      starSign = 'Aries';
                                    }
                                    if (birthDay >= 420 && birthDay <= 520) {
                                      starSign = 'Taurus';
                                    }
                                    if (birthDay >= 521 && birthDay <= 621) {
                                      starSign = 'Gemini';
                                    }
                                    if (birthDay >= 622 && birthDay <= 722) {
                                      starSign = 'Cancer';
                                    }
                                    if (birthDay >= 723 && birthDay <= 822) {
                                      starSign = 'Leo';
                                    }
                                    if (birthDay >= 823 && birthDay <= 923) {
                                      starSign = 'Virgo';
                                    }
                                    if (birthDay >= 924 && birthDay <= 1022) {
                                      starSign = 'Libra';
                                    }
                                    if (birthDay >= 1023 && birthDay <= 1122) {
                                      starSign = 'Scorpio';
                                    }
                                    if (birthDay >= 1123 && birthDay <= 1224) {
                                      starSign = 'Sagittarius';
                                    }
                                    if (birthDay >= 1225 && birthDay <= 1231 ||
                                        birthDay >= 101 && birthDay <= 119) {
                                      starSign = 'Capricorn';
                                    }
                                    await controller.setPersonalityStarSign(
                                        starSign, 50);
                                  } else {
                                    Get.snackbar(
                                        '생년월일을 확인해주세요', '기본정보에서 생년월일을 추가해 주세요');
                                  }
                                },
                                child: const Text('별자리 정보 가져오기'))
                            : Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    if (birthDay >= 120 && birthDay <= 218)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/aquarius.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '물병자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 219 && birthDay <= 320)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/pisces.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '물고기자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 321 && birthDay <= 419)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/aries.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '양자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 420 && birthDay <= 520)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/taurus.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '황소자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 521 && birthDay <= 621)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/gemini.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '쌍둥이자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 622 && birthDay <= 722)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/cancer.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '게자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 723 && birthDay <= 822)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/leo.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '사자자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 823 && birthDay <= 923)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/virgo.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '처녀자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 924 && birthDay <= 1022)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/libra.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '천칭자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 1023 && birthDay <= 1122)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/scorpio.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '전갈자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 1123 && birthDay <= 1224)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/sagittarius.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '사수자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (birthDay >= 1225 && birthDay <= 1231 ||
                                        birthDay >= 101 && birthDay <= 119)
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/icons/capricorn.jpg'))),
                                          ),
                                          const SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: '염소자리',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  ${DateFormat('MM월 dd일').format(DateTime.parse(controller.birth.value))}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('물병자리: 01/20 ~ 02/18')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('물고기자리: 02/19 ~ 03/20')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('양자리: 03/21 ~ 04/19')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('황소자리: 04/20 ~ 05/20')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('쌍둥이자리: 05/21 ~ 06/21')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('게자리: 06/22 ~ 07/22')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('사자자리: 07/23 ~ 08/22')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('처녀자리: 08/23 ~ 09/23')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('천칭자리: 09/24 ~ 10/22')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('전갈자리: 10/23 ~ 11/22')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('사수자리: 11/23 ~ 12/24')),
                    Container(
                        padding: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: const Text('염소자리: 12/25 ~ 01/19')),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
