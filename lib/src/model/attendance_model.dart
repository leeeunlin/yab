import 'package:yab_v2/src/utils/data_keys.dart';

class AttendanceModel {
  String? title; // 출석체크용 제목
  bool? complete; // 출석 여부

  AttendanceModel({this.title, this.complete});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      title: json[FIELD_ATTENDANCE_TITLE] == null
          ? ''
          : json[FIELD_ATTENDANCE_TITLE] as String,
      complete: json[FIELD_ATTENDANCE_CHECK] == null
          ? false
          : json[FIELD_ATTENDANCE_CHECK] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_ATTENDANCE_TITLE: DATA_ATTENDANCE,
      FIELD_ATTENDANCE_CHECK: false,
    };
  }

  // @override
  // String? toString() => title;
}
