import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SelectUserTokenModel {
  List<String>? A;
  List<String>? B;
  List<String>? C;
  List<String>? D;
  List<String>? E;
  List<String>? F;
  List<String>? G;
  List<String>? H;

  SelectUserTokenModel(
      {this.A, this.B, this.C, this.D, this.E, this.F, this.G, this.H});

  factory SelectUserTokenModel.fromJson(Map<String, dynamic> json) {
    return SelectUserTokenModel(
      A: json[FIELD_TOKEN_A] != null ? json[FIELD_TOKEN_A].cast<String>() : [],
      B: json[FIELD_TOKEN_B] != null ? json[FIELD_TOKEN_B].cast<String>() : [],
      C: json[FIELD_TOKEN_C] != null ? json[FIELD_TOKEN_C].cast<String>() : [],
      D: json[FIELD_TOKEN_D] != null ? json[FIELD_TOKEN_D].cast<String>() : [],
      E: json[FIELD_TOKEN_E] != null ? json[FIELD_TOKEN_E].cast<String>() : [],
      F: json[FIELD_TOKEN_F] != null ? json[FIELD_TOKEN_F].cast<String>() : [],
      G: json[FIELD_TOKEN_G] != null ? json[FIELD_TOKEN_G].cast<String>() : [],
      H: json[FIELD_TOKEN_H] != null ? json[FIELD_TOKEN_H].cast<String>() : [],
    );
  }

  factory SelectUserTokenModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return SelectUserTokenModel.fromJson(snapshot.data()!);
  }

  Map<String, dynamic> toJson() {
    return {
      FIELD_TOKEN_A: A ?? [],
      FIELD_TOKEN_B: B ?? [],
      FIELD_TOKEN_C: C ?? [],
      FIELD_TOKEN_D: D ?? [],
      FIELD_TOKEN_E: E ?? [],
      FIELD_TOKEN_F: F ?? [],
      FIELD_TOKEN_G: G ?? [],
      FIELD_TOKEN_H: H ?? [],
    };
  }
}
