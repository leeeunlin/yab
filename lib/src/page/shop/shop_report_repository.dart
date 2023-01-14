import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yab_v2/src/page/shop/shop_detail_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class ShopReportRepository {
  static List<dynamic> lastVisible = [];
  // 코인 입출금 시 자동 DB 생성 및 해당 데이터 삽입
  static Future<void> shopBuyItem(
    String orderNo,
    String pinNo,
    String cuponImgUrl,
    String trId,
  ) async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_SHOP_REPORT)
        .doc(DateTime.now().toString())
        .set(ShopBuyReport()
            .toMap(orderNo, pinNo, cuponImgUrl, trId, DateTime.now()));
  }

  static Future<List<ShopBuyReport>> getShopBuyList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_SHOP_REPORT)
        .orderBy(FIELD_CREATEDDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일

    Map<String, dynamic> tmp = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {ShopBuyReport.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<ShopBuyReport> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.values
          .elementAt(i)
          .cast<ShopBuyReport>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }
}
