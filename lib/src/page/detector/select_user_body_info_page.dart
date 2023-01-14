import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';

class SelectUserBodyInfoPage extends GetView<UserInfoDetectorController> {
  const SelectUserBodyInfoPage({Key? key}) : super(key: key);

  Widget _height() {
    return Obx(
      () => RangeSlider(
        min: 0,
        max: 250,
        divisions: 25,
        labels: RangeLabels(
          controller.bodyHeight.value.start.floor().toString(),
          controller.bodyHeight.value.end.floor().toString(),
        ),
        values: controller.bodyHeight.value,
        onChanged: (RangeValues values) {
          controller.bodyHeight.value = values;
        },
      ),
    );
  }

  Widget _weight() {
    return Obx(
      () => RangeSlider(
        min: 0,
        max: 250,
        divisions: 25,
        labels: RangeLabels(
          controller.bodyWeight.value.start.floor().toString(),
          controller.bodyWeight.value.end.floor().toString(),
        ),
        values: controller.bodyWeight.value,
        onChanged: (RangeValues values) {
          controller.bodyWeight.value = values;
        },
      ),
    );
  }

  Widget _vision() {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('좌')),
              Expanded(
                child: RangeSlider(
                  min: 0,
                  max: 3,
                  divisions: 30,
                  labels: RangeLabels(
                    controller.bodyLeftVision.value.start.toStringAsFixed(1),
                    controller.bodyLeftVision.value.end.toStringAsFixed(1),
                  ),
                  values: controller.bodyLeftVision.value,
                  onChanged: (RangeValues values) {
                    controller.bodyLeftVision.value = values;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('우')),
              Expanded(
                child: RangeSlider(
                  min: 0,
                  max: 3,
                  divisions: 30,
                  labels: RangeLabels(
                    controller.bodyRightVision.value.start.toStringAsFixed(1),
                    controller.bodyRightVision.value.end.toStringAsFixed(1),
                  ),
                  values: controller.bodyRightVision.value,
                  onChanged: (RangeValues values) {
                    controller.bodyRightVision.value = values;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bloodType() {
    return Obx(
      () => Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: Get.size.width / 6.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.bodyBloodTypeAll.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  '모두',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.bodyBloodTypeAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  if (controller.bodyBloodTypeAll.value == false) {
                    controller.bodyBloodTypeAll.value = true;
                    controller.bodyBloodTypeA.value = false;
                    controller.bodyBloodTypeB.value = false;
                    controller.bodyBloodTypeO.value = false;
                    controller.bodyBloodTypeAB.value = false;
                    controller.bodyBloodType.value = 'all';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: Get.size.width / 6.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.bodyBloodTypeA.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  'A',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.bodyBloodTypeA.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  if (controller.bodyBloodTypeA.value == false) {
                    controller.bodyBloodTypeAll.value = false;
                    controller.bodyBloodTypeA.value = true;
                    controller.bodyBloodTypeB.value = false;
                    controller.bodyBloodTypeO.value = false;
                    controller.bodyBloodTypeAB.value = false;
                    controller.bodyBloodType.value = 'A';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: Get.size.width / 6.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.bodyBloodTypeB.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  'B',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.bodyBloodTypeB.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  if (controller.bodyBloodTypeB.value == false) {
                    controller.bodyBloodTypeAll.value = false;
                    controller.bodyBloodTypeA.value = false;
                    controller.bodyBloodTypeB.value = true;
                    controller.bodyBloodTypeO.value = false;
                    controller.bodyBloodTypeAB.value = false;
                    controller.bodyBloodType.value = 'B';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: Get.size.width / 6.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.bodyBloodTypeO.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  'O',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.bodyBloodTypeO.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  if (controller.bodyBloodTypeO.value == false) {
                    controller.bodyBloodTypeAll.value = false;
                    controller.bodyBloodTypeA.value = false;
                    controller.bodyBloodTypeB.value = false;
                    controller.bodyBloodTypeO.value = true;
                    controller.bodyBloodTypeAB.value = false;
                    controller.bodyBloodType.value = 'O';
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: Get.size.width / 6.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.bodyBloodTypeAB.value
                        ? Colors.deepPurple
                        : Colors.white),
                child: AutoSizeText(
                  'AB',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.bodyBloodTypeAB.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  if (controller.bodyBloodTypeAB.value == false) {
                    controller.bodyBloodTypeAll.value = false;
                    controller.bodyBloodTypeA.value = false;
                    controller.bodyBloodTypeB.value = false;
                    controller.bodyBloodTypeO.value = false;
                    controller.bodyBloodTypeAB.value = true;
                    controller.bodyBloodType.value = 'AB';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footSize() {
    return Obx(
      () => RangeSlider(
        min: 200,
        max: 350,
        divisions: 15,
        labels: RangeLabels(
          controller.bodyFootSize.value.start.round().toString(),
          controller.bodyFootSize.value.end.round().toString(),
        ),
        values: controller.bodyFootSize.value,
        onChanged: (RangeValues values) {
          controller.bodyFootSize.value = values;
        },
      ),
    );
  }

  Widget _title(String title) {
    return SizedBox(child: Text(title, style: Get.theme.textTheme.subtitle1));
  }

  Widget _bodyHeightFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.bodyHeightFilter.value,
        onChanged: (value) {
          controller.bodyHeightFilter.value = value!;
        },
      ),
    );
  }

  Widget _bodyWeightFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.bodyWeightFilter.value,
        onChanged: (value) {
          controller.bodyWeightFilter.value = value!;
        },
      ),
    );
  }

  Widget _bodyVisionFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.bodyVisionFilter.value,
        onChanged: (value) {
          controller.bodyVisionFilter.value = value!;
        },
      ),
    );
  }

  Widget _bodyFootSizeFiltercheckBox() {
    return Obx(
      () => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: controller.bodyFootSizeFilter.value,
        onChanged: (value) {
          controller.bodyFootSizeFilter.value = value!;
        },
      ),
    );
  }

  Widget _bodyHeightFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.bodyHeightFilter.value = true;
      },
      child: const Text('키 선택'),
    );
  }

  Widget _bodyWeightFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.bodyWeightFilter.value = true;
      },
      child: const Text('몸무게 선택'),
    );
  }

  Widget _bodyVisionFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.bodyVisionFilter.value = true;
      },
      child: const Text('시력 선택'),
    );
  }

  Widget _bodyFootSizeFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        controller.bodyFootSizeFilter.value = true;
      },
      child: const Text('신발 사이즈 선택'),
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
                    _title(!controller.bodyHeightFilter.value
                        ? '키 (선택하지 않음)'
                        : '키 (${controller.bodyHeight.value.start.floor()}cm ~ ${controller.bodyHeight.value.end.floor()}cm)'),
                    _bodyHeightFiltercheckBox(),
                  ],
                ),
                !controller.bodyHeightFilter.value
                    ? _bodyHeightFilterElevatedButton()
                    : _height(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _title(!controller.bodyWeightFilter.value
                        ? '몸무게 (선택하지 않음)'
                        : '몸무게 (${controller.bodyWeight.value.start.floor()}kg ~ ${controller.bodyWeight.value.end.floor()}kg)'),
                    _bodyWeightFiltercheckBox()
                  ],
                ),
                !controller.bodyWeightFilter.value
                    ? _bodyWeightFilterElevatedButton()
                    : _weight(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _title(!controller.bodyVisionFilter.value
                        ? '시력 좌,우 (선택하지 않음)'
                        : '시력 좌(${controller.bodyLeftVision.value.start.toStringAsFixed(1)} ~ ${controller.bodyLeftVision.value.end.toStringAsFixed(1)}) 우(${controller.bodyRightVision.value.start.toStringAsFixed(1)} ~ ${controller.bodyRightVision.value.end.toStringAsFixed(1)})'),
                    _bodyVisionFiltercheckBox()
                  ],
                ),
                !controller.bodyVisionFilter.value
                    ? _bodyVisionFilterElevatedButton()
                    : _vision(),
                const SizedBox(height: 20),
                Row(
                  children: [_title('혈액형')],
                ),
                _bloodType(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _title(!controller.bodyFootSizeFilter.value
                        ? '신발 사이즈(선택하지 않음)'
                        : '신발 사이즈(${controller.bodyFootSize.value.start.floor()}mm ~ ${controller.bodyFootSize.value.end.floor()}mm)'),
                    _bodyFootSizeFiltercheckBox()
                  ],
                ),
                !controller.bodyFootSizeFilter.value
                    ? _bodyFootSizeFilterElevatedButton()
                    : _footSize(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
