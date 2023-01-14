import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/model/user_info/address_detail.model.dart';
import 'package:yab_v2/src/model/user_info/address_model.dart';
import 'package:yab_v2/src/repository/address_search_repository.dart';
import 'package:yab_v2/src/repository/user_repository.dart';

class AddressSearchController extends GetxController {
  static AddressSearchController get to => Get.find();

  TextEditingController addressTextEditngController = TextEditingController();
  RxString addressTextEditngValue = ''.obs;

  Rx<AddressModel> addressModel = AddressModel().obs;

  Rx<AddressDetailModel> addressParcelDetailModel =
      AddressDetailModel().obs; // 지번 주소 모델
  Rx<AddressDetailModel> addressRoadDetailModel =
      AddressDetailModel().obs; // 도로명 주소 모델

  RxBool isGettingLocation = false.obs;

  // 텍스트 에디터 컨트롤러 초기화
  void addressTextEditngControllerInit() async {
    addressTextEditngController.clear();
  }

  // 주소 목록 초기화
  void addressModelInit() async {
    addressModel(AddressModel());
  }

  // 마이페이지에 내정보 입력할때 쓰는 주소 검색 API
  Future<AddressModel> searchAddressByStr(String text) async {
    return await AddressSearchRepository.searchAddressByStr(text);
  }

  // 찾기에서 유저를 검색할때 쓰는 주소 검색 API (법정동 기준)
  Future<AddressModel> detectorAddressByStr(String text) async {
    return await AddressSearchRepository.detectorAddressByStr(text);
  }

  // 디테일한 지번 주소 가져오기
  Future<AddressDetailModel> findParcelAddressByCoordinate(
      {required double log, required double lat}) async {
    return await AddressSearchRepository.findParcelAddressByCoordinate(
        log: log, lat: lat);
  }

  // 디테일한 도로명 주소 가져오기
  Future<AddressDetailModel> findRoadAddressByCoordinate(
      {required double log, required double lat}) async {
    return await AddressSearchRepository.findRoadAddressByCoordinate(
        log: log, lat: lat);
  }

  //issues: #20 주소검색 추가 - ellee
  Future<void> testAddress(int index) async {
    double log = double.parse(
        addressModel.value.result!.items![index].point!.x.toString());
    double lat = double.parse(
        addressModel.value.result!.items![index].point!.y.toString());
    addressParcelDetailModel.value = await findParcelAddressByCoordinate(
        log: log, lat: lat); // 지번 주소 컨트롤러 변수 저장
    // 시
    UserInfoDetectorController.to.userModelAddressLevel1SelectedValue.value =
        addressParcelDetailModel.value.result![0].structure!.level1.toString();
    // 군,구
    UserInfoDetectorController.to.userModelAddressLevel2SelectedValue.value =
        addressParcelDetailModel.value.result![0].structure!.level2.toString();
    // 동
    UserInfoDetectorController.to.userModelAddressLevel4LSelectedValue.value =
        addressParcelDetailModel.value.result![0].structure!.level4L.toString();
    // String? userModelAddressLevel4A =
    //     addressParcelDetailModel.value.result![0].structure!.level4A;
    // String? userModelAddressLevel5 =
    //     addressParcelDetailModel.value.result![0].structure!.level5;
    // String? userModelAddressLevelText =
    //     addressParcelDetailModel.value.result![0].text;
  }

  Future<void> setAddress(int index, num addPoint) async {
    double log = double.parse(
        addressModel.value.result!.items![index].point!.x.toString());
    double lat = double.parse(
        addressModel.value.result!.items![index].point!.y.toString());

    addressParcelDetailModel.value = await findParcelAddressByCoordinate(
        log: log, lat: lat); // 지번 주소 컨트롤러 변수 저장
    addressRoadDetailModel.value = await findRoadAddressByCoordinate(
        log: log, lat: lat); // 도로명 주소 컨트롤러 변수 저장

    String? userModelAddressLevel1 =
        addressRoadDetailModel.value.result![0].structure!.level1;
    String? userModelAddressLevel2 =
        addressRoadDetailModel.value.result![0].structure!.level2;
    String? userModelAddressLevel4A =
        addressRoadDetailModel.value.result![0].structure!.level4A;

    UserController.to.address.value =
        '$userModelAddressLevel1 $userModelAddressLevel2 $userModelAddressLevel4A';

    UserController.to.userModel.update((_user) {
      // 주소찾기에서 클릭 시 도로명 주소 userModel 업데이트
      _user!.address!.roadAddress!.level1 =
          addressRoadDetailModel.value.result![0].structure!.level1;
      _user.address!.roadAddress!.level2 =
          addressRoadDetailModel.value.result![0].structure!.level2;
      _user.address!.roadAddress!.level4A =
          addressRoadDetailModel.value.result![0].structure!.level4A;
      _user.address!.roadAddress!.level4L =
          addressRoadDetailModel.value.result![0].structure!.level4L;
      _user.address!.roadAddress!.level5 =
          addressRoadDetailModel.value.result![0].structure!.level5;
      _user.address!.roadAddress!.text =
          addressRoadDetailModel.value.result![0].text;

      // 주소찾기에서 클릭 시 지번 주소 userModel 업데이트
      _user.address!.parcelAddress!.level1 =
          addressParcelDetailModel.value.result![0].structure!.level1;
      _user.address!.parcelAddress!.level2 =
          addressParcelDetailModel.value.result![0].structure!.level2;
      _user.address!.parcelAddress!.level4A =
          addressParcelDetailModel.value.result![0].structure!.level4A;
      _user.address!.parcelAddress!.level4L =
          addressParcelDetailModel.value.result![0].structure!.level5;
      _user.address!.parcelAddress!.text =
          addressParcelDetailModel.value.result![0].text;

      // 주소찾기에서 클릭 시 GeoFirePoint userModel 업데이트
      _user.address!.geoFirePoint = GeoFirePoint(lat, log);
    });

    await UserRepository.setAddress(addPoint);
    addressTextEditngControllerInit(); // 텍스트 에디터 컨트롤러 초기화
    addressModelInit(); // 주소 목록 초기화
  }

  @override
  void onInit() {
    addressTextEditngController.addListener(() {
      addressTextEditngValue.value = addressTextEditngController.text;
    });
    super.onInit();
  }

  @override
  void dispose() {
    addressTextEditngController.dispose();
    super.dispose();
  }
}
