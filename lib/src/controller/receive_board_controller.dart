import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/repository/receive_board_repository.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class ReceiveBoardController extends GetxController {
  static ReceiveBoardController get to => Get.find();
  // 무한스크롤 변수 ▼
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<DetectorModel> receiveItemListdata = <DetectorModel>[].obs;
  RxBool hasMore = false.obs;
  RxBool firstLoading = false.obs;
// 무한스크롤 변수 ▲

  RxBool isLoading = false.obs;
  RxBool vsAFlag = false.obs;
  RxBool vsBFlag = false.obs;
  RxBool vsCFlag = false.obs;
  RxBool vsDFlag = false.obs;

  RxString groupValue = ''.obs;
  var pageController = PageController().obs;
  RxInt imageListNum = 1.obs; // 이미지 하단 숫자표시용
  RxInt imageFullListNum = 1.obs;
  RxList<DetectorModel> receiveItemList = <DetectorModel>[].obs;
  RxList<DetectorModel> receiveViewCheck = <DetectorModel>[].obs;
  RxInt receiveViewCount = 0.obs;

  // 만료기간이 초과되었으면 postView를 true로 변경
  Future<void> expiredChecker() async {
    receiveViewCheck.clear();
    receiveViewCheck.addAll(await getReceiveItemAllViewCheck());
    for (int i = 0; i < receiveViewCheck.length; i++) {
      if (expiredTimeInfo2(i)) {
        await setReceiveItemViewCheck(receiveViewCheck[i].detectorKey!);
      }
    }
  }

  // 코드 수정 필요
  bool expiredTimeInfo2(int index) {
    DateTime dateTime = receiveViewCheck[index].createdDate!;
    DateTime expiredTime = receiveViewCheck[index].expiredDate!;
    if (receiveViewCheck[index].expiredDay == '') {
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
    DateTime dateTime = receiveItemListdata[index].createdDate!;
    DateTime expiredTime = receiveItemListdata[index].expiredDate!;
    if (receiveItemListdata[index].expiredDay == '') {
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

  void sendInit() {
    vsAFlag = false.obs;
    vsBFlag = false.obs;
    vsCFlag = false.obs;
    vsDFlag = false.obs;
    groupValue.value = '';
    imageListNum = 1.obs;
    imageFullListNum = 1.obs;
    pageController = PageController(initialPage: 0).obs;
  }

  void changeMultiBoolValue(int value) {
    if (value == 0) {
      sendInit();
      vsAFlag(true);
    } else if (value == 1) {
      sendInit();
      vsBFlag(true);
    } else if (value == 2) {
      sendInit();
      vsCFlag(true);
    } else if (value == 3) {
      sendInit();
      vsDFlag(true);
    }
  }

  // 내게 온 게시물 가져오기
  Future<List<DetectorModel>> getReceiveItemList() async {
    return await ReceiveBoardRepository.getReceiveItemList();
  }

  // 내게 온 게시물의 목록을 읽었는지 않읽었는지 체크하는 함수
  Future<bool> getReceiveItemViewCheck(String detectorKey) async {
    return await ReceiveBoardRepository.getReceiveItemViewCheck(detectorKey);
  }

  // 내게 온 게시물의 목록 중 보지않은 게시물을 확인하는 함수
  Future<List<DetectorModel>> getReceiveItemAllViewCheck() async {
    return await ReceiveBoardRepository.getReceiveItemAllViewCheck();
  }

  // 내게 온 게시물의 목록을 읽음으로 변경하는 함수 (postview => true로 변경)
  Future<void> setReceiveItemViewCheck(String detectorKey) async {
    await ReceiveBoardRepository.setReceiveItemViewCheck(
        detectorKey); // postview값을 true로 변경
  }

  // 메인 화면 내게 온 게시물 뷰 false값 구해서 receiveViewCount값에 넣는 함수
  Future<void> getViewCheck() async {
    int? viewCount = await ReceiveBoardRepository.getViewCheck();
    receiveViewCount.value = viewCount!;
  }

  // 답변 결과를 해당 답변지에 키값을 입력하는 함수
  Future<void> setAnswerKey(String detectorKey) async {
    if (vsAFlag.value) {
      await ReceiveBoardRepository.setAnswerTokenKey(detectorKey, FIELD_A);
      await ReceiveBoardRepository.setAnswerKey(detectorKey, FIELD_A);
    } else if (vsBFlag.value) {
      await ReceiveBoardRepository.setAnswerTokenKey(detectorKey, FIELD_B);
      await ReceiveBoardRepository.setAnswerKey(detectorKey, FIELD_B);
    } else if (vsCFlag.value) {
      await ReceiveBoardRepository.setAnswerTokenKey(detectorKey, FIELD_C);
      await ReceiveBoardRepository.setAnswerKey(detectorKey, FIELD_C);
    } else if (vsDFlag.value) {
      await ReceiveBoardRepository.setAnswerTokenKey(detectorKey, FIELD_D);
      await ReceiveBoardRepository.setAnswerKey(detectorKey, FIELD_D);
    }
  }

  //답변한 게시글을 다시 선택하였을때 선택한 버튼을 표시하는 함수
  Future<int> getSelectItem(String detectorKey) async {
    return await ReceiveBoardRepository.getSelectItem(detectorKey);
  }

  // Promotion 결과를 입력하는 함수
  Future<void> setPromotionAnswerKey(String detectorKey) async {
    await ReceiveBoardRepository.setAnswerTokenKey(detectorKey, FIELD_A);
    await ReceiveBoardRepository.setAnswerKey(detectorKey, FIELD_A);
  }

  // VS & Multi에 사용하는 포인트 추가 함수
  Future<void> addpointAnswer(String detectorKey, num price) async {
    final String userKey =
        FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴
    await setReceiveItemViewCheck(detectorKey); // postview값을 true로 변경

    // issues: #47 계산식 코드 버그 수정
    await UserController.to
        .addMyPoint(userKey, price, 'receive'); // 해당 유저에게 포인트 지급 (2차 지급)

    Get.snackbar(
      '포인트 지급 안내',
      '$price 포인트가 지급되었습니다.',
      isDismissible: true,
    );
  }

  // Promotion에 사용하는 포인트 추가 함수
  // Future<void> addPointView() async {}

  @override
  void onInit() async {
    if (!isLoading.value) {
      await onRefres();
      await expiredChecker();
      await getViewCheck();
      isLoading(true);
      update();
    }

    _getData();
// 무한스크롤 부분 ▼ 스크롤이 최 하단으로 이동할 것을 계속 보고있다가 스크롤이 끝나면 새로운 데이터 로딩
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });
// 무한스크롤 부분 ▲

    super.onInit();
  }

// 무한스크롤 부분 ▼
  _getData() async {
    isLoading.value = true;

    int offset = receiveItemListdata.length;

    receiveItemListdata
        .addAll(await ReceiveBoardRepository.limitgetReceiveItemList(offset));

    isLoading.value = false;
    hasMore.value = receiveItemListdata.length <
        receiveItemList.length; // 전체 개수와 새로 불러와 적제되어있는 리스트의 개수가 같으면 완료
    firstLoading.value = true;
  }

  reload() async {
    isLoading.value = true;
    receiveItemListdata.clear();
    _getData();
  }
// 무한스크롤 부분 ▲

  Future<void> onRefres() async {
    receiveItemList.clear();
    receiveItemList.addAll(await getReceiveItemList());
  }
}
