import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserHealthInfoPage extends GetView<UserController> {
  const UserHealthInfoPage({Key? key}) : super(key: key);

  Widget _healthTabaccoFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.healthTabaccoFilter.value = true;
        controller.healthTabacco.value = 0;
        await controller.setHealthTabacco(controller.healthTabacco.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  Widget _healthExerciseFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.healthExerciseFilter.value = true;
        controller.healthExercise.value = 0;
        await controller.setHealthExercise(controller.healthExercise.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('건강 정보'),
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
                    const Text('초기 설정값에서 변경해주셔야 YAB이 지급 됩니다.'),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text('일 평균 흡연 량 (개피)',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    !controller.healthTabaccoFilter.value
                        ? _healthTabaccoFilterElevatedButton()
                        : NumberPicker(
                            value: controller.healthTabacco.value.toInt(),
                            minValue: 0,
                            maxValue: 40,
                            step: 1,
                            itemHeight: 50,
                            itemWidth: 50,
                            itemCount: 5,
                            axis: Axis.horizontal,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black),
                            ),
                            onChanged: (value) async {
                              controller.healthTabacco.value = value;
                            },
                          ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text('주 평균 음주(소주기준)',
                          style: Get.theme.textTheme.subtitle1),
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
                                  backgroundColor:
                                      controller.healthAlcohol0.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '하지않음',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.healthAlcohol0.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.healthAlcohol0.value == false) {
                                  controller.healthAlcohol0.value = true;
                                  controller.healthAlcohol1.value = false;
                                  controller.healthAlcohol2.value = false;
                                  controller.healthAlcohol3.value = false;
                                  await controller.setHealthAlcohol('0', 50);
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
                                      controller.healthAlcohol1.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '1병 이하',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.healthAlcohol1.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.healthAlcohol1.value == false) {
                                  controller.healthAlcohol0.value = false;
                                  controller.healthAlcohol1.value = true;
                                  controller.healthAlcohol2.value = false;
                                  controller.healthAlcohol3.value = false;
                                  await controller.setHealthAlcohol('1', 50);
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
                                      controller.healthAlcohol2.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '2병',
                                maxLines: 1,
                                maxFontSize: 11,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.healthAlcohol2.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.healthAlcohol2.value == false) {
                                  controller.healthAlcohol0.value = false;
                                  controller.healthAlcohol1.value = false;
                                  controller.healthAlcohol2.value = true;
                                  controller.healthAlcohol3.value = false;
                                  await controller.setHealthAlcohol('2', 50);
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
                                      controller.healthAlcohol3.value
                                          ? Colors.deepPurple
                                          : Colors.white),
                              child: AutoSizeText(
                                '3병 이상',
                                maxLines: 1,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: controller.healthAlcohol3.value
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              onPressed: () async {
                                if (controller.healthAlcohol3.value == false) {
                                  controller.healthAlcohol0.value = false;
                                  controller.healthAlcohol1.value = false;
                                  controller.healthAlcohol2.value = false;
                                  controller.healthAlcohol3.value = true;
                                  await controller.setHealthAlcohol('3', 50);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text('일 평균 운동량 (시간)',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    !controller.healthExerciseFilter.value
                        ? _healthExerciseFilterElevatedButton()
                        : NumberPicker(
                            value: controller.healthExercise.value.toInt(),
                            minValue: 0,
                            maxValue: 24,
                            step: 1,
                            itemHeight: 50,
                            itemWidth: 50,
                            itemCount: 5,
                            axis: Axis.horizontal,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black),
                            ),
                            onChanged: (value) {
                              controller.healthExercise.value = value;
                            },
                          ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
