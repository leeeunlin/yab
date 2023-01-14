"use strict";
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./key/serviceAccountKey.json");
const { firestore } = require("firebase-admin");
const { CloudTasksClient } = require("@google-cloud/tasks"); // eslint-disable-line no-unused-vars

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const colUsers = "users"; // 유저를 관리하는 Collection명
const colBoard = "board"; // 게시물을 관리하는 Collection명
const subcolReceiveBoard = "board_receive_list"; // SUB_COLLECTION 내게 온 게시물 이름
const subcolSendBoard = "board_send_list"; // SUB_COLLECTION 내가 보낸 게시물 이름
const subcolCoinReportBoard = "coin_report"; // SUB_COLLECTION 포인트 사용 로그 게시물 이름

// const SELLDY_PEE = 0.30; // 소각 포인트
// const FIRST_PEE = 0.10; // 정보 이용료
// const SECOND_PEE = 0.90; // 정보를 봤을때 받을 이용료

// const REPORT_BUY_SHOP = 'buy_shop'; // 상점 구매
// const REPORT_INFO = 'info'; // 정보 수정
const REPORT_SEND = "send"; // 광고 게시
// const REPORT_RECEIVE = 'receive'; // 게시물 확인
// const REPORT_CHARGE = 'charge'; // 포인트 충전
const REPORT_INFORMATION_USE = "information_use"; // 정보활용 지급
const REPORT_CANCEL_RESERVATION = "cancel_reservation"; // 광고 예약 취소
// const REPORT_REFUND = 'refund'; // 만료일 환불';
// const REPORT_SEND_QR_YAB = 'send_qr_yab'; // 출금
// const REPORT_RECEIVE_QR_YAB = 'Receive_qr_yab'; // 입금
const RETURN_SUCCESS = "Success"; // 함수 호출이 성공 했을 때
const RETURN_FAILURE = "Failure"; // 함수 호출이 실패 했을 때

// 유저의 코인을 더하고 빼는 함수
// 포인트의 변화가 생기면 SubCollection Report_Board에 사용내역이 저장 됨
// Parameter ('uid': 유저아이디 'K0jXoWzUzqeFQRk6vgCk10HMnGlP', 'price': 증가 차감 -1, 'mode': 사용 내용 'info')
// Return    (성공 : "Success", 실패 : "Failure")
exports.userPointAddSub = functions
  .region("asia-northeast3")
  .https.onCall(async (data, context) => {
    const db = admin.firestore(); // Firestore Database를 접근 하기 위한 instance

    const createdDate = firestore.Timestamp.now();
    const time = `${createdDate._seconds + 32400}${createdDate._nanoseconds / 1000000
      }`;
    const timeToInt = parseInt(time);
    const coinReportDocName = dateFormat(new Date(timeToInt));

    const userRef = db.collection(colUsers).doc(data["uid"]); // 해당 유저의 Reference
    const coinreportRef = db
      .collection(colUsers)
      .doc(data["uid"])
      .collection(subcolCoinReportBoard)
      .doc(coinReportDocName); // 사용 포인트 Reference

    try {
      const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수
      batch.update(userRef, {
        coin: admin.firestore.FieldValue.increment(data["price"]),
      }); // 클라이언트에서 받은 price값을 coin필드에 증가 또는 차감
      batch.set(coinreportRef, {
        createdDate: createdDate,
        mode: data["mode"],
        price: data["price"],
      }); // 클라이언트에서 받은 mode, price값을 해당 SubCollection에 작성
      await batch.commit(); // batch의 Query문을 한번에 실행
      return RETURN_SUCCESS; // 성공했을 때
    } catch (error) {
      functions.logger.error(error);
      return RETURN_FAILURE; // 실패했을 때
    }
  });

// Board Collection에 게시물이 생성되었을 때 받는 유저 Board에(board_receive_list) 해당 게시물을 작성하는 함수
exports.createReceiveBoard = functions
  .region("asia-northeast3")
  .runWith({
    memory: "512MB",
    timeoutSeconds: 60,
  })
  .firestore.document(`/${colBoard}/{boardId}`)
  .onCreate(async (snap, context) => {
    const db = admin.firestore(); // Firestore Database를 접근 하기 위한 instance
    const boardId = context.params.boardId; // Document명이 Key값이여서 가져옴

    const sendUserId = snap.data().userKey; // 게시물을 보낸 사람의 UserId 값을 가져옴
    const receiveUserIdList = snap.data().userList; // 게시물 받는 사람들의 UserIdList 값을 가져옴
    const fieldCounter = snap.data().counter; // 게시물을 보낸 인원 수
    const fieldCreatedDate = snap.data().createdDate;
    const fieldDetail = snap.data().detail;
    const fieldDetectorKey = snap.data().detectorKey;
    const fieldExpireDate = snap.data().expiredDate;
    const fieldReservationDate = snap.data().reservationDate; // 게시물이 예약전송이면 DateTime값으로 나오고 일반전송이면 null값으로 나옴
    const fieldReservationId = snap.data().reservationId; // 게시물이 예약전송이면 String값으로 아이디가 저장되고 일반전송이면 null값으로 나옴
    const fieldExpireDay = snap.data().expiredDay;
    const fieldImageDownloadUrls = snap.data().imageDownloadUrls;
    const fieldMode = snap.data().mode;
    const fieldPostview = false;
    const fieldRefund = false;
    const fieldPrice = snap.data().price; // 인당 가격
    const fieldFullPrice = snap.data().fullPrice; // 차감 될 전체 가격
    const fieldFirstPrice = snap.data().firstPrice; // 1차 지급금액 (정보 사용료)
    const fieldSecoundPrice = snap.data().secondPrice; // 2차 지급금액 (2차 제공료)
    const fieldFCMViewPrice = snap.data().fcmViewPrice; // FCM 메시지에 보여줄 금액
    const fieldrefundPrice = snap.data().refundPrice; // 인당 환불 금액

    const fieldSelectUserList = snap.data().selectUserList;
    const fieldTitle = snap.data().title;

    const time = `${fieldCreatedDate._seconds + 32400}${fieldCreatedDate._nanoseconds / 1000000
      }`;
    const timeToInt = parseInt(time);
    const coinReportDocName = dateFormat(new Date(timeToInt));

    const sendUserRef = db.collection(colUsers).doc(sendUserId); // 게시물을 보낸 유저의 Reference
    const sendUserSnap = await sendUserRef.get(); // 게시물을 보낸 유저의 Snapshot
    const sendUserCoin = sendUserSnap.data().coin; // 게시물을 보낸 유저의 보유 금액 값

    const sendSubcolCoinReportBoardRef = db
      .collection(colUsers)
      .doc(sendUserId)
      .collection(subcolCoinReportBoard)
      .doc(coinReportDocName);

    const subColSendBoardRef = db
      .collection(colUsers)
      .doc(sendUserId)
      .collection(subcolSendBoard)
      .doc(boardId); // 내가 보낸 게시물 Reference

    const boardRef = db.collection(colBoard).doc(boardId);

    // 보내는 사람의 coin_report에 해당값 저장
    // 보내는 사람의 coin 값을 보낸 유저들의 수만큼 차감
    const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수
    batch.set(sendSubcolCoinReportBoardRef, {
      createdDate: fieldCreatedDate,
      mode: REPORT_SEND,
      price: -fieldFullPrice,
    }); // 게시물을 보낸 유저의 총 포인트 가격을 coin_report에 저장
    batch.update(sendUserRef, { coin: sendUserCoin - Number(fieldFullPrice) }); // 게시물을 보낸 유저의 보낸 게시물의 총 포인트 가격을 빼주는 부분
    batch.set(subColSendBoardRef, {
      createdDate: fieldCreatedDate,
      expiredDate: fieldExpireDate,
      reservationDate: fieldReservationDate,
      reservationId: fieldReservationId,
      expiredDay: fieldExpireDay,
      imageDownloadUrls: fieldImageDownloadUrls,
      mode: fieldMode,
      price: fieldPrice,
      fullPrice: fieldFullPrice,
      refund: fieldRefund,
      title: fieldTitle,
    });
    await batch.commit(); // 담긴 batch를 한번에 commit을 하는 부분


    if (fieldReservationDate == null) {
      // fieldReservationDate null 이면 일반전송
      // Error: 4 DEADLINE_EXCEEDED: Deadline Exceeded at Object.exports.createStatusError - GCP 관련 에러
      // https://stackoverflow.com/questions/55067252/error-4-deadline-exceeded-deadline-exceeded-at-object-exports-createstatuserro
      // 배열의 보낸 유저의 ID값을 통해 순차적으로 전송
      const _dataSetList = [];
      receiveUserIdList.forEach(async (receiveUserId) => {
        const subColReceiveBoardRef = db
          .collection(colUsers)
          .doc(receiveUserId)
          .collection(subcolReceiveBoard)
          .doc(boardId); // 내게 온 게시물 Reference
        // 내게 온 게시물에 필드 값을 저장
        _dataSetList.push(
          subColReceiveBoardRef.set({
            counter: fieldCounter,
            createdDate: fieldCreatedDate,
            detail: fieldDetail,
            detectorKey: fieldDetectorKey,
            expiredDate: fieldExpireDate,
            expiredDay: fieldExpireDay,
            reservationDate: fieldReservationDate, // 일반 전송이므로 null이 들어옴
            reservationId: fieldReservationId, // 일반 전송이므로 null이 들어옴
            imageDownloadUrls: fieldImageDownloadUrls,
            mode: fieldMode,
            postview: fieldPostview,
            price: fieldPrice,
            fullPrice: fieldFullPrice,
            firstPrice: fieldFirstPrice,
            secondPrice: fieldSecoundPrice,
            fcmViewPrice: fieldFCMViewPrice,
            refundPrice: fieldrefundPrice,
            selectUserList: fieldSelectUserList,
            title: fieldTitle,
          })
        );
      });
      await Promise.all(_dataSetList);
    } else {
      // fieldReservationDate null 아니면 예약전송
      functions.logger.info("예약전송");
      functions.logger.info(`fieldReservationDate => ${fieldReservationDate._seconds}`);

      // Cloud Task 사용
      // const expirationAtSeconds = Date.now() / 1000;
      // const inSeconds = 120000;

      // functions.logger.info(
      //   `expirationAtSeconds => ${expirationAtSeconds} / ${
      //     expirationAtSeconds + inSeconds
      //   }`
      // );
      const project = JSON.parse(process.env.FIREBASE_CONFIG).projectId;
      const location = "asia-northeast3";
      const queue = "firestore-ttl";
      const tasksClient = new CloudTasksClient();
      const queuePath = tasksClient.queuePath(project, location, queue);

      const url = `https://${location}-${project}.cloudfunctions.net/firestoreTtlCallback`;

      const docPath = snap.ref.path.split("/")[1]; // board Collecetion의 저장된 boardId값을 payload에 저장
      const cloudPayload = { docPath };
      const task = {
        httpRequest: {
          httpMethod: "POST",
          url,
          body: Buffer.from(JSON.stringify(cloudPayload)).toString("base64"),
          headers: {
            "Content-Type": "application/json",
          },
        },
        scheduleTime: {
          seconds: fieldReservationDate._seconds,
        },
      };

      const [response] = await tasksClient.createTask({
        parent: queuePath,
        task,
      });

      // 보내는 사람의 coin_report에 해당값 저장
      // 보내는 사람의 coin 값을 보낸 유저들의 수만큼 차감
      const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수
      batch.set(sendSubcolCoinReportBoardRef, {
        createdDate: fieldCreatedDate,
        mode: REPORT_SEND,
        price: -fieldFullPrice,
      }); // 게시물을 보낸 유저의 총 포인트 가격을 coin_report에 저장
      batch.update(sendUserRef, { coin: sendUserCoin - Number(fieldFullPrice) }); // 게시물을 보낸 유저의 보낸 게시물의 총 포인트 가격을 빼주는 부분
      batch.set(subColSendBoardRef, {
        createdDate: fieldCreatedDate,
        expiredDate: fieldExpireDate,
        reservationDate: fieldReservationDate, // 예약 전송이므로 예약 Datetime값이 들어옴
        reservationId: response.name, // 예약 전송이므로 예약 ID값이 들어옴
        expiredDay: fieldExpireDay,
        imageDownloadUrls: fieldImageDownloadUrls,
        mode: fieldMode,
        price: fieldPrice,
        fullPrice: fieldFullPrice,
        refund: fieldRefund,
        title: fieldTitle,
      });
      batch.update(boardRef, { reservationId: response.name }); // board 게시물의 reservationId값을 업데이트 함
      await batch.commit(); // 담긴 batch를 한번에 commit을 하는 부분
      // Cloud Task 끝
    }
  });

// board_receive_list게시물이 작성이 되면 FCM메시지를 해당 유저에게 보내는 함수
exports.createReceiveBoardToSendFCM = functions
  .region("asia-northeast3")
  .runWith({
    memory: "512MB",
    timeoutSeconds: 60,
  })
  .firestore.document(`/${colUsers}/{userID}/${subcolReceiveBoard}/{boardID}`)
  .onCreate(async (snap, context) => {
    const db = admin.firestore(); // Firestore Database를 접근 하기 위한 instance
    const userID = context.params.userID; // SubCollection board_receive_list Document가 생성 될 때 USER_ID값을 가져옴
    const boardID = context.params.boardID; // SubCollection board_receive_list Document가 생성 될 때 BOARD_ID값을 가져옴

    // 테스트 FCM
    // const exampleToken =
    //   "fuJh4abtTMaZ4vwUPP-f-E:APA91bElFh_SqgO86B1PaB1mjzxO8neni1_EH3qYm81MXmDpLi_B2ktnZRUBMveduKFWBdZrP6SeN1t4pW2wOVTo6ezcERMp9ywkCA7tw7-qggml4YNe80hm516wj3UisZ0g5kvgYn5E";

    // const fieldPrice = snap.data().price; // 게시물의 가격
    const fieldCreatedDate = snap.data().createdDate; // 게시물의 만들어진 시간
    const fieldFCMViewPrice = snap.data().fcmViewPrice; // 게시물이 온 유저의 FCM 메시지에 적힐 포인트 값을 가져옴
    const fieldFirstPrice = snap.data().firstPrice; // 게시물이 온 유저의 정보이용료

    const receiveUsersRef = db.collection(colUsers).doc(userID); // 게시물이 온 유저의 Reference
    const receiveUsersSnap = await receiveUsersRef.get(); // 게시물이 온 유저의 Snapshot
    const receiveUserFCMToken = receiveUsersSnap.data().fcm_token; // 게시물이 온 유저의 Field fcm_token 값을 가져옴
    const receiveUserCoin = receiveUsersSnap.data().coin; // 게시물이 온 유저의 보유 금액 값을 가져옴

    const time = `${fieldCreatedDate._seconds + 32400}${fieldCreatedDate._nanoseconds / 1000000
      }`;
    const timeToInt = parseInt(time);
    const coinReportDocName = dateFormat(new Date(timeToInt));
    const receiveSubcolCoinReportBoardRef = db
      .collection(colUsers)
      .doc(userID)
      .collection(subcolCoinReportBoard)
      .doc(coinReportDocName);

    const payload = {
      notification: {
        title: "메세지 도착",
        body: `\u{1F389} 포인트를 가득 담은 소식이 도착했습니다.\n지금바로 확인해서 ${fieldFCMViewPrice} YAB을 받으세요`,
        sound: "yab.wav",
      },
    };

    const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수
    batch.set(receiveSubcolCoinReportBoardRef, {
      createdDate: fieldCreatedDate,
      mode: REPORT_INFORMATION_USE,
      price: fieldFirstPrice,
    }); // 게시물이 온 유저의 정보 이용료를 coin_report에 저장
    batch.update(receiveUsersRef, {
      coin: receiveUserCoin + Number(fieldFirstPrice),
    }); // 게시물이 온 유저에게 1차 금액 넣어주는 부분
    await batch.commit(); // 담긴 batch를 한번에 commit을 하는 부분

    try {
      // await admin.messaging().sendToDevice(exampleToken, payload); // FCM 메시지를 보내는 부분
      await admin.messaging().sendToDevice(receiveUserFCMToken, payload);
    } catch {
      functions.logger.error(
        `${boardID}게시물 ${userID}에게 FCM전송이 실패하였습니다.`
      );
    }
  });

// 예약 전송 함수
exports.firestoreTtlCallback = functions
  .region("asia-northeast3")
  .runWith({
    memory: "512MB",
    timeoutSeconds: 60,
  })
  .https.onRequest(async (req, res) => {
    const db = admin.firestore(); // Firestore Database를 접근 하기 위한 instance

    const payload = req.body; // board Collection의 게시물 ID값이 저장
    const boardId = payload["docPath"];

    const boardRef = db.collection(colBoard).doc(boardId); // 예약된 게시물의 참조값
    const boardSnap = await boardRef.get(); // 예약된 게시물의 Snapshot

    const userKey = boardSnap.data().userKey; // 보낸 사람의 키값
    const receiveUserIdList = boardSnap.data().userList; // 예약된 게시물 받는 사람들의 UserIdList 값을 가져옴

    const fieldCounter = boardSnap.data().counter; // 게시물을 보낸 인원 수
    const fieldDetail = boardSnap.data().detail;
    const fieldDetectorKey = boardSnap.data().detectorKey;
    const fieldExpireDate = boardSnap.data().expiredDate;
    const fieldExpireDay = boardSnap.data().expiredDay;
    const fieldImageDownloadUrls = boardSnap.data().imageDownloadUrls;
    const fieldMode = boardSnap.data().mode;
    const fieldPostview = false;
    const fieldPrice = boardSnap.data().price; // 인당 가격

    const fieldFullPrice = boardSnap.data().fullPrice; // 차감 될 전체 가격
    const fieldFirstPrice = boardSnap.data().firstPrice; // 1차 지급금액 (정보 사용료)
    const fieldSecoundPrice = boardSnap.data().secondPrice; // 2차 지급금액 (2차 제공료)
    const fieldFCMViewPrice = boardSnap.data().fcmViewPrice; // FCM 메시지에 보여줄 금액
    const fieldrefundPrice = boardSnap.data().refundPrice; // 인당 환불 금액
    const fieldSelectUserList = boardSnap.data().selectUserList;
    const fieldTitle = boardSnap.data().title;
    const fieldReservationDate = boardSnap.data().reservationDate; // 게시물이 예약전송이면 DateTime값으로 나오고 일반전송이면 null값으로 나옴
    const fieldReservationId = boardSnap.data().reservationId; // 게시물이 예약전송이면 String값으로 아이디가 저장되고 일반전송이면 null값으로 나옴

    const _dataSetList = [];
    receiveUserIdList.forEach(async (receiveUserId) => {
      const subColReceiveBoardRef = db
        .collection(colUsers)
        .doc(receiveUserId)
        .collection(subcolReceiveBoard)
        .doc(boardId); // 내게 온 게시물 Reference
      // 내게 온 게시물에 필드 값을 저장
      _dataSetList.push(
        subColReceiveBoardRef.set({
          counter: fieldCounter,
          createdDate: fieldReservationDate, // 예약전송이므로 fieldCreatedDate아니라 fieldReservationDate로 값을 넣어야함
          detail: fieldDetail,
          detectorKey: fieldDetectorKey,
          expiredDate: fieldExpireDate,
          expiredDay: fieldExpireDay,
          reservationDate: fieldReservationDate,
          reservationId: fieldReservationId,
          imageDownloadUrls: fieldImageDownloadUrls,
          mode: fieldMode,
          postview: fieldPostview,
          price: fieldPrice,
          fullPrice: fieldFullPrice,
          firstPrice: fieldFirstPrice,
          secondPrice: fieldSecoundPrice,
          fcmViewPrice: fieldFCMViewPrice,
          refundPrice: fieldrefundPrice,
          selectUserList: fieldSelectUserList,
          title: fieldTitle,
        })
      );
    });
    await Promise.all(_dataSetList);

    // const subColSendBoardRef = db
    //   .collection(colUsers)
    //   .doc(userKey)
    //   .collection(subcolSendBoard)
    //   .doc(boardId); // 내가 보낸 게시물 Reference

    // const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수
    // batch.update(subColSendBoardRef, {
    //   reservationId: "",
    // }); // 예약이 완료되면 ID값을 null 변경하여 일반게시물로 변경시킴.

    // 해당 태스크 삭제 시작
    const tasksClient = new CloudTasksClient();
    const project = JSON.parse(process.env.FIREBASE_CONFIG).projectId;
    const location = "asia-northeast3";
    const queue = "firestore-ttl";
    tasksClient.queuePath(project, location, queue);
    await tasksClient.deleteTask({ "name": fieldReservationId }); // 예약 task를 삭제
    // 해당 태스크 삭제 끝

    await boardRef.update({ reservationId: "" }); // 예약이 완료되면 ID값을 null 변경하여 일반게시물로 변경시킴.
    // const batch = db.batch(); // batch에 Query문을 담을려고 만든 변수  
    // batch.update(boardRef), {
    //   reservationId: "",
    // }; 
    // await batch.commit(); // 담긴 batch를 한번에 commit을 하는 부분
  });

// 예약 보내기 취소 함수

exports.reservationCancel = functions
  .region("asia-northeast3")
  .runWith({
    memory: "512MB",
    timeoutSeconds: 60,
  })
  .https.onCall(async (data, context) => {
    const db = admin.firestore(); // Firestore Database를 접근 하기 위한 instance
    const tasksClient = new CloudTasksClient();
    const project = JSON.parse(process.env.FIREBASE_CONFIG).projectId;
    const location = "asia-northeast3";
    const queue = "firestore-ttl";

    const taskId = data["taskId"]; // 앱에서 넘겨받는 taskID값을 저장합
    const userKey = data["userKey"]; // 앱에서 넘겨받는 userKey값을 저장함
    const boardId = data["boardId"]; // 앱에서 넘겨받는 boardId값을 저정함

    functions.logger.info(taskId);
    functions.logger.info(userKey);
    functions.logger.info(boardId);

    // 1. 넘겨받은 유저키값을 가지고 취소시 코인값을 더해야함 - 완료
    // 2. 넘겨받은 boardID값을 가지고 취소시 금액을 알아서 해당 유저에게 알려줌
    // 3. taskID를 가지고 task를 취소시킴 -> 완료
    // 4. 해당 게시물은 삭제해야함 -> 완료

    const boardRef = db.collection(colBoard).doc(boardId); // 예약된 게시물의 Reference
    const userRef = db.collection(colUsers).doc(userKey); // 유저의 Reference
    const subColSendBoardRef = db
      .collection(colUsers)
      .doc(userKey)
      .collection(subcolSendBoard)
      .doc(boardId); // 내가 보낸 게시물 Reference

    const createdDate = firestore.Timestamp.now();
    const time = `${createdDate._seconds + 32400}${createdDate._nanoseconds / 1000000
      }`;
    const timeToInt = parseInt(time);
    const coinReportDocName = dateFormat(new Date(timeToInt));
    const receiveSubcolCoinReportBoardRef = db
      .collection(colUsers)
      .doc(userKey)
      .collection(subcolCoinReportBoard)
      .doc(coinReportDocName);

    const boardSnap = await boardRef.get(); // 예약된 게시물의 Snapshot
    const fullPrice = boardSnap.data().fullPrice; // 게시물의 전체 가격

    try {
      await boardRef.delete(); // board col의 해당 게시물 삭제
      await subColSendBoardRef.delete(); // sendBoard col의 해당 게시물 삭제
      await userRef.update({ coin: admin.firestore.FieldValue.increment(fullPrice) }); // 광고 예약 취소 환불
      await receiveSubcolCoinReportBoardRef.set({
        createdDate: createdDate,
        mode: REPORT_CANCEL_RESERVATION,
        price: fullPrice,
      }); // 광고 예약 취소를 coin_report에 작성
      tasksClient.queuePath(project, location, queue);
      await tasksClient.deleteTask({ "name": taskId }); // 예약 task를 삭제
      return RETURN_SUCCESS;
    } catch (error) {
      functions.logger.error(error);
      return RETURN_FAILURE;
    }
  });

function dateFormat(date) {
  let month = date.getMonth() + 1;
  let day = date.getDate();
  let hour = date.getHours();
  let minute = date.getMinutes();
  let second = date.getSeconds();
  let millisecond = date.getMilliseconds();

  month = month >= 10 ? month : "0" + month;
  day = day >= 10 ? day : "0" + day;
  hour = hour >= 10 ? hour : "0" + hour;
  minute = minute >= 10 ? minute : "0" + minute;
  second = second >= 10 ? second : "0" + second;
  millisecond = millisecond > 10 ? millisecond : millisecond + "00000";
  millisecond = millisecond > 100 ? millisecond : millisecond + "0000";
  millisecond = millisecond > 1000 ? millisecond : millisecond + "000";

  return (
    date.getFullYear() +
    "-" +
    month +
    "-" +
    day +
    " " +
    hour +
    ":" +
    minute +
    ":" +
    second +
    "." +
    millisecond
  );
}
