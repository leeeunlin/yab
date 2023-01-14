// 기본정보에 아이 유/무 구조체 정보
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Children {
  String? children; // 아이 정보
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Children({this.children, this.updateTime, this.giveCheckCoin});

  factory Children.init() {
    var time = DateTime.now();
    return Children(
        children: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory Children.fromJson(Map<String, dynamic> json) => Children(
        children:
            json[FIELD_CHILDREN] == null ? '' : json[FIELD_CHILDREN] as String,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_CHILDREN: children,
      FIELD_UPDATETIME: updateTime,
      FIELD_GIVECHECKCOIN: giveCheckCoin
    };
  }
}

const Map<String, String> childrenMapEngToKor = {
  'none': '자녀유무를 선택해주세요',
  'existence': '있음',
  'nonexistence': '없음'
};

const Map<String, String> childrenMapKorToEng = {
  '자녀유무를 선택해주세요': 'none',
  '있음': 'existence',
  '없음': 'nonexistence'
};
