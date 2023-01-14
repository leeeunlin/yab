// 보드컬렉션에 어느것을 선택했는지 확인하는 구조체
// 8지선다형을 만들 수 있음
// VS나 Mluti에서 Value값이 a, b, c, d ~ 형식으로 나오게 만듬
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SelectUserModel {
  List<String>? A;
  List<String>? B;
  List<String>? C;
  List<String>? D;
  List<String>? E;
  List<String>? F;
  List<String>? G;
  List<String>? H;

  SelectUserModel(
      {this.A, this.B, this.C, this.D, this.E, this.F, this.G, this.H});

  factory SelectUserModel.fromJson(Map<String, dynamic> json) {
    return SelectUserModel(
      A: json[FIELD_A] != null ? json[FIELD_A].cast<String>() : [],
      B: json[FIELD_B] != null ? json[FIELD_B].cast<String>() : [],
      C: json[FIELD_C] != null ? json[FIELD_C].cast<String>() : [],
      D: json[FIELD_D] != null ? json[FIELD_D].cast<String>() : [],
      E: json[FIELD_E] != null ? json[FIELD_E].cast<String>() : [],
      F: json[FIELD_F] != null ? json[FIELD_F].cast<String>() : [],
      G: json[FIELD_G] != null ? json[FIELD_G].cast<String>() : [],
      H: json[FIELD_H] != null ? json[FIELD_H].cast<String>() : [],
    );
  }

  factory SelectUserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return SelectUserModel.fromJson(snapshot.data()!);
  }

  Map<String, dynamic> toJson() {
    return {
      FIELD_A: A ?? [],
      FIELD_B: B ?? [],
      FIELD_C: C ?? [],
      FIELD_D: D ?? [],
      FIELD_E: E ?? [],
      FIELD_F: F ?? [],
      FIELD_G: G ?? [],
      FIELD_H: H ?? [],
    };
  }
}
