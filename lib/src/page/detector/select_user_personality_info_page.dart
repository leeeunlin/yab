import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';

// issues: #51 성격정보 입력, 검색 생성 - ellee
class SelectUserPersonalityInfoPage
    extends GetView<UserInfoDetectorController> {
  const SelectUserPersonalityInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              width: double.infinity,
              child:
                  Text('MBTI를 선택해 주세요', style: Get.theme.textTheme.subtitle1),
            ),
            const SizedBox(height: 10),
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
                          backgroundColor: controller.personalityISTJ.value
                              ? Colors.blue
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
                        if (controller.personalityISTJ.value == false) {
                          controller.personalityISTJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ISTJ');
                        } else {
                          controller.personalityISTJ.value = false;
                          controller.personalityMBTI.remove('ISTJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityISTP.value
                              ? Colors.amber
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
                        if (controller.personalityISTP.value == false) {
                          controller.personalityISTP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ISTP');
                        } else {
                          controller.personalityISTP.value = false;
                          controller.personalityMBTI.remove('ISTP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityISFJ.value
                              ? Colors.blue
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
                        if (controller.personalityISFJ.value == false) {
                          controller.personalityISFJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ISFJ');
                        } else {
                          controller.personalityISFJ.value = false;
                          controller.personalityMBTI.remove('ISFJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityISFP.value
                              ? Colors.amber
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
                        if (controller.personalityISFP.value == false) {
                          controller.personalityISFP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ISFP');
                        } else {
                          controller.personalityISFP.value = false;
                          controller.personalityMBTI.remove('ISFP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
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
                          backgroundColor: controller.personalityINTJ.value
                              ? Colors.purple
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
                        if (controller.personalityINTJ.value == false) {
                          controller.personalityINTJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('INTJ');
                        } else {
                          controller.personalityINTJ.value = false;
                          controller.personalityMBTI.remove('INTJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityINTP.value
                              ? Colors.purple
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
                        if (controller.personalityINTP.value == false) {
                          controller.personalityINTP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('INTP');
                        } else {
                          controller.personalityINTP.value = false;
                          controller.personalityMBTI.remove('INTP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityINFJ.value
                              ? Colors.green
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
                        if (controller.personalityINFJ.value == false) {
                          controller.personalityINFJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('INFJ');
                        } else {
                          controller.personalityINFJ.value = false;
                          controller.personalityMBTI.remove('INFJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityINFP.value
                              ? Colors.green
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
                        if (controller.personalityINFP.value == false) {
                          controller.personalityINFP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('INFP');
                        } else {
                          controller.personalityINFP.value = false;
                          controller.personalityMBTI.remove('INFP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
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
                          backgroundColor: controller.personalityESTJ.value
                              ? Colors.blue
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
                        if (controller.personalityESTJ.value == false) {
                          controller.personalityESTJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ESTJ');
                        } else {
                          controller.personalityESTJ.value = false;
                          controller.personalityMBTI.remove('ESTJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityESTP.value
                              ? Colors.amber
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
                        if (controller.personalityESTP.value == false) {
                          controller.personalityESTP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ESTP');
                        } else {
                          controller.personalityESTP.value = false;
                          controller.personalityMBTI.remove('ESTP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityESFJ.value
                              ? Colors.blue
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
                        if (controller.personalityESFJ.value == false) {
                          controller.personalityESFJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ESFJ');
                        } else {
                          controller.personalityESFJ.value = false;
                          controller.personalityMBTI.remove('ESFJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityESFP.value
                              ? Colors.amber
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
                        if (controller.personalityESFP.value == false) {
                          controller.personalityESFP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ESFP');
                        } else {
                          controller.personalityESFP.value = false;
                          controller.personalityMBTI.remove('ESFP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
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
                          backgroundColor: controller.personalityENTJ.value
                              ? Colors.purple
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
                        if (controller.personalityENTJ.value == false) {
                          controller.personalityENTJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ENTJ');
                        } else {
                          controller.personalityENTJ.value = false;
                          controller.personalityMBTI.remove('ENTJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityENTP.value
                              ? Colors.purple
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
                        if (controller.personalityENTP.value == false) {
                          controller.personalityENTP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ENTP');
                        } else {
                          controller.personalityENTP.value = false;
                          controller.personalityMBTI.remove('ENTP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityENFJ.value
                              ? Colors.green
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
                        if (controller.personalityENFJ.value == false) {
                          controller.personalityENFJ.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ENFJ');
                        } else {
                          controller.personalityENFJ.value = false;
                          controller.personalityMBTI.remove('ENFJ');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.personalityENFP.value
                              ? Colors.green
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
                        if (controller.personalityENFP.value == false) {
                          controller.personalityENFP.value = true;
                          controller.personalityMBTIAll.value = false;
                          controller.personalityMBTI.add('ENFP');
                        } else {
                          controller.personalityENFP.value = false;
                          controller.personalityMBTI.remove('ENFP');
                          if (!controller.personalityISTJ.value &&
                              !controller.personalityISTP.value &&
                              !controller.personalityISFJ.value &&
                              !controller.personalityISFP.value &&
                              !controller.personalityINTJ.value &&
                              !controller.personalityINTP.value &&
                              !controller.personalityINFJ.value &&
                              !controller.personalityINFP.value &&
                              !controller.personalityESTJ.value &&
                              !controller.personalityESTP.value &&
                              !controller.personalityESFJ.value &&
                              !controller.personalityESFP.value &&
                              !controller.personalityENTJ.value &&
                              !controller.personalityENTP.value &&
                              !controller.personalityENFJ.value &&
                              !controller.personalityENFP.value) {
                            controller.personalityMBTIAll.value = true;
                            controller.personalityMBTI.clear();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.personalityMBTIAll.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  'MBTI 필터 제거 (전체)',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.personalityMBTIAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
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
                  controller.personalityENFP.value = false;
                  controller.personalityMBTIAll.value = true;
                  controller.personalityMBTI.clear();
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child:
                  Text('별자리 정보를 선택해 주세요', style: Get.theme.textTheme.subtitle1),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityAquarius.value ==
                                  false) {
                                controller.personalityAquarius.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Aquarius');
                              } else {
                                controller.personalityAquarius.value = false;
                                controller.personalityStarSign
                                    .remove('Aquarius');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color:
                                          controller.personalityAquarius.value
                                              ? Colors.deepPurple
                                              : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/aquarius.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('물병자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityPisces.value == false) {
                                controller.personalityPisces.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Pisces');
                              } else {
                                controller.personalityPisces.value = false;
                                controller.personalityStarSign.remove('Pisces');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityPisces.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/pisces.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('물고기자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityAries.value == false) {
                                controller.personalityAries.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Aries');
                              } else {
                                controller.personalityAries.value = false;
                                controller.personalityStarSign.remove('Aries');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityAries.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/aries.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('양자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityTaurus.value == false) {
                                controller.personalityTaurus.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Taurus');
                              } else {
                                controller.personalityTaurus.value = false;
                                controller.personalityStarSign.remove('Taurus');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityTaurus.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/taurus.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('황소자리')
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityGemini.value == false) {
                                controller.personalityGemini.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Gemini');
                              } else {
                                controller.personalityGemini.value = false;
                                controller.personalityStarSign.remove('Gemini');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityGemini.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/gemini.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('쌍둥이자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityCancer.value == false) {
                                controller.personalityCancer.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Cancer');
                              } else {
                                controller.personalityCancer.value = false;
                                controller.personalityStarSign.remove('Cancer');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityCancer.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/cancer.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('게자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityLeo.value == false) {
                                controller.personalityLeo.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Leo');
                              } else {
                                controller.personalityLeo.value = false;
                                controller.personalityStarSign.remove('Leo');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityLeo.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/leo.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('사자자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityVirgo.value == false) {
                                controller.personalityVirgo.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Virgo');
                              } else {
                                controller.personalityVirgo.value = false;
                                controller.personalityStarSign.remove('Virgo');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityVirgo.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/virgo.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('처녀자리')
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityLibra.value == false) {
                                controller.personalityLibra.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Libra');
                              } else {
                                controller.personalityLibra.value = false;
                                controller.personalityStarSign.remove('Libra');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityLibra.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/libra.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('천칭자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityScorpio.value ==
                                  false) {
                                controller.personalityScorpio.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Scorpio');
                              } else {
                                controller.personalityScorpio.value = false;
                                controller.personalityStarSign
                                    .remove('Scorpio');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller.personalityScorpio.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/scorpio.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('전갈자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalitySagittarius.value ==
                                  false) {
                                controller.personalitySagittarius.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign
                                    .add('Sagittarius');
                              } else {
                                controller.personalitySagittarius.value = false;
                                controller.personalityStarSign
                                    .remove('Sagittarius');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: controller
                                              .personalitySagittarius.value
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/sagittarius.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('사수자리')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.personalityCapricorn.value ==
                                  false) {
                                controller.personalityCapricorn.value = true;
                                controller.personalityStarSignAll.value = false;
                                controller.personalityStarSign.add('Capricorn');
                              } else {
                                controller.personalityCapricorn.value = false;
                                controller.personalityStarSign
                                    .remove('Capricorn');
                                if (!controller.personalityAquarius.value &&
                                    !controller.personalityPisces.value &&
                                    !controller.personalityAries.value &&
                                    !controller.personalityTaurus.value &&
                                    !controller.personalityGemini.value &&
                                    !controller.personalityCancer.value &&
                                    !controller.personalityLeo.value &&
                                    !controller.personalityVirgo.value &&
                                    !controller.personalityLibra.value &&
                                    !controller.personalityScorpio.value &&
                                    !controller.personalitySagittarius.value &&
                                    !controller.personalityCapricorn.value) {
                                  controller.personalityStarSignAll.value =
                                      true;
                                  controller.personalityStarSign.clear();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: Get.size.width / 5,
                              width: Get.size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color:
                                          controller.personalityCapricorn.value
                                              ? Colors.deepPurple
                                              : Colors.grey,
                                      width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icons/capricorn.jpg'))),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('염소자리')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.personalityStarSignAll.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  '별자리 필터 제거 (전체)',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.personalityStarSignAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  controller.personalityStarSignAll.value = true;
                  controller.personalityAquarius.value = false;
                  controller.personalityPisces.value = false;
                  controller.personalityAries.value = false;
                  controller.personalityTaurus.value = false;
                  controller.personalityGemini.value = false;
                  controller.personalityCancer.value = false;
                  controller.personalityLeo.value = false;
                  controller.personalityVirgo.value = false;
                  controller.personalityLibra.value = false;
                  controller.personalityScorpio.value = false;
                  controller.personalitySagittarius.value = false;
                  controller.personalityCapricorn.value = false;
                  controller.personalityStarSign.clear();
                },
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
