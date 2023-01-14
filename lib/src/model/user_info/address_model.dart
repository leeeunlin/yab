import 'package:yab_v2/src/utils/data_keys.dart';

class AddressModel {
  AddressModel({
    String? status,
    Page? page,
    Result? result,
  }) {
    _status = status;
    _page = page;
    _result = result;
  }

  AddressModel.fromJson(dynamic json) {
    _status = json["status"];
    _page =
        json[ADDRESS_PAGE] != null ? Page.fromJson(json[ADDRESS_PAGE]) : null;
    _result = json[ADDRESS_RESULT] != null
        ? Result.fromJson(json[ADDRESS_RESULT])
        : null;
  }
  String? _status;
  Page? _page;
  Result? _result;

  String? get status => _status;
  Page? get page => _page;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = _status;
    if (_page != null) {
      map[ADDRESS_PAGE] = _page?.toJson();
    }
    if (_result != null) {
      map[ADDRESS_RESULT] = _result?.toJson();
    }
    return map;
  }
}

/// crs : "EPSG:900913"
/// type : "address"
/// items : [{"id":"4113510900106240000","address":{"zipcode":"13487","category":"road","road":"경기도 성남시 분당구 판교로 242 (삼평동)","parcel":"삼평동 624","bldnm":"","bldnmdc":""},"point":{"x":"14148853.48172358","y":"4495338.919111188"}}]

class Result {
  Result({
    String? crs,
    String? type,
    List<Items>? items,
  }) {
    _crs = crs;
    _type = type;
    _items = items;
  }

  Result.fromJson(dynamic json) {
    _crs = json[ADDRESS_CRS];
    _type = json[ADDRESS_TYPE];
    if (json[ADDRESS_ITEMS] != null) {
      _items = [];
      json[ADDRESS_ITEMS].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  String? _crs;
  String? _type;
  List<Items>? _items;

  String? get crs => _crs;
  String? get type => _type;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_CRS] = _crs;
    map[ADDRESS_TYPE] = _type;
    if (_items != null) {
      map[ADDRESS_ITEMS] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "4113510900106240000"
/// address : {"zipcode":"13487","category":"road","road":"경기도 성남시 분당구 판교로 242 (삼평동)","parcel":"삼평동 624","bldnm":"","bldnmdc":""}
/// point : {"x":"14148853.48172358","y":"4495338.919111188"}

class Items {
  Items({
    String? id,
    String? title,
    Address? address,
    Point? point,
  }) {
    _id = id;
    _title = title;
    _address = address;
    _point = point;
  }

  Items.fromJson(dynamic json) {
    _id = json[ADDRESS_ID];
    _title = json['title'] ?? '';
    _address = json[ADDRESS_ADDRESS] != null
        ? Address.fromJson(json[ADDRESS_ADDRESS])
        : null;
    _point = json[ADDRESS_POINT] != null
        ? Point.fromJson(json[ADDRESS_POINT])
        : null;
  }
  String? _id;
  String? _title;
  Address? _address;
  Point? _point;

  String? get id => _id;
  String? get title => _title;
  Address? get address => _address;
  Point? get point => _point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_ID] = _id;
    map['title'] ?? '';
    if (_address != null) {
      map[ADDRESS_ADDRESS] = _address?.toJson();
    }
    if (_point != null) {
      map[ADDRESS_POINT] = _point?.toJson();
    }
    return map;
  }
}

/// x : "14148853.48172358"
/// y : "4495338.919111188"

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

/// zipcode : "13487"
/// category : "road"
/// road : "경기도 성남시 분당구 판교로 242 (삼평동)"
/// parcel : "삼평동 624"
/// bldnm : ""
/// bldnmdc : ""

class Address {
  Address({
    String? zipcode,
    String? category,
    String? road,
    String? parcel,
    String? bldnm,
    String? bldnmdc,
  }) {
    _zipcode = zipcode;
    _category = category;
    _road = road;
    _parcel = parcel;
    _bldnm = bldnm;
    _bldnmdc = bldnmdc;
  }

  Address.fromJson(dynamic json) {
    _zipcode = json[ADDRESS_ZIPCODE];
    _category = json[ADDRESS_CATEGORY];
    _road = json[ADDRESS_ROAD];
    _parcel = json[ADDRESS_PARCEL];
    _bldnm = json[ADDRESS_BLDNM];
    _bldnmdc = json[ADDRESS_BLDNMDC];
  }
  String? _zipcode;
  String? _category;
  String? _road;
  String? _parcel;
  String? _bldnm;
  String? _bldnmdc;

  String? get zipcode => _zipcode;
  String? get category => _category;
  String? get road => _road;
  String? get parcel => _parcel;
  String? get bldnm => _bldnm;
  String? get bldnmdc => _bldnmdc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_ZIPCODE] = _zipcode;
    map[ADDRESS_CATEGORY] = _category;
    map[ADDRESS_ROAD] = _road;
    map[ADDRESS_PARCEL] = _parcel;
    map[ADDRESS_BLDNM] = _bldnm;
    map[ADDRESS_BLDNMDC] = _bldnmdc;
    return map;
  }
}

/// total : "1"
/// current : "1"
/// size : "10"

class Page {
  Page({
    String? total,
    String? current,
    String? size,
  }) {
    _total = total;
    _current = current;
    _size = size;
  }

  Page.fromJson(dynamic json) {
    _total = json[ADDRESS_TOTAL];
    _current = json[ADDRESS_CURRENT];
    _size = json[ADDRESS_SIZE];
  }
  String? _total;
  String? _current;
  String? _size;

  String? get total => _total;
  String? get current => _current;
  String? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[ADDRESS_TOTAL] = _total;
    map[ADDRESS_CURRENT] = _current;
    map[ADDRESS_SIZE] = _size;
    return map;
  }
}
