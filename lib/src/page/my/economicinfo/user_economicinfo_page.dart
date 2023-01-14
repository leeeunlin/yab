import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';

class UserEconomicInfoPage extends GetView<UserController> {
  const UserEconomicInfoPage({Key? key}) : super(key: key);

  @override
  // issues: #55 경제정보 입력 페이지
  Widget build(BuildContext context) {
    String address = '';
    if (controller.address.value != '') {
      address = controller.address.value;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('경제 정보'),
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
                      child: Text('거주지 정보를 가져오세요',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => SizedBox(
                        child: !controller.economicProperty.value
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (address != '') {
                                    controller.economicProperty.value = true;
                                  } else {
                                    Get.snackbar(
                                        '주소를 확인해주세요', '기본정보에서 주소를 추가해 주세요');
                                  }
                                },
                                child: const Text('주소지 가져오기'),
                              )
                            : Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width: double.infinity,
                                    child: Text('$address의 주택 정보를 입력해 주세요',
                                        style: Get.theme.textTheme.bodyMedium),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Get.size.width / 2.5,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller
                                                        .economicMyHouse.value
                                                    ? Colors.deepPurple
                                                    : Colors.white),
                                            onPressed: () async {
                                              if (controller
                                                      .economicMyHouse.value ==
                                                  false) {
                                                controller.economicMyHouse
                                                    .value = true;
                                                controller.economicJeonse
                                                    .value = false;
                                                await controller
                                                    .setEconomicProperty(
                                                        'MyHouse', 50);
                                              }
                                            },
                                            child: AutoSizeText(
                                              '자가',
                                              style: TextStyle(
                                                  color: controller
                                                          .economicMyHouse.value
                                                      ? Colors.white
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.size.width / 2.5,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller
                                                        .economicJeonse.value
                                                    ? Colors.deepPurple
                                                    : Colors.white),
                                            onPressed: () async {
                                              if (controller
                                                      .economicJeonse.value ==
                                                  false) {
                                                controller.economicMyHouse
                                                    .value = false;
                                                controller.economicJeonse
                                                    .value = true;
                                                await controller
                                                    .setEconomicProperty(
                                                        'Jeonse', 50);
                                              }
                                            },
                                            child: AutoSizeText(
                                              '전ㆍ월세',
                                              style: TextStyle(
                                                  color: controller
                                                          .economicJeonse.value
                                                      ? Colors.white
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Text('차량 정보를 입력해 주세요',
                          style: Get.theme.textTheme.subtitle1),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Get.size.width / 3.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.economicMyCar.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  onPressed: () async {
                                    controller.economicCar.value = true;
                                    if (controller.economicMyCar.value ==
                                        false) {
                                      controller.economicMyCar.value = true;
                                      controller.economicRentCar.value = false;
                                      controller.economicLeaseCar.value = false;
                                    }
                                    await controller
                                        .setEconomicCarInfo('MyCar');
                                  },
                                  child: Text(
                                    '자차',
                                    style: TextStyle(
                                        color: controller.economicMyCar.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ))),
                          SizedBox(
                              width: Get.size.width / 3.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.economicRentCar.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  onPressed: () async {
                                    controller.economicCar.value = true;
                                    if (controller.economicRentCar.value ==
                                        false) {
                                      controller.economicMyCar.value = false;
                                      controller.economicRentCar.value = true;
                                      controller.economicLeaseCar.value = false;
                                    }
                                    await controller
                                        .setEconomicCarInfo('RentCar');
                                  },
                                  child: Text(
                                    '렌트',
                                    style: TextStyle(
                                        color: controller.economicRentCar.value
                                            ? Colors.white
                                            : Colors.grey),
                                  ))),
                          SizedBox(
                              width: Get.size.width / 3.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.economicLeaseCar.value
                                              ? Colors.deepPurple
                                              : Colors.white),
                                  onPressed: () async {
                                    controller.economicCar.value = true;
                                    if (controller.economicLeaseCar.value ==
                                        false) {
                                      controller.economicMyCar.value = false;
                                      controller.economicRentCar.value = false;
                                      controller.economicLeaseCar.value = true;
                                    }
                                    await controller
                                        .setEconomicCarInfo('LeaseCar');
                                  },
                                  child: Text(
                                    '리스',
                                    style: TextStyle(
                                        color: controller.economicLeaseCar.value
                                            ? Colors.white
                                            : Colors.grey),
                                  )))
                        ],
                      ),
                    ),
                    if (controller.economicCar.value == true)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text('사용 연료 정보를 입력해야 포인트가 지급 됩니다.',
                                  style: Get.theme.textTheme.bodyMedium),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: Get.size.width / 5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                    .economicCarElectric.value
                                                ? Colors.deepPurple
                                                : Colors.white),
                                        onPressed: () async {
                                          if (controller
                                                  .economicCarElectric.value ==
                                              false) {
                                            controller.economicCarElectric
                                                .value = true;
                                            controller.economicCarLPG.value =
                                                false;
                                            controller.economicCarGasolin
                                                .value = false;
                                            controller.economicCarDiesel.value =
                                                false;
                                            await controller.setEconomicCar(
                                                'Electric', 50);
                                          }
                                        },
                                        child: AutoSizeText(
                                          '전기',
                                          minFontSize: 1,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: controller
                                                      .economicCarElectric.value
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ))),
                                SizedBox(
                                    width: Get.size.width / 5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller.economicCarLPG.value
                                                    ? Colors.deepPurple
                                                    : Colors.white),
                                        onPressed: () async {
                                          if (controller.economicCarLPG.value ==
                                              false) {
                                            controller.economicCarElectric
                                                .value = false;
                                            controller.economicCarLPG.value =
                                                true;
                                            controller.economicCarGasolin
                                                .value = false;
                                            controller.economicCarDiesel.value =
                                                false;
                                            await controller.setEconomicCar(
                                                'LPG', 50);
                                          }
                                        },
                                        child: AutoSizeText(
                                          'LPG',
                                          minFontSize: 1,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: controller
                                                      .economicCarLPG.value
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ))),
                                SizedBox(
                                    width: Get.size.width / 5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                    .economicCarGasolin.value
                                                ? Colors.deepPurple
                                                : Colors.white),
                                        onPressed: () async {
                                          if (controller
                                                  .economicCarGasolin.value ==
                                              false) {
                                            controller.economicCarElectric
                                                .value = false;
                                            controller.economicCarLPG.value =
                                                false;
                                            controller.economicCarGasolin
                                                .value = true;
                                            controller.economicCarDiesel.value =
                                                false;
                                            await controller.setEconomicCar(
                                                'Gasolin', 50);
                                          }
                                        },
                                        child: AutoSizeText(
                                          '휘발유',
                                          minFontSize: 1,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: controller
                                                      .economicCarGasolin.value
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ))),
                                SizedBox(
                                    width: Get.size.width / 5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: controller
                                                    .economicCarDiesel.value
                                                ? Colors.deepPurple
                                                : Colors.white),
                                        onPressed: () async {
                                          if (controller
                                                  .economicCarDiesel.value ==
                                              false) {
                                            controller.economicCarElectric
                                                .value = false;
                                            controller.economicCarLPG.value =
                                                false;
                                            controller.economicCarGasolin
                                                .value = false;
                                            controller.economicCarDiesel.value =
                                                true;
                                            await controller.setEconomicCar(
                                                'Diesel', 50);
                                          }
                                        },
                                        child: AutoSizeText(
                                          '경유',
                                          minFontSize: 1,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: controller
                                                      .economicCarDiesel.value
                                                  ? Colors.white
                                                  : Colors.grey),
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
