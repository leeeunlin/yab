import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/repository/send_board_repository.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SendBoardController extends GetxController {
  static SendBoardController get to => Get.find();
  // 무한스크롤 변수 ▼
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<DetectorModel> sendItemListdata = <DetectorModel>[].obs;
  RxBool hasMore = false.obs;
  Rx<DetectorModel> detectorUserModel = DetectorModel().obs; // detector만 사용

// 무한스크롤 변수 ▲
  RxList<DetectorModel> sendItemList = <DetectorModel>[].obs;

  Rx<PageController> pageController = PageController().obs;
  RxInt imageListNum = 1.obs; // 이미지 하단 숫자표시용
  RxInt imageFullListNum = 1.obs;
  RxBool repeatWrite = false.obs;

  RxBool isLoading = false.obs;
  RxBool cancelReservationLoading = false.obs;

  @override
  void onInit() async {
    if (!isLoading.value) {
      await onRefres();
      isLoading(true);
      update();
    }
// 무한스크롤 부분 ▼ 스크롤이 최 하단으로 이동할 것을 계속 보고있다가 스크롤이 끝나면 새로운 데이터 로딩
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });
// 무한스크롤 부분 ▲

    await refundCore();
    super.onInit();
  }

// 무한스크롤 부분 ▼
  _getData() async {
    isLoading.value = true;

    int offset = sendItemListdata.length;

    sendItemListdata
        .addAll(await SendBoardRepository.limitgetSendItemList(offset));

    isLoading.value = false;
    hasMore.value = sendItemListdata.length <
        sendItemList.length; // 전체 개수와 새로 불러와 적제되어있는 리스트의 개수가 같으면 완료
  }

  reload() async {
    isLoading.value = true;
    sendItemListdata.clear();
    _getData();
  }

  void sendInit() {
    imageListNum = 1.obs;
    imageFullListNum = 1.obs;
    pageController = PageController(initialPage: 0).obs;
  }

  Future<void> onRefres() async {
    sendItemList.clear();
    sendItemList.addAll(await getSendItemList());
  }

  // 내가 보낸 게시물 가져오기
  Future<List<DetectorModel>> getSendItemList() async {
    return await SendBoardRepository.getSendItemList();
  }

  // 내가 보낸 게시물에서 환불 체크 값 가져오기
  Future<bool?> getSendItemRefundCheck(String detectorKey) async {
    return await SendBoardRepository.getSendItemRefundCheck(detectorKey);
  }

  // 내가 보낸 게시물에서 환불 체크 목록 값 가져오기
  Future<Map<String, dynamic>> getRefundCheckList() async {
    return await SendBoardRepository.getRefundCheckList();
  }

  // 내가 보낸 게시물에서 환불 체크 (flase -> true)로 변경
  Future<void> setRefundCheck(String detectorKey) async {
    return await SendBoardRepository.setRefundCheck(detectorKey);
  }

  Future<bool> getRefundCheck(String detecotrKey) async {
    return await SendBoardRepository.getRefundCheck(detecotrKey);
  }

  Future<Map<String, dynamic>> getRefundCheckData(String detectorKey) async {
    return await SendBoardRepository.getRefundCheckData(detectorKey);
  }

  Future<void> getSendItem(String detectorKey) async {
    var getItem = await SendBoardRepository.getSendItem(detectorKey);
    UserInfoDetectorController.to.detectorUserModel.value = getItem;
  }

  // 내가 보낸 게시물에서 만료기간이 지나면 환불해주는 핵심 부분
  Future<void> refundCore() async {
    var f = NumberFormat('###,###,###,###');
    final String userKey =
        FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴
    Map<String, dynamic> refundMap =
        await getRefundCheckList(); // 내가 보낸 게시물에서 환불 체크 목록 값 가져오기

    for (String detectorKey in refundMap.keys) {
      bool refundCheck = await getRefundCheck(detectorKey);

      if (!refundCheck) {
        DateTime dateTime =
            (refundMap[detectorKey][FIELD_CREATEDDATE] as Timestamp).toDate();
        DateTime expiredTime = refundMap[detectorKey][FIELD_EXPIREDDATE] == null
            ? DateTime.now()
            : (refundMap[detectorKey][FIELD_EXPIREDDATE] as Timestamp).toDate();
        String expiredDay = refundMap[detectorKey][FIELD_EXPIREDDAY] == null
            ? ''
            : refundMap[detectorKey][FIELD_EXPIREDDAY] as String;

        if (refundExpiredTimeInfo(dateTime, expiredTime, expiredDay) == true) {
          // refund값을 false => true 변경           => O
          // (대답 않한 사람 수 * 인당 포인트) = 환불      => O
          // 환불 정책에 대하여 물어봐야 할 듯.. 환불한때 수수료 차감한 포인트를 곱해서 지급해야 할지
          // 포인트 목록에 작성                         => O
          // 노티스나 스낵바를 띄어줘야 할까?              => O

          await setRefundCheck(detectorKey); // refund 값을 (flase -> true)로 변경

          Map<String, dynamic> data = await getRefundCheckData(detectorKey);
          int totalUserCount = data[FIELD_USERLIST].length; // 광고를 받은 총원
          int answerUserCount = allRefundAnswerCount(data); // 광고에 응답한 총원

          num refundPrice =
              data[FIELD_REFUNDPRICE]! * (totalUserCount - answerUserCount);
          if (refundPrice != 0) {
            // 환불 대상 금액이 0원일 경우 Db에 기록하지 않음
            await UserController.to.addMyPoint(
                userKey, refundPrice, 'refund'); // 해당 유저에게 환불 포인트 지급
            Get.snackbar('내가 보낸 게시물 만료 안내',
                '보낸 게시물이 만료되어\n${f.format(refundPrice.floor())} 포인트가 환불 되었습니다.');
          }
        }
      }
    }
  }

  bool refundExpiredTimeInfo(
      DateTime dateTime, DateTime expiredTime, String expiredDay) {
    if (expiredDay == '') {
      Duration duration = DateTime.now().difference(dateTime);

      if (duration.inDays > 7) {
        return true;
      } else {
        return false;
      }
    } else {
      bool expiredCheck = DateTime.now().isAfter(expiredTime);
      if (expiredCheck) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool expiredTimeInfo(int index) {
    DateTime dateTime = sendItemListdata[index].createdDate!;
    DateTime expiredTime = sendItemListdata[index].expiredDate!;
    if (sendItemListdata[index].expiredDay == '') {
      Duration duration = DateTime.now().difference(dateTime);
      if (duration.inDays > 7) {
        return true;
      } else {
        return false;
      }
    } else {
      bool expiredCheck = DateTime.now().isAfter(expiredTime);
      if (expiredCheck) {
        return true;
      } else {
        return false;
      }
    }
  }

  int allRefundAnswerCount(Map<String, dynamic> data) {
    List<dynamic> a = (data[STRUCT_SELECTUSERLIST][FIELD_A]);
    List<dynamic> b = (data[STRUCT_SELECTUSERLIST][FIELD_B]);
    List<dynamic> c = (data[STRUCT_SELECTUSERLIST][FIELD_C]);
    List<dynamic> d = (data[STRUCT_SELECTUSERLIST][FIELD_D]);
    List<dynamic> e = (data[STRUCT_SELECTUSERLIST][FIELD_E]);
    List<dynamic> f = (data[STRUCT_SELECTUSERLIST][FIELD_F]);
    List<dynamic> g = (data[STRUCT_SELECTUSERLIST][FIELD_G]);
    List<dynamic> h = (data[STRUCT_SELECTUSERLIST][FIELD_H]);

    return a.length +
        b.length +
        c.length +
        d.length +
        e.length +
        f.length +
        g.length +
        h.length;
  }

  int allAnswerCount(int index) {
    return (sendItemListdata[index].selectUserModel!.toJson()[FIELD_A]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_B]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_C]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_D]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_E]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_F]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_G]).length +
        (sendItemListdata[index].selectUserModel!.toJson()[FIELD_H]).length;
  }

  //issues: #43 다시보내기 버튼을 클릭 할 경우 네트워크에서 바이트값을 가져올 수 있는 코드 - ellee
  Future<void> readNetworkImage(String imageUrl) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    UserInfoDetectorController.to.imagesController.add(bytes);
  }
}
