import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yab_v2/src/model/point_report_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class PointReportRepository {
  static List<dynamic> lastVisible = [];
  // 코인 입출금 시 자동 DB 생성 및 해당 데이터 삽입
  static Future<void> createNewItem(
      String userKey, num point, String itemName) async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_COIN_REPORT)
        .doc(DateTime.now().toString())
        .set(PointReportModel().toMap(point, itemName, DateTime.now()));
  }

  static Future<List<PointReportModel>> getPointReportList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_COIN_REPORT)
        .orderBy(FIELD_CREATEDDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일

    Map<String, dynamic> tmp = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {PointReportModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<PointReportModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.values
          .elementAt(i)
          .cast<PointReportModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  static Future<List<PointReportModel>> getPointReportLimitList(
      int start) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (start == 0) {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_USERS)
          .doc(userKey)
          .collection(SUB_COL_COIN_REPORT)
          .orderBy(FIELD_CREATEDDATE, descending: true)
          .limit(10)
          .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
      if (querySnapshot.docs.isNotEmpty) {
        lastVisible.clear();
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_USERS)
          .doc(userKey)
          .collection(SUB_COL_COIN_REPORT)
          .orderBy(FIELD_CREATEDDATE, descending: true)
          .startAfterDocument(lastVisible[0]) // 두번째 로딩부터 시작점 지정
          .limit(10)
          .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
      lastVisible.clear();
      if (querySnapshot.docs.length == 10) {
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    }
    Map<String, dynamic> tmp = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {PointReportModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<PointReportModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.values
          .elementAt(i)
          .cast<PointReportModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }
}
