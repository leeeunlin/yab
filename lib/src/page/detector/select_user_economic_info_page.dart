import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';

// issues: #51 성격정보 입력, 검색 생성 - ellee
class SelectUserEconomicInfoPage extends GetView<UserInfoDetectorController> {
  const SelectUserEconomicInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              width: double.infinity,
              child:
                  Text('주거 정보를 선택해 주세요', style: Get.theme.textTheme.subtitle1),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.size.width / 2.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicMyhouse.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '자가',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicMyhouse.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicMyhouse.value == false) {
                          controller.economicMyhouse.value = true;
                          controller.economicPropertyAll.value = false;
                          controller.economicProperty.add('MyHouse');
                        } else {
                          controller.economicMyhouse.value = false;
                          controller.economicProperty.remove('MyHouse');
                          if (controller.economicProperty.isEmpty) {
                            controller.economicPropertyAll.value = true;
                            controller.economicProperty.clear();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.size.width / 2.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicJeonse.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '전ㆍ월세',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicJeonse.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicJeonse.value == false) {
                          controller.economicJeonse.value = true;
                          controller.economicPropertyAll.value = false;
                          controller.economicProperty.add('Jeonse');
                        } else {
                          controller.economicJeonse.value = false;
                          controller.economicProperty.remove('Jeonse');
                          if (controller.economicProperty.isEmpty) {
                            controller.economicPropertyAll.value = true;
                            controller.economicProperty.clear();
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
                    backgroundColor: controller.economicPropertyAll.value
                        ? Colors.deepPurpleAccent
                        : Colors.white),
                child: AutoSizeText(
                  '주거 정보 필터 제거',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.economicPropertyAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  controller.economicMyhouse.value = false;
                  controller.economicJeonse.value = false;
                  controller.economicPropertyAll.value = true;
                  controller.economicProperty.clear();
                },
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child:
                  Text('차량 정보를 선택해 주세요', style: Get.theme.textTheme.subtitle1),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.size.width / 3.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicMycar.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '자차',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicMycar.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicMycar.value == false) {
                          controller.economicMycar.value = true;
                          controller.economicCarAll.value = false;
                          controller.economicCar.add('MyCar');
                        } else {
                          controller.economicMycar.value = false;
                          controller.economicCar.remove('MyCar');
                          if (controller.economicCar.isEmpty) {
                            controller.economicCarAll.value = true;
                            controller.economicCar.clear();
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.size.width / 3.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicRentCar.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '렌트',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicRentCar.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicRentCar.value == false) {
                          controller.economicRentCar.value = true;
                          controller.economicCarAll.value = false;
                          controller.economicCar.add('RentCar');
                        } else {
                          controller.economicRentCar.value = false;
                          controller.economicCar.remove('RentCar');
                          if (controller.economicCar.isEmpty) {
                            controller.economicCarAll.value = true;
                            controller.economicCar.clear();
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.size.width / 3.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicLeaseCar.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '리스',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicLeaseCar.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicLeaseCar.value == false) {
                          controller.economicLeaseCar.value = true;
                          controller.economicCarAll.value = false;
                          controller.economicCar.add('LeaseCar');
                        } else {
                          controller.economicLeaseCar.value = false;
                          controller.economicCar.remove('LeaseCar');
                          if (controller.economicCar.isEmpty) {
                            controller.economicCarAll.value = true;
                            controller.economicCar.clear();
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
                    backgroundColor: controller.economicCarAll.value
                        ? Colors.deepPurpleAccent
                        : Colors.white),
                child: AutoSizeText(
                  '차량 정보 필터 제거',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.economicCarAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  controller.economicMycar.value = false;
                  controller.economicRentCar.value = false;
                  controller.economicLeaseCar.value = false;
                  controller.economicCarAll.value = true;
                  controller.economicCar.clear();
                },
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child:
                  Text('연료 정보를 선택해 주세요', style: Get.theme.textTheme.subtitle1),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicCarElectric.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '전기',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicCarElectric.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicCarElectric.value == false) {
                          controller.economicCarElectric.value = true;
                          controller.economicCarFuelAll.value = false;
                          controller.economicCarFuel.add('Electric');
                        } else {
                          controller.economicCarElectric.value = false;
                          controller.economicCarFuel.remove('Electric');
                          if (controller.economicCarFuel.isEmpty) {
                            controller.economicCarFuelAll.value = true;
                            controller.economicCarFuel.clear();
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicCarLPG.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        'LPG',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicCarLPG.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicCarLPG.value == false) {
                          controller.economicCarLPG.value = true;
                          controller.economicCarFuelAll.value = false;
                          controller.economicCarFuel.add('LPG');
                        } else {
                          controller.economicCarLPG.value = false;
                          controller.economicCarFuel.remove('LPG');
                          if (controller.economicCarFuel.isEmpty) {
                            controller.economicCarFuelAll.value = true;
                            controller.economicCarFuel.clear();
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicCarGasolin.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '휘발유',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicCarGasolin.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicCarGasolin.value == false) {
                          controller.economicCarGasolin.value = true;
                          controller.economicCarFuelAll.value = false;
                          controller.economicCarFuel.add('Gasolin');
                        } else {
                          controller.economicCarGasolin.value = false;
                          controller.economicCarFuel.remove('Gasolin');
                          if (controller.economicCarFuel.isEmpty) {
                            controller.economicCarFuelAll.value = true;
                            controller.economicCarFuel.clear();
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.size.width / 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.economicCarDiesel.value
                              ? Colors.deepPurple
                              : Colors.white),
                      child: AutoSizeText(
                        '경유',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                            color: controller.economicCarDiesel.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () async {
                        if (controller.economicCarDiesel.value == false) {
                          controller.economicCarDiesel.value = true;
                          controller.economicCarFuelAll.value = false;
                          controller.economicCarFuel.add('Diesel');
                        } else {
                          controller.economicCarDiesel.value = false;
                          controller.economicCarFuel.remove('Diesel');
                          if (controller.economicCarFuel.isEmpty) {
                            controller.economicCarFuelAll.value = true;
                            controller.economicCarFuel.clear();
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
                    backgroundColor: controller.economicCarFuelAll.value
                        ? Colors.deepPurpleAccent
                        : Colors.white),
                child: AutoSizeText(
                  '연료 정보 필터 제거',
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                      color: controller.economicCarFuelAll.value
                          ? Colors.white
                          : Colors.grey),
                ),
                onPressed: () {
                  controller.economicCarElectric.value = false;
                  controller.economicCarLPG.value = false;
                  controller.economicCarGasolin.value = false;
                  controller.economicCarDiesel.value = false;
                  controller.economicCarFuelAll.value = true;
                  controller.economicCarFuel.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
