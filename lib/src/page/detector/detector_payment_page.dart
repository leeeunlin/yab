import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/logger.dart';

class DetectorPaymentPage extends GetView<UserInfoDetectorController> {
  const DetectorPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    var _devider = Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[350],
      indent: getProportionateScreenWidth(20),
      endIndent: getProportionateScreenWidth(20),
    );

    var _border = const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));

    TextFormField _textField(String hintText, TextEditingController controller,
        TextInputType textInputType) {
      return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      );
    }

    Widget expiryDateDropDown() {
      return Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                locale: LocaleType.ko,
                minTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + 1),
                maxTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + 7),
                onConfirm: (date) {
                  controller.expiredDaySelectedValue.value = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          DateTime.now().hour,
                          DateTime.now().minute,
                          DateTime.now().second)
                      .toString();
                  // 선택된 날짜와 오늘 날짜 계산
                  controller.setExpiryDateSelected(
                      DateTime(date.year, date.month, date.day)
                          .difference(DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day))
                          .inDays
                          .toString());
                },
              );
            },
            child: Text(controller.expiredDaySelectedValue.value == ''
                ? '만료 일자를 선택해 주세요'
                : '${DateTime.parse(controller.expiredDaySelectedValue.value).year}년 ${DateTime.parse(controller.expiredDaySelectedValue.value).month}월 ${DateTime.parse(controller.expiredDaySelectedValue.value).day}일'),
          ),
        ),
      );
    }

    Widget _reservationCheckBox() {
      return Obx(
        () => Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.amber,
          value: controller.reservationDateSelected.value,
          onChanged: (value) {
            controller.reservationDateSelected.value = value!;
            controller.expiredDaySelectedValue.value = '';
            controller.reservationDateSelectedValue.value = '';
            controller.reservationExpiredDateSelectedValue.value = '';
          },
        ),
      );
    }

    // 예약시간 버튼
    // 1. 시간 선택 시 표시 컨트롤러 값 만들어야함 - 완료
    // 2. 결과 페이지에서 표시
    // 3. 시간값을 선택 시 firestore 저장값이 이상 확인
    // 4. 시간값을 선택 안할 시 firestore null로 저장
    Widget reservationDateDropDown() {
      return Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: Get.size.width / 2.3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            onPressed: () {
              controller.reservationExpiredDateSelectedValue.value = '';

              DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
                locale: LocaleType.ko,
                minTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  DateTime.now().hour + 1,
                ),
                maxTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + 6),
                onConfirm: (date) {
                  controller.reservationDateSelectedValue.value = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          date.hour,
                          date.minute)
                      .toString();
                  controller.setReservationDateValued(date.toLocal());
                },
              );
            },
            child: AutoSizeText(
              controller.reservationDateSelectedValue.value == ''
                  ? '게시 시작일'
                  : '${DateTime.parse(controller.reservationDateSelectedValue.value).year}년 ${DateTime.parse(controller.reservationDateSelectedValue.value).month}월 ${DateTime.parse(controller.reservationDateSelectedValue.value).day}일\n${DateTime.parse(controller.reservationDateSelectedValue.value).hour}시 ${DateTime.parse(controller.reservationDateSelectedValue.value).minute}분 부터',
              maxLines: 2,
            ),
          ),
        ),
      );
    }

    Widget reservationExpiryDateDropDown() {
      return Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: Get.size.width / 2.3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            onPressed: () {
              if (controller.reservationDateSelectedValue.value == '') {
                Get.snackbar('게시 일 선택', '게시 일자을 선택해 주세요.');
                return;
              }
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                locale: LocaleType.ko,
                minTime: DateTime(
                  DateTime.parse(controller.reservationDateSelectedValue.value)
                      .year,
                  DateTime.parse(controller.reservationDateSelectedValue.value)
                      .month,
                  DateTime.parse(controller.reservationDateSelectedValue.value)
                          .day +
                      1,
                ),
                maxTime: DateTime(
                    DateTime.parse(
                            controller.reservationDateSelectedValue.value)
                        .year,
                    DateTime.parse(
                            controller.reservationDateSelectedValue.value)
                        .month,
                    DateTime.parse(
                                controller.reservationDateSelectedValue.value)
                            .day +
                        7),
                onConfirm: (date) {
                  controller
                      .reservationExpiredDateSelectedValue.value = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          DateTime.parse(
                                  controller.reservationDateSelectedValue.value)
                              .hour,
                          DateTime.parse(
                                  controller.reservationDateSelectedValue.value)
                              .minute,
                          DateTime.parse(
                                  controller.reservationDateSelectedValue.value)
                              .second)
                      .toString();

                  // 예약일과 예약만료일 날짜 계산
                  controller.setExpiryDateSelected(DateTime(
                          DateTime.parse(controller.reservationExpiredDateSelectedValue.value)
                              .year,
                          DateTime.parse(controller.reservationExpiredDateSelectedValue.value)
                              .month,
                          DateTime.parse(controller
                                  .reservationExpiredDateSelectedValue.value)
                              .day)
                      .difference(DateTime(
                          DateTime.parse(controller.reservationDateSelectedValue.value)
                              .year,
                          DateTime.parse(
                                  controller.reservationDateSelectedValue.value)
                              .month,
                          DateTime.parse(
                                  controller.reservationDateSelectedValue.value)
                              .day))
                      .inDays
                      .toString());
                },
              );
            },
            child: AutoSizeText(
              controller.reservationExpiredDateSelectedValue.value == ''
                  ? '게시 만료일'
                  : '${DateTime.parse(controller.reservationExpiredDateSelectedValue.value).year}년 ${DateTime.parse(controller.reservationExpiredDateSelectedValue.value).month}월 ${DateTime.parse(controller.reservationExpiredDateSelectedValue.value).day}일\n${DateTime.parse(controller.reservationDateSelectedValue.value).hour}시 ${DateTime.parse(controller.reservationDateSelectedValue.value).minute}분 까지',
              maxLines: 2,
            ),
          ),
        ),
      );
    }

    void nextPage() async {
      num userPoint = await UserController.to.getPoint();
      String _paymentPeople = controller.paymentPeople.value.text;
      String _paymentPrice = controller.paymentPrice.value.text;
      String? expiryDate = controller.expiredDaySelectedValue.value;
      String? reservationDate = controller.reservationDateSelectedValue.value;
      String? expiryReservationDate =
          controller.reservationExpiredDateSelectedValue.value;
      DateTime createTime = DateTime.now(); // 생성시간

      // 시간비교함수

      if (_paymentPeople.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '필요한 인원수를 입력해 주세요.');
        return;
      }
      if (_paymentPrice.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '인당 가격을 입력해 주세요.');
        return;
      }
      if (expiryDate.isEmpty && reservationDate.isEmpty) {
        // 일자 둘다 선택이 되지 않았을 때
        Get.snackbar('예약 게시일 선택', ' 예약 게시일을 선택해 주세요.');
        return;
      }
      if (reservationDate.isNotEmpty) {
        logger.i(reservationDate);
        num selectTimeComparison = num.parse(
            DateFormat('yyyyMMddkkmm').format(DateTime.parse(reservationDate)));
        num todayTimeComparison =
            num.parse(DateFormat('yyyyMMddkkmm').format(DateTime.now()));
        if (expiryReservationDate.isEmpty) {
          logger.i(expiryReservationDate);
          Get.snackbar('만료일자 선택', '게시글의 만료 일자를 선택해 주세요');
          return;
        } else if (selectTimeComparison < todayTimeComparison) {
          Get.snackbar('예약 시간 확인', '예약시간은 현재시간 이후로 지정하세요');
          return;
        }
      }
      // if (expiryDate.isEmpty) {
      //   Get.snackbar('만료 일자 선택', '만료 일자를 선택해 주세요.');
      //   return;
      // }
      // if (reservationDate.isEmpty) {
      //   Get.snackbar('예약 발송 일자 선택', '예약 발송 일자를 선택해 주세요');
      //   return;
      // }
      // if (expiryReservationDate.isEmpty) {
      //   Get.snackbar('예약 발송 만료 일자 선택', '예약 발송 만료 일자를 선택해 주세요');
      //   return;
      // }

      if (controller.detectorUserModel.value.users!.length <
          num.parse(controller.paymentPeople.text)) {
        Get.snackbar('인원수 초과.',
            '검색된 인원 ${controller.detectorUserModel.value.users!.length}명 보다 많은 ${controller.paymentPeople.text}명을 입력하였습니다.');
        return;
      }
      if ((num.parse(_paymentPrice) * num.parse(_paymentPeople)) > userPoint) {
        Get.snackbar('YAB 부족.',
            '${f.format((num.parse(_paymentPrice) * num.parse(_paymentPeople)) - userPoint)}YAB 만큼 부족합니다.');
        return;
      }
      if (num.parse(_paymentPrice) < 1000) {
        Get.snackbar('최소 금액이 맞지 않습니다.', '인당 가격은 최소 1,000 YAB 입니다.');
        return;
      }

      controller
          .setCreatedDateValued(createTime); // createTime detectorModel 저장

      if (expiryDate.isNotEmpty) {
        DateTime expiredTime =
            DateTime.parse(controller.expiredDaySelectedValue.value);
        controller
            .setExpiredDateValued(expiredTime); // expiredTime detectorModel 저장
      }
      if (expiryReservationDate.isNotEmpty) {
        DateTime expiredTime = DateTime.parse(
            controller.reservationExpiredDateSelectedValue.value);
        controller
            .setExpiredDateValued(expiredTime); // expiredTime detectorModel 저장
      }

      controller.setPaymentPeopleValued(int.parse(_paymentPeople));
      controller
          .setDetecotorUserTokenList(controller.detectorUserModel.value.users!);
      controller.setPaymentPriceValued(int.parse(_paymentPrice));
      await Get.toNamed('/DetectorResultPage');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('결제'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .requestFocus(FocusNode()); // TextFormField에서 포커스 사라질 시 키보드 숨김
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => ListView(
              children: [
                _textField(
                    '필요한 인원수', controller.paymentPeople, TextInputType.number),
                _devider,
                _textField(
                    '인당 가격', controller.paymentPrice, TextInputType.number),
                _devider,
                Row(
                  children: [_reservationCheckBox(), const Text('예약 게시글 작성')],
                ),
                if (!controller.reservationDateSelected.value)
                  expiryDateDropDown(),
                if (controller.reservationDateSelected.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reservationDateDropDown(),
                      const Text('~'),
                      reservationExpiryDateDropDown(),
                    ],
                  ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                      '검색된 인원은 ${controller.detectorUserModel.value.users?.length}명 이며,\n${f.format(UserController.to.userModel.value.coin!.floor())}YAB을 보유하고 있습니다. \n인당 가격은 최소 1,000 YAB 입니다.',
                      style: Get.theme.textTheme.subtitle2),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                nextPage();
              },
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }
}
