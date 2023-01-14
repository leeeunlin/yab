import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class SendBoardRepository {
  static List<dynamic> lastVisible = [];

  // 내가 보낸 게시물 가져오기
  static Future<List<DetectorModel>> getSendItemList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_BOARD)
        .where(FIELD_USERKEY, isEqualTo: userKey)
        .orderBy(FIELD_CREATEDDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
    Map<String, dynamic> tmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {DetectorModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<DetectorModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.values
          .elementAt(i)
          .cast<DetectorModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  // 내가 보낸 게시물의 게시물 아이디값을 이용하여 board Collection의 값을 가져옴
  static Future<DetectorModel> getSendItem(String detectorKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_BOARD).doc(detectorKey);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    DetectorModel detectorModel =
        DetectorModel.fromJson(documentSnapshot.data()!);

    return detectorModel;
  }

  static Future<List<DetectorModel>> limitgetSendItemList(int start) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (start == 0) {
      // 최초 시작일 경우에 시작점이 0이라 startAfter 함수 제거함
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_BOARD)
          .where(FIELD_USERKEY, isEqualTo: userKey)
          .orderBy(FIELD_CREATEDDATE, descending: true)
          .limit(10)
          .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
      if (querySnapshot.docs.isNotEmpty) {
        lastVisible.clear();
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_BOARD)
          .where(FIELD_USERKEY, isEqualTo: userKey)
          .orderBy(FIELD_CREATEDDATE, descending: true)
          .startAfterDocument(lastVisible[0]) // 두번째 로딩부터 시작점 지정
          .limit(10)
          .get();
      lastVisible.clear();
      if (querySnapshot.docs.length == 10) {
        // 페이지를 불러온 개수가 10개일 경우에만 해당 코드 작동
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    }
    Map<String, dynamic> tmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {DetectorModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<DetectorModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.values
          .elementAt(i)
          .cast<DetectorModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  // 내가 보낸 게시물
  // 내가 보낸 게시물이 환불 여부 확인 함수
  // User Collection -> [USERKEY] -> board_send_list SUB Collection -> [DETECOTRKEY] -> refund값
  static Future<bool?> getSendItemRefundCheck(String detectorKey) async {
    DocumentSnapshot<Map<String, dynamic>> userSubboardDocRef =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_SEND_BOASRD_LIST)
            .doc(detectorKey)
            .get(); // 해당 게시물 참조
    bool? viewResult = userSubboardDocRef.data()![FIELD_REFUND];

    return viewResult;
  }

  // 내가 보낸 게시물에서 환불이 안된 값 목록만 가져오기
  static Future<Map<String, dynamic>> getRefundCheckList() async {
    QuerySnapshot<Map<String, dynamic>> refundDocRef = await FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_SEND_BOASRD_LIST)
        .where(FIELD_REFUND, isEqualTo: false)
        .get();

    Map<String, dynamic> tmp = {};

    refundDocRef.docs.map((doc) => tmp[doc.id] = doc.data()).toList();

    return tmp;
  }

  static Future<Map<String, dynamic>> getRefundCheckData(
      String detectorKey) async {
    DocumentSnapshot<Map<String, dynamic>> refundDocSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_BOARD)
            .doc(detectorKey)
            .get();
    return refundDocSnapshot.data()!;
  }

  // User Collection -> [USERKEY] -> board_send_list SUB Collection -> [DETECOTRKEY] -> refund값
  static Future<void> setRefundCheck(String detectorKey) async {
    DocumentReference<Map<String, dynamic>> refundDocRef = FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_SEND_BOASRD_LIST)
        .doc(detectorKey);
    await refundDocRef.update({FIELD_REFUND: true}); // refund 값을 true로 변경
  }

  static Future<bool> getRefundCheck(String detectorKey) async {
    DocumentSnapshot<Map<String, dynamic>> refundDocRef =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_SEND_BOASRD_LIST)
            .doc(detectorKey)
            .get();
    bool refundCheck = refundDocRef.data()![FIELD_REFUND];
    return refundCheck;
  }
}
