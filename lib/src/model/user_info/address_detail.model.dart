import 'package:yab_v2/src/utils/data_keys.dart';

class AddressDetailModel {
  AddressDetailModel({
    Input? input,
    List<Result>? result,
  }) {
    _input = input;
    _result = result;
  }

  AddressDetailModel.fromJson(dynamic json) {
    _input = json[ADDRESS_INPUT] != null
        ? Input.fromJson(json[ADDRESS_INPUT])
        : null;
    if (json[ADDRESS_RESULT] != null) {
      _result = [];
      json[ADDRESS_RESULT].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  Input? _input;
  List<Result>? _result;

  Input? get input => _input;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_input != null) {
      map[ADDRESS_INPUT] = _input?.toJson();
    }
    if (_result != null) {
      map[ADDRESS_RESULT] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// zipcode : "04524"
/// type : "parcel"
/// text : "서울특별시 중구 태평로1가 31"
/// structure : {"level0":"대한민국","level1":"서울특별시","level2":"중구","level3":"","level4L":"태평로1가","level4LC":"1114010300","level4A":"명동","level4AC":"1114055000","level5":"31","detail":""}

class Result {
  Result({
    String? zipcode,
    String? type,
    String? text,
    Structure? structure,
  }) {
    _zipcode = zipcode;
    _type = type;
    _text = text;
    _structure = structure;
  }

  Result.fromJson(dynamic json) {
    _zipcode = json[ADDRESS_ZIPCODE];
    _type = json[ADDRESS_TYPE];
    _text = json[ADDRESS_TEXT];
    _structure = json[ADDRESS_STRUCTURE] != null
        ? Structure.fromJson(json[ADDRESS_STRUCTURE])
        : null;
  }
  String? _zipcode;
  String? _type;
  String? _text;
  Structure? _structure;

  String? get zipcode => _zipcode;
  String? get type => _type;
  String? get text => _text;
  Structure? get structure => _structure;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_ZIPCODE] = _zipcode;
    map[ADDRESS_TYPE] = _type;
    map[ADDRESS_TEXT] = _text;
    if (_structure != null) {
      map[ADDRESS_STRUCTURE] = _structure?.toJson();
    }
    return map;
  }
}

/// level0 : "대한민국"
/// level1 : "서울특별시"
/// level2 : "중구"
/// level3 : ""
/// level4L : "태평로1가"
/// level4LC : "1114010300"
/// level4A : "명동"
/// level4AC : "1114055000"
/// level5 : "31"
/// detail : ""

class Structure {
  Structure({
    String? level0,
    String? level1,
    String? level2,
    String? level3,
    String? level4L,
    String? level4LC,
    String? level4A,
    String? level4AC,
    String? level5,
    String? detail,
  }) {
    _level0 = level0;
    _level1 = level1;
    _level2 = level2;
    _level3 = level3;
    _level4L = level4L;
    _level4LC = level4LC;
    _level4A = level4A;
    _level4AC = level4AC;
    _level5 = level5;
    _detail = detail;
  }

  Structure.fromJson(dynamic json) {
    _level0 = json[ADDRESS_LEVEL0];
    _level1 = json[ADDRESS_LEVEL1];
    _level2 = json[ADDRESS_LEVEL2];
    _level3 = json[ADDRESS_LEVEL3];
    _level4L = json[ADDRESS_LEVEL4L];
    _level4LC = json[ADDRESS_LEVEL4LC];
    _level4A = json[ADDRESS_LEVEL4A];
    _level4AC = json[ADDRESS_LEVEL4AC];
    _level5 = json[ADDRESS_LEVEL5];
    _detail = json[ADDRESS_DETAIL];
  }
  String? _level0; // 국가  ex) 대한민국
  String? _level1; // 시 도 ex) 서울특별시
  String? _level2; // 시 군 구 ex) 서초구
  String? _level3; // (일반구)구 ex) 빈칸
  String? _level4L; // (도로)도로명, (지번)법정읍 면 동 명 ex) 방배동
  String? _level4LC; // 없음 지워진듯
  String? _level4A; // (도로)행정읍 면 동 명 (지번)지원안함 ex) 방배1동
  String? _level4AC; // 없음 지워진듯
  String? _level5; // (도로)길, (지번)번지 ex) 897-2
  String? _detail; // 상세주소 ex) 빈칸

  String? get level0 => _level0;
  String? get level1 => _level1;
  String? get level2 => _level2;
  String? get level3 => _level3;
  String? get level4L => _level4L;
  String? get level4LC => _level4LC;
  String? get level4A => _level4A;
  String? get level4AC => _level4AC;
  String? get level5 => _level5;
  String? get detail => _detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_LEVEL0] = _level0;
    map[ADDRESS_LEVEL1] = _level1;
    map[ADDRESS_LEVEL2] = _level2;
    map[ADDRESS_LEVEL3] = _level3;
    map[ADDRESS_LEVEL4L] = _level4L;
    map[ADDRESS_LEVEL4LC] = _level4LC;
    map[ADDRESS_LEVEL4A] = _level4A;
    map[ADDRESS_LEVEL4AC] = _level4AC;
    map[ADDRESS_LEVEL5] = _level5;
    map[ADDRESS_DETAIL] = _detail;
    return map;
  }
}

/// point : {"x":"126.978275264","y":"37.566642192"}
/// crs : "epsg:4326"
/// type : "both"

class Input {
  Input({
    Point? point,
    String? crs,
    String? type,
  }) {
    _point = point;
    _crs = crs;
    _type = type;
  }

  Input.fromJson(dynamic json) {
    _point = json[ADDRESS_POINT] != null
        ? Point.fromJson(json[ADDRESS_POINT])
        : null;
    _crs = json[ADDRESS_CRS];
    _type = json[ADDRESS_TYPE];
  }
  Point? _point;
  String? _crs;
  String? _type;

  Point? get point => _point;
  String? get crs => _crs;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_point != null) {
      map[ADDRESS_POINT] = _point?.toJson();
    }
    map[ADDRESS_CRS] = _crs;
    map[ADDRESS_TYPE] = _type;
    return map;
  }
}

/// x : "126.978275264"
/// y : "37.566642192"

class Point {
  Point({
    String? x,
    String? y,
  }) {
    _x = x;
    _y = y;
  }

  Point.fromJson(dynamic json) {
    _x = json[ADDRESS_X];
    _y = json[ADDRESS_Y];
  }
  String? _x;
  String? _y;

  String? get x => _x;
  String? get y => _y;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_X] = _x;
    map[ADDRESS_Y] = _y;
    return map;
  }
}
