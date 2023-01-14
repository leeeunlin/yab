import 'package:dio/dio.dart';
import 'package:yab_v2/src/model/user_info/address_detail.model.dart';
import 'package:yab_v2/src/model/user_info/address_model.dart';
import 'package:yab_v2/src/utils/api_keys.dart';
import 'package:yab_v2/src/utils/logger.dart';

class AddressSearchRepository {
  static Future<AddressModel> searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
    };

    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.messsage);
    });
    // logger.i(response.data);
    AddressModel addressModel =
        AddressModel.fromJson(response.data["response"]);

    return addressModel;
  }

  static Future<AddressDetailModel> findParcelAddressByCoordinate(
      {required double log, required double lat}) async {
    final formData = {
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$log,$lat',
    };
    final response = await Dio()
        .get('http://api.vworld.kr/req/address', queryParameters: formData)
        .catchError((e) {
      logger.e(e.messsage);
    });
    AddressDetailModel addressModel =
        AddressDetailModel.fromJson(response.data["response"]);
    logger.i(response.data);

    return addressModel;
  }

  static Future<AddressDetailModel> findRoadAddressByCoordinate(
      {required double log, required double lat}) async {
    final formData = {
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'ROAD',
      'point': '$log,$lat',
    };
    final response = await Dio()
        .get('http://api.vworld.kr/req/address', queryParameters: formData)
        .catchError((e) {
      logger.e(e.messsage);
    });
    AddressDetailModel addressModel =
        AddressDetailModel.fromJson(response.data["response"]);
    logger.i(response.data);

    return addressModel;
  }

  static Future<AddressModel> detectorAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'service': 'search',
      'request': 'search',
      'type': 'district',
      'category': 'L4',
      'query': text
    };
    final response = await Dio()
        .get('http://api.vworld.kr/req/search?', queryParameters: formData)
        .catchError((e) {
      logger.e(e.messsage);
    });
    logger.i(response.data);

    AddressModel addressModel =
        AddressModel.fromJson(response.data["response"]);

    return addressModel;
  }
}
