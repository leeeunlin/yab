import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';

// issues: #45 건강정보 입력, 검색 생성 - ellee
class SelectUserHealthInfoPage extends GetView<UserInfoDetectorController> {
  const SelectUserHealthInfoPage({Key? key}) : super(key: key);

  Widget _tabacco() {
    return Obx(
      () => RangeSlider(
        min: 0,
        max: 40,
        divisions: 40,
        labels: RangeLabels(
          controller.healthTabacco.value.start.floor().toString(),
          controller.healthTabacco.value.end.floor().toString(),
        ),
        values: controller.healthTabacco.value,
        onChanged: (RangeValues values) {
          controller.healthTabacco.value = values;
        },
      ),
    );
  }

  Widget _alcohol() {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.size.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controller.healthAlcoholAll.value
                            ? Colors.deepPurple
                            : Colors.white),
                    child: AutoSizeText(
                      '전체',
                      maxLines: 1,
                      minFontSize: 1,
                      style: TextStyle(
                          color: controller.healthAlcoholAll.value
                              ? Colors.white
                              : Colors.grey),
                    ),
                    onPressed: () {
                      if (controller.healthAlcoholAll.value == false) {
                        controller.healthAlcoholAll.value = true;
                        controller.healthAlcohol0.value = false;
                        controller.healthAlcohol1.value = false;
                        controller.healthAlcohol2.value = false;
                        controller.healthAlcohol3.value = false;
                        controller.healthAlcohol.value = 'all';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: Get.size.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controller.healthAlcohol0.value
                            ? Colors.deepPurple
                            : Colors.white),
                    child: AutoSizeText(
                      '마시지 않음',
                      maxLines: 1,
                      minFontSize: 1,
                      style: TextStyle(
                          color: controller.healthAlcohol0.value
                              ? Colors.white
                              : Colors.grey),
                    ),
                    onPressed: () {
                      if (controller.healthAlcohol0.value == false) {
                        controller.healthAlcoholAll.value = false;
                        controller.healthAlcohol0.value = true;
                        controller.healthAlcohol1.value = false;
                        controller.healthAlcohol2.value = false;
                        controller.healthAlcohol3.value = false;
                        controller.healthAlcohol.value = '0';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.size.width / 3.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controller.healthAlcohol1.value
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
                    onPressed: () {
                      if (controller.healthAlcohol1.value == false) {
                        controller.healthAlcoholAll.value = false;
                        controller.healthAlcohol0.value = false;
                        controller.healthAlcohol1.value = true;
                        controller.healthAlcohol2.value = false;
                        controller.healthAlcohol3.value = false;
                        controller.healthAlcohol.value = '1';
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: Get.size.width / 3.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controller.healthAlcohol2.value
                            ? Colors.deepPurple
                            : Colors.white),
                    child: AutoSizeText(
                      '2병',
                      maxLines: 1,
                      minFontSize: 1,
                      style: TextStyle(
                          color: controller.healthAlcohol2.value
                              ? Colors.white
                              : Colors.grey),
                    ),
                    onPressed: () {
                      if (controller.healthAlcohol2.value == false) {
                        controller.healthAlcoholAll.value = false;
                        controller.healthAlcohol0.value = false;
                        controller.healthAlcohol1.value = false;
                        controller.healthAlcohol2.value = true;
                        controller.healthAlcohol3.value = false;
                        controller.healthAlcohol.value = '2';
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: Get.size.width / 3.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controller.healthAlcohol3.value
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
                    onPressed: () {
                      if (controller.healthAlcohol3.value == false) {
                        controller.healthAlcoholAll.value = false;
                        controller.healthAlcohol0.value = false;
                        controller.healthAlcohol1.value = false;
                        controller.healthAlcohol2.value = false;
                        controller.healthAlcohol3.value = true;
                        controller.healthAlcohol.value = '3';
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _exercise() {
    return Obx(
      () => RangeSlider(
        min: 0,
        max: 24,
        divisions: 24,
        labels: RangeLabels(
          controller.healthExercise.value.start.round().toString(),
          controller.healthExercise.value.end.round().toString(),
        ),
        values: controller.healthExercise.value,
        onChanged: (RangeValues values) {
          controller.healthExercise.value = values;
        },
      ),
    );
  }

  Widget _title(String title) {
    return SizedBox(child: Text(title, style: Get.theme.textTheme.subtitle1));
  }

  Widget _healthTabaccoFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.healthTabaccoFilter.value,
        onChanged: (value) {
          controller.healthTabaccoFilter.value = value!;
        },
      ),
    );
  }

  Widget _healthExerciseFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.healthExerciseFilter.value,
        onChanged: (value) {
          controller.healthExerciseFilter.value = value!;
        },
      ),
    );
  }

  Widget _healthTabaccoFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.healthTabaccoFilter.value = true;
      },
      child: const Text('흡연량 선택'),
    );
  }

  Widget _healthExerciseFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.healthExerciseFilter.value = true;
      },
      child: const Text('운동량 선택'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
                    _title(!controller.healthTabaccoFilter.value
                        ? '일 평균 흡연량 (선택하지 않음)'
                        : '일 평균 흡연량 (${controller.healthTabacco.value.start.floor()}개피 ~ ${controller.healthTabacco.value.end.floor()}개피)'),
                    _healthTabaccoFiltercheckBox(),
                  ],
                ),
                !controller.healthTabaccoFilter.value
                    ? _healthTabaccoFilterElevatedButton()
                    : _tabacco(),
                const SizedBox(height: 20),
                Row(
                  children: [_title('주량')],
                ),
                _alcohol(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _title(!controller.healthExerciseFilter.value
                        ? '일 평균 운동량(선택하지 않음)'
                        : '운동량(${controller.healthExercise.value.start.floor()}시간 ~ ${controller.healthExercise.value.end.floor()}시간)'),
                    _healthExerciseFiltercheckBox()
                  ],
                ),
                !controller.healthExerciseFilter.value
                    ? _healthExerciseFilterElevatedButton()
                    : _exercise(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
