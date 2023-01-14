import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/detector_info/select_user_model.dart';
import 'package:yab_v2/src/model/detector_info/select_user_token_model.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class ReceiveBoardRepository {
  static List<dynamic> lastVisible = [];

  // 메인화면의 받은 소식 뱃지 부분 표시 함수
  static Future<int?> getViewCheck() async {
    int? viewCount;

    Query<Map<String, dynamic>> userBoardDocRef = FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_RECEIVE_BOARD_LIST)
        .where(FIELD_POSTVIEW, isEqualTo: false);

    await userBoardDocRef.get().then((value) async {
      viewCount = value.size;
    });
    return viewCount;
  }

  // 답변자의 토큰값을 해당 필드에 저장
  static Future<void> setAnswerTokenKey(
      String detectorKey, String selectFieldKey) async {
    DocumentReference<Map<String, dynamic>> boardDocRef = FirebaseFirestore
        .instance
        .collection(COL_BOARD)
        .doc(detectorKey); // 해당 게시물 참조

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await boardDocRef.get(); // 게시물의 내용을 가져옴

    String? fcmToken =
        UserController.to.userModel.value.fcmToken; // 해당 유저의 저장된 FCM토큰을 가져옴

    List<dynamic> getListTmpA =
        snapshot.data()![STRUCT_SELECTUSERTOKENLIST][FIELD_A];
    List<String> getListA = getListTmpA.cast<String>();

    List<dynamic> getListTmpB =
        snapshot.data()![STRUCT_SELECTUSERTOKENLIST][FIELD_B];
    List<String> getListB = getListTmpB.cast<String>();

    List<dynamic> getListTmpC =
        snapshot.data()![STRUCT_SELECTUSERTOKENLIST][FIELD_C];
    List<String> getListC = getListTmpC.cast<String>();

    List<dynamic> getListTmpD =
        snapshot.data()![STRUCT_SELECTUSERTOKENLIST][FIELD_D];
    List<String> getListD = getListTmpD.cast<String>();

    if (selectFieldKey == FIELD_A) {
      // A를 선택 했을 시
      if (getListB.contains(fcmToken)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(fcmToken);
      } else if (getListC.contains(fcmToken)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(fcmToken);
      } else if (getListD.contains(fcmToken)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(fcmToken);
      }

      if (!getListA.contains(fcmToken)) {
        // selectUserList_Struct -> A에 유저 키가 없으면 추가시킨다.
        getListA.add(fcmToken!); // selectUserList_Struct -> A에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERTOKENLIST: SelectUserTokenModel(
                A: getListA, B: getListB, C: getListC, D: getListD)
            .toJson()
      });
    } else if (selectFieldKey == FIELD_B) {
      // B를 선택 했을 시
      if (getListA.contains(fcmToken)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(fcmToken);
      } else if (getListC.contains(fcmToken)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(fcmToken);
      } else if (getListD.contains(fcmToken)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(fcmToken);
      }

      if (!getListB.contains(fcmToken)) {
        // selectUserList_Struct -> B에 유저 키가 없으면 추가시킨다.
        getListB.add(fcmToken!); // selectUserList_Struct -> B에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERTOKENLIST: SelectUserTokenModel(
                A: getListA, B: getListB, C: getListC, D: getListD)
            .toJson()
      });
    } else if (selectFieldKey == FIELD_C) {
      // C를 선택 했을 시
      if (getListA.contains(fcmToken)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(fcmToken);
      } else if (getListB.contains(fcmToken)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(fcmToken);
      } else if (getListD.contains(fcmToken)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(fcmToken);
      }

      if (!getListC.contains(fcmToken)) {
        // selectUserList_Struct -> C에 유저 키가 없으면 추가시킨다.
        getListC.add(fcmToken!); // selectUserList_Struct -> C에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERTOKENLIST: SelectUserTokenModel(
                A: getListA, B: getListB, C: getListC, D: getListD)
            .toJson()
      });
    } else if (selectFieldKey == FIELD_D) {
      // D를 선택 했을 시
      if (getListA.contains(fcmToken)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(fcmToken);
      } else if (getListB.contains(fcmToken)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(fcmToken);
      } else if (getListC.contains(fcmToken)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(fcmToken);
      }

      if (!getListD.contains(fcmToken)) {
        // selectUserList_Struct -> D에 유저 키가 없으면 추가시킨다.
        getListD.add(fcmToken!); // selectUserList_Struct -> D에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERTOKENLIST: SelectUserTokenModel(
                A: getListA, B: getListB, C: getListC, D: getListD)
            .toJson()
      });
    }
  }

  // 답변자의 키를 해당 필드에 저장
  static Future<void> setAnswerKey(
      String detectorKey, String selectFieldKey) async {
    DocumentReference<Map<String, dynamic>> boardDocRef = FirebaseFirestore
        .instance
        .collection(COL_BOARD)
        .doc(detectorKey); // 해당 게시물 참조

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await boardDocRef.get(); // 게시물의 내용을 가져옴

    List<dynamic> getListTmpA =
        snapshot.data()![STRUCT_SELECTUSERLIST][FIELD_A];
    List<String> getListA = getListTmpA.cast<String>();

    List<dynamic> getListTmpB =
        snapshot.data()![STRUCT_SELECTUSERLIST][FIELD_B];
    List<String> getListB = getListTmpB.cast<String>();

    List<dynamic> getListTmpC =
        snapshot.data()![STRUCT_SELECTUSERLIST][FIELD_C];
    List<String> getListC = getListTmpC.cast<String>();

    List<dynamic> getListTmpD =
        snapshot.data()![STRUCT_SELECTUSERLIST][FIELD_D];
    List<String> getListD = getListTmpD.cast<String>();

    if (selectFieldKey == FIELD_A) {
      // A를 선택 했을 시
      if (getListB.contains(userKey)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(userKey);
      } else if (getListC.contains(userKey)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(userKey);
      } else if (getListD.contains(userKey)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(userKey);
      }

      if (!getListA.contains(userKey)) {
        // selectUserList_Struct -> A에 유저 키가 없으면 추가시킨다.
        getListA.add(userKey); // selectUserList_Struct -> A에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERLIST:
            SelectUserModel(A: getListA, B: getListB, C: getListC, D: getListD)
                .toJson()
      });
    } else if (selectFieldKey == FIELD_B) {
      // B를 선택 했을 시
      if (getListA.contains(userKey)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(userKey);
      } else if (getListC.contains(userKey)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(userKey);
      } else if (getListD.contains(userKey)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(userKey);
      }

      if (!getListB.contains(userKey)) {
        // selectUserList_Struct -> B에 유저 키가 없으면 추가시킨다.
        getListB.add(userKey); // selectUserList_Struct -> B에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERLIST:
            SelectUserModel(A: getListA, B: getListB, C: getListC, D: getListD)
                .toJson()
      });
    } else if (selectFieldKey == FIELD_C) {
      // C를 선택 했을 시
      if (getListA.contains(userKey)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(userKey);
      } else if (getListB.contains(userKey)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(userKey);
      } else if (getListD.contains(userKey)) {
        // selectUserList_Struct -> D에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListD.remove(userKey);
      }

      if (!getListC.contains(userKey)) {
        // selectUserList_Struct -> C에 유저 키가 없으면 추가시킨다.
        getListC.add(userKey); // selectUserList_Struct -> C에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERLIST:
            SelectUserModel(A: getListA, B: getListB, C: getListC, D: getListD)
                .toJson()
      });
    } else if (selectFieldKey == FIELD_D) {
      // D를 선택 했을 시
      if (getListA.contains(userKey)) {
        // selectUserList_Struct -> A에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListA.remove(userKey);
      } else if (getListB.contains(userKey)) {
        // selectUserList_Struct -> B에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListB.remove(userKey);
      } else if (getListC.contains(userKey)) {
        // selectUserList_Struct -> C에 유저 키가 있는지 확인 후 있으면 삭제를 시킨다
        getListC.remove(userKey);
      }

      if (!getListD.contains(userKey)) {
        // selectUserList_Struct -> D에 유저 키가 없으면 추가시킨다.
        getListD.add(userKey); // selectUserList_Struct -> D에 유저 키를 추가 시킨다.
      }

      // A와 B를 동시에 업데이트 시킨다.
      // 추후 논의 후에 선택 후 변경이 불가하게 만들어야 할수 있다. 그때는 코드 수정이 필요하다.
      await boardDocRef.update({
        STRUCT_SELECTUSERLIST:
            SelectUserModel(A: getListA, B: getListB, C: getListC, D: getListD)
                .toJson()
      });
    }
  }

  // 답변한 게시글을 다시 선택하였을때 선택한 버튼을 표시한다.
  static Future<int> getSelectItem(detectorKey) async {
    int selectItem = 0;
    List<String> fieldList = [FIELD_A, FIELD_B, FIELD_C, FIELD_D]; //버튼 리스트

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_BOARD)
        .doc(detectorKey)
        .get(); // 해당 게시물 참조

    for (String i in fieldList) {
      // 버튼 리스트 순서별로 userkey값을 스캔하여 Item 수치를 증가시킨다

      List<dynamic> getListTmpA = snapshot.data()![STRUCT_SELECTUSERLIST][i];
      var findSelect = getListTmpA.where((userKey) => true);
      // FIELD_A에 유저 키값이 없다면 B > C > D 순으로 스캔하며 찾을경우 탈출
      if (findSelect.isEmpty == true) {
        selectItem++;
      } else {
        break;
      }
    }
    return selectItem;
  }

  // 내게 온 게시물의 목록을 봤는지 안봤는지 체크하는 함수
  // 내게 온 게시물의 목록에서 게시물을 코인이 지급됬는지 안됬는지 표시하기 위한 함수
  // User Collection -> [USERKEY] -> board_receive_list SUB Collection -> [DETECOTRKEY] -> postview값
  static Future<bool> getReceiveItemViewCheck(String detectorKey) async {
    DocumentSnapshot<Map<String, dynamic>> userSubboardDocRef =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .doc(detectorKey)
            .get(); // 해당 게시물 참조
    bool viewResult = userSubboardDocRef.data()![FIELD_POSTVIEW];

    return viewResult;
  }

  static Future<List<DetectorModel>> getReceiveItemAllViewCheck() async {
    QuerySnapshot<Map<String, dynamic>> queryFinalSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .where(FIELD_POSTVIEW, isEqualTo: false)
            .get();

    Map<String, dynamic> detectortmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in queryFinalSnapshot.docs) {
      detectortmp[doc.id] = {DetectorModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<DetectorModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < detectortmp.length; i++) {
      items.add(detectortmp.values
          .elementAt(i)
          .cast<DetectorModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  // User Collection -> [USERKEY] -> board_receive_list SUB Collection -> [DETECOTRKEY] -> postview값
  // postview값을 변경하는 함수
  static Future<void> setReceiveItemViewCheck(String detectorKey) async {
    DocumentReference<Map<String, dynamic>> userSubboardDocRef =
        FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .doc(detectorKey); // 해당 게시물 참조
    await userSubboardDocRef
        .update({FIELD_POSTVIEW: true}); // postview 값 true로 변경 (O)
  }

  // 내게 온 게시물 가져오기
  // User Collection -> [USERKEY] -> board_receive_list SUB Collection -> [DETECOTRKEY]
  // Field => => 제목, 사진, 생성시간, 가격, 모드, 봤는지 안봤는지 플래그
  // Field값 생성
  static Future<List<DetectorModel>> getReceiveItemList() async {
    // issues: #35 내게 온 게시글 퍼포먼스 향상 - ellee
    // 내게 온 게시글 전체 불러오기
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_RECEIVE_BOARD_LIST)
        .orderBy(FIELD_CREATEDDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
    // 1차 전체 리스트를 가져와 tmp에 넣는다
    Map<String, dynamic> tmp = {};
    querySnapshot.docs.map((doc) => tmp[doc.id] = doc.data()).toList();
// issues: #35 내게 온 게시글 퍼포먼스 향상 - ellee
// 내게 온 게시글 중 DB에 만료일자가 있는 DB만 불러옴
    QuerySnapshot<Map<String, dynamic>> queryExpiredSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .where(FIELD_DETECTORKEY, whereNotIn: [
      ''
    ]).get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
    // 만료일이 있는 리스트를 가져와 expiredtmp에 넣는다
    Map<String, dynamic> expiredtmp = {};
    queryExpiredSnapshot.docs
        .map((doc) => expiredtmp[doc.id] = doc.data())
        .toList();

    if (tmp.length != expiredtmp.length) {
      // 기존 DB에 만료일자가 없는 경우 추가하는 함수
      if (expiredtmp.isNotEmpty) {
        for (String detectorkey in expiredtmp.keys) {
          tmp.remove(detectorkey);
        }
      }
      if (tmp.isNotEmpty) {
        for (String detectorKey in tmp.keys) {
          // issues: #35 내게 온 게시글 퍼포먼스 향상 - ellee
          // 정제된 리스트에서 board의 만료 날짜 가져오기
          DocumentReference<Map<String, dynamic>> searchDocumentReference =
              FirebaseFirestore.instance.collection(COL_BOARD).doc(detectorKey);
          final DocumentSnapshot<Map<String, dynamic>> searchDocumentSnapshot =
              await searchDocumentReference.get();
          DetectorModel detectorModel =
              DetectorModel.fromSnapshot(searchDocumentSnapshot);
          // issues: #35 내게 온 게시글 퍼포먼스 향상 - ellee
          // 만료일 필드 , detector key 삽입
          await FirebaseFirestore.instance
              .collection(COL_USERS)
              .doc(userKey)
              .collection(SUB_COL_RECEIVE_BOARD_LIST)
              .doc(detectorKey)
              .set({
            FIELD_EXPIREDDATE: detectorModel.expiredDate,
            FIELD_EXPIREDDAY: detectorModel.expiredDay,
            FIELD_DETECTORKEY: detectorModel.detectorKey,
            FIELD_DETAIL: detectorModel.detail,
            FIELD_COUNTER: detectorModel.counter,
            STRUCT_SELECTUSERLIST: detectorModel.selectUserModel!.toJson(),
          }, SetOptions(merge: true));
        }
      }
    }
    // 만료일이 도래되지 않은 게시글의 답변자 수 업데이트 함수
    QuerySnapshot<Map<String, dynamic>> selectUserSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .where(FIELD_EXPIREDDATE, isGreaterThan: DateTime.now())
            .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일
    // 1차 전체 리스트를 가져와 tmp에 넣는다
    Map<String, dynamic> selectUsertmp = {};
    selectUserSnapshot.docs
        .map((doc) => selectUsertmp[doc.id] = doc.data())
        .toList();

    for (String detectorKey in selectUsertmp.keys) {
      DocumentReference<Map<String, dynamic>> searchDocumentReference =
          FirebaseFirestore.instance.collection(COL_BOARD).doc(detectorKey);
      final DocumentSnapshot<Map<String, dynamic>> searchDocumentSnapshot =
          await searchDocumentReference.get();
      DetectorModel detectorModel =
          DetectorModel.fromSnapshot(searchDocumentSnapshot);
      // issues: #35 내게 온 게시글 퍼포먼스 향상 - ellee
      // 만료일 필드 , detector key 삽입
      await FirebaseFirestore.instance
          .collection(COL_USERS)
          .doc(userKey)
          .collection(SUB_COL_RECEIVE_BOARD_LIST)
          .doc(detectorKey)
          .set({
        STRUCT_SELECTUSERLIST: detectorModel.selectUserModel!.toJson(),
      }, SetOptions(merge: true));
    }

    // 전체 게시글 한번에 가져오기
    QuerySnapshot<Map<String, dynamic>> queryFinalSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(SUB_COL_RECEIVE_BOARD_LIST)
            .orderBy(FIELD_CREATEDDATE, descending: true)
            .get();

    Map<String, dynamic> detectortmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in queryFinalSnapshot.docs) {
      detectortmp[doc.id] = {DetectorModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<DetectorModel> items = []; // 게시물을 List형식으로 가져오기 위한 변수
    for (int i = 0; i < detectortmp.length; i++) {
      items.add(detectortmp.values
          .elementAt(i)
          .cast<DetectorModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  static Future<List<DetectorModel>> limitgetReceiveItemList(int start) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (start == 0) {
      // 최초 시작일 경우에 시작점이 0이라 startAfter 함수 제거함
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_USERS)
          .doc(userKey)
          .collection(SUB_COL_RECEIVE_BOARD_LIST)
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
          .collection(SUB_COL_RECEIVE_BOARD_LIST)
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
}
