import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserEducationInfoPage extends GetView<UserController> {
  const UserEducationInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학력 정보'),
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
                    SizedBox(
                      width: double.infinity,
                      child:
                          Text('최종 학력', style: Get.theme.textTheme.subtitle1),
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
                            width: Get.size.width / 3.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationElementary.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '초등학교 졸업',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationElementary.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationElementary.value ==
                                    false) {
                                  controller.educationElementary.value = true;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation(
                                      'Elementary', 50);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: Get.size.width / 3.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationMiddle.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '중학교 졸업',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationMiddle.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationMiddle.value == false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = true;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation('Middle', 50);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: Get.size.width / 3.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationHigh.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '고등학교 졸업',
                                maxLines: 1,
                                maxFontSize: 11,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationHigh.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationHigh.value == false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = true;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation('High', 50);
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.size.width / 4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationJuniorCollege.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '전문학사',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color:
                                        controller.educationJuniorCollege.value
                                            ? Colors.white
                                            : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationJuniorCollege.value ==
                                    false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      true;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation(
                                      'JuniorCollege', 50);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: Get.size.width / 5.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationUniversity.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '학사',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationUniversity.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationUniversity.value ==
                                    false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = true;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation(
                                      'University', 50);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: Get.size.width / 5.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationMaster.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '석사',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationMaster.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationMaster.value == false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = true;
                                  controller.educationDoctor.value = false;
                                  await controller.setEducation('Master', 50);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: Get.size.width / 5.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.educationDoctor.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '박사',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.educationDoctor.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.educationDoctor.value == false) {
                                  controller.educationElementary.value = false;
                                  controller.educationMiddle.value = false;
                                  controller.educationHigh.value = false;
                                  controller.educationJuniorCollege.value =
                                      false;
                                  controller.educationUniversity.value = false;
                                  controller.educationMaster.value = false;
                                  controller.educationDoctor.value = true;
                                  await controller.setEducation('Doctor', 50);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
