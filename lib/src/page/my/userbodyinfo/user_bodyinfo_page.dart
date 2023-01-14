import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserBodyInfoPage extends GetView<UserController> {
  const UserBodyInfoPage({Key? key}) : super(key: key);

  // issues: #48 신체정보 초기 입력 시 버튼눌러 활성화 할 수 있도록 변경 - ellee
  Widget _bodyHeightFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.bodyHeightFilter.value = true;
        controller.bodyHeight.value = 100;
        await controller.setBodyHeight(controller.bodyHeight.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  Widget _bodyWeightFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.bodyWeightFilter.value = true;
        controller.bodyWeight.value = 20;
        await controller.setBodyWeight(controller.bodyWeight.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  Widget _bodyVisionFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.bodyVisionFilter.value = true;
        controller.bodyLeftVision.value = 0.0;
        controller.bodyRightVision.value = 0.0;
        await controller.setBodyLeftVision(controller.bodyLeftVision.value,
            controller.bodyRightVision.value, 50);
        await controller.setBodyRightVision(controller.bodyRightVision.value,
            controller.bodyLeftVision.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  Widget _bodyFootSizeFilterElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        controller.bodyFootSizeFilter.value = true;
        controller.bodyFootSize.value = 200;
        await controller.setBodyFootSize(controller.bodyFootSize.value, 50);
      },
      child: const Text('입력하기'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('신체 정보'),
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
                  const Text('초기 설정값에서 변경해주셔야 YAB이 지급 됩니다.'),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text('키를 알려주세요 (단위 cm)',
                        style: Get.theme.textTheme.subtitle1),
                  ),
                  !controller.bodyHeightFilter.value
                      ? _bodyHeightFilterElevatedButton()
                      : NumberPicker(
                          value: controller.bodyHeight.value.toInt(),
                          minValue: 100,
                          maxValue: 250,
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
                            controller.bodyHeight.value = value;
                          },
                        ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text('몸무게를 알려주세요 (단위 kg)',
                        style: Get.theme.textTheme.subtitle1),
                  ),
                  !controller.bodyWeightFilter.value
                      ? _bodyWeightFilterElevatedButton()
                      : NumberPicker(
                          value: controller.bodyWeight.value.toInt(),
                          minValue: 20,
                          maxValue: 250,
                          step: 5,
                          itemHeight: 50,
                          itemWidth: 50,
                          itemCount: 5,
                          axis: Axis.horizontal,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black),
                          ),
                          onChanged: (value) {
                            controller.bodyWeight.value = value;
                          },
                        ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child:
                        Text('시력을 알려주세요', style: Get.theme.textTheme.subtitle1),
                  ),
                  !controller.bodyVisionFilter.value
                      ? _bodyVisionFilterElevatedButton()
                      : SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Column(
                                  children: [
                                    Text('좌 ${controller.bodyLeftVision.value}',
                                        style: Get.theme.textTheme.bodyLarge),
                                    DecimalNumberPicker(
                                      value: controller.bodyLeftVision.value
                                          .toDouble(),
                                      minValue: 0,
                                      maxValue: 3,
                                      itemHeight: 50,
                                      itemWidth: 50,
                                      itemCount: 3,
                                      onChanged: (value) {
                                        // 1.9, 2.9에서 한번에 0.9로 넘기는 경우 0.8999.. 로 값 생성되는 버그 있음
                                        controller.bodyLeftVision.value =
                                            double.parse(
                                                value.toStringAsFixed(1));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                        '우 ${controller.bodyRightVision.value}',
                                        style: Get.theme.textTheme.bodyLarge),
                                    DecimalNumberPicker(
                                      value: controller.bodyRightVision.value
                                          .toDouble(),
                                      minValue: 0,
                                      maxValue: 3,
                                      itemHeight: 50,
                                      itemWidth: 50,
                                      itemCount: 3,
                                      onChanged: (value) {
                                        // 1.9, 2.9에서 한번에 0.9로 넘기는 경우 0.8999.. 로 값 생성되는 버그 있음
                                        controller.bodyRightVision.value =
                                            double.parse(
                                                value.toStringAsFixed(1));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: Text('혈액형', style: Get.theme.textTheme.subtitle1),
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
                                backgroundColor: controller.bodyBloodTypeA.value
                                    ? Colors.deepPurple
                                    : Colors.white),
                            child: AutoSizeText(
                              'A',
                              style: TextStyle(
                                  color: controller.bodyBloodTypeA.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.bodyBloodTypeA.value == false) {
                                controller.bodyBloodTypeA.value = true;
                                controller.bodyBloodTypeB.value = false;
                                controller.bodyBloodTypeO.value = false;
                                controller.bodyBloodTypeAB.value = false;
                                await controller.setbodyBloodType('A', 50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: controller.bodyBloodTypeB.value
                                    ? Colors.deepPurple
                                    : Colors.white),
                            child: AutoSizeText(
                              'B',
                              style: TextStyle(
                                  color: controller.bodyBloodTypeB.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.bodyBloodTypeB.value == false) {
                                controller.bodyBloodTypeA.value = false;
                                controller.bodyBloodTypeB.value = true;
                                controller.bodyBloodTypeO.value = false;
                                controller.bodyBloodTypeAB.value = false;
                                await controller.setbodyBloodType('B', 50);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.size.width / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: controller.bodyBloodTypeO.value
                                    ? Colors.deepPurple
                                    : Colors.white),
                            child: AutoSizeText(
                              'O',
                              style: TextStyle(
                                  color: controller.bodyBloodTypeO.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.bodyBloodTypeO.value == false) {
                                controller.bodyBloodTypeA.value = false;
                                controller.bodyBloodTypeB.value = false;
                                controller.bodyBloodTypeO.value = true;
                                controller.bodyBloodTypeAB.value = false;
                                await controller.setbodyBloodType('O', 50);
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
                                    controller.bodyBloodTypeAB.value
                                        ? Colors.deepPurple
                                        : Colors.white),
                            child: AutoSizeText(
                              'AB',
                              style: TextStyle(
                                  color: controller.bodyBloodTypeAB.value
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            onPressed: () async {
                              if (controller.bodyBloodTypeAB.value == false) {
                                controller.bodyBloodTypeA.value = false;
                                controller.bodyBloodTypeB.value = false;
                                controller.bodyBloodTypeO.value = false;
                                controller.bodyBloodTypeAB.value = true;
                                await controller.setbodyBloodType('AB', 50);
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
                    child: Text('신발 사이즈', style: Get.theme.textTheme.subtitle1),
                  ),
                  !controller.bodyFootSizeFilter.value
                      ? _bodyFootSizeFilterElevatedButton()
                      : NumberPicker(
                          value: controller.bodyFootSize.value.toInt(),
                          minValue: 200,
                          maxValue: 350,
                          step: 5,
                          itemHeight: 50,
                          itemWidth: 50,
                          itemCount: 5,
                          axis: Axis.horizontal,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black),
                          ),
                          onChanged: (value) {
                            controller.bodyFootSize.value = value;
                          },
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
