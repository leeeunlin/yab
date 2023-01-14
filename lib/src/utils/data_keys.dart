// Users Collection
// Users Main Collection (모든 유저 정보)
// ignore_for_file: constant_identifier_names

const COL_USERS = 'users';
// const FIELD_PHONENUMBER = "phoneNumber"; // 전화번호 문자열 저장
// const FIELD_ADDRESS = "address"; // 주소 문자열 저장
const FIELD_EMAIL = "email"; // 이메일 주소 문자열 저장
const FIELD_GEOFIREPOINT = "geoFirePoint"; // GPS POINT 저장
const FIELD_COIN = "coin";
const FIELD_PREMIUMUSER = 'premiumUser';
const FIELD_FCMTOKEN = 'fcm_token'; // 푸시알림 토큰

// 캘린더의 출석체크 정보를 넣는 서브콜렉션
const SUB_COL_ATTENDANCE_CHECK_LIST = 'attendance_check_list';
const DOC_ATTENDANCE = 'attendance';
const FIELD_ATTENDANCE_TITLE = 'title';
const FIELD_ATTENDANCE_CHECK = 'check';

// users Collection => [USERKEY] -> board_receive_list SUB_Collection (내게 온 게시판 목록 정보를 넣을 서브콜렉션)
// 내게 온 게시판 목록 정보 => DocumentKey => board Collection Key / Field => 제목, 사진, 생성시간, 가격, 모드, 봤는지 안봤는지 플래그
const SUB_COL_RECEIVE_BOARD_LIST = 'board_receive_list';
const FIELD_POSTVIEW =
    'postview'; // 게시물을 봤는지 않봤는지 체크하는 플래그 (true : 봤다 코인지급상태 / false : 안봤다 코인미지급상태)

// users Collection => [USERKEY] -> board_send_list SUB_Collection (내가 보낸 게시판 정보를 넣을 서브콜렉션)
const SUB_COL_SEND_BOASRD_LIST = 'board_send_list';
const FIELD_REFUND = 'refund'; // 환불을 해줬는지 않해줬는지 체크하는 플래그

// users Collection => [USERKEY] -> coin_report SUB_Collection (코인 거래 내역)
const SUB_COL_COIN_REPORT = 'coin_report';

// issues: #56 상점 구매내역 DB등록
const SUB_COL_SHOP_REPORT = 'shop_report';
const FIELD_ORDERNO = 'orderNo';
const FIELD_PINNO = 'pinNo';
const FIELD_CUPONIMGURL = 'couponImgUrl';
const FIELD_TRID = 'trId';
// Board Collection
// Board Main Collection (모든 게시판 정보)
const COL_BOARD = 'board';
const FIELD_TITLE = "title"; // 게시글의 제목 문자열 저장
const FIELD_DETAIL = "detail"; // 게시글의 내용 문자열 리스트 저장
const FIELD_USERLIST = 'userList'; // 게시글의 필터를 통해 나온 유저키 목록 문자열 리스트 저장
const FIELD_USERKEY = 'userKey'; // 유저 키값을 저장 문자열
const FIELD_DETECTORKEY = 'detectorKey'; // 보드게시판의 키값을 저장 문자열
const FIELD_FCMTOKENLIST = 'fcmTokenList'; // FCMToken 목록
const FIELD_MODE =
    'mode'; // 글쓰기의 모드를 저장 문자열 (VS(2지선다), Multiple(4지선다이상), Promotion(일반 광고글))
const DATA_VS = 'vs'; // FIELD MODE의 값 문자열 / (2지선다)
const DATA_PROMOTION = 'promotion'; // FIELD MODE의 값 문자열 / (4지선다이상)
const DATA_MULTIPLE = 'multiple'; // FIELD MODE의 값 문자열 / (일반 광고글)

const FIELD_PRICE = 'price'; // 검색 가격을 설정하는 값 저장 num값
const FIELD_FULLPRICE = 'fullPrice'; // 차감 될 전체 금액
const FIELD_FIRSTPRICE = 'firstPrice'; // 1차 지급금액 (정보 사용료)
const FIELD_SECOUNDPRICE = 'secondPrice'; // 2차 지급금액 (2차 제공료)
const FIELD_FCMVIEWPRICE = 'fcmViewPrice'; // FCM 메시지에 보여줄 금액
const FIELD_REFUNDPRICE = 'refundPrice'; // 환불 금액

const FIELD_IMAGEDOWNLOADURLS =
    'imageDownloadUrls'; // 파이어베이스에 사진을 올렸을 경우 URL을 가져와 저장 문자열
const FIELD_COUNTER = 'counter'; // 검색 인원 수를 설정하는 값 저장 num값
const FIELD_EXPIREDDAY = 'expiredDay'; // 만료일 수 값 저장
const FIELD_CREATEDDATE = 'createdDate'; // 생성 시간을 저장
const FIELD_EXPIREDDATE = 'expiredDate'; // 만료 시간을 저장
const FIELD_RESERVATIONDATE = 'reservationDate'; // 예약 시간을 저장
const FIELD_RESERVATIONID = 'reservationId'; // Cloud Task API의 taskID 값
const FIELD_EXPIREDCHECK = 'expiredCheck'; // 만료 플래그

const RETURN_SUCCESS = "Success"; // 함수 호출이 성공 했을 때
const RETURN_FAILURE = "Failure"; // 함수 호출이 실패 했을 때

// 구조체에서 쓰이는 중복값
// 각 구조체 값 변경시 저장
const FIELD_UPDATETIME = 'updateTime';
// 최초 데이터 입력시 코인 지급 확인 값
const FIELD_GIVECHECKCOIN = 'giveCheckCoin';
const FIELD_GIVECHECKCOINVISION = 'visionGiveCheckCoin';

// 성별 구조체
const STRUCT_GENDER = 'genderStruct'; // 성별 구조체
const FIELD_GENDER = 'gender'; // 성별 값 저장

// 결혼 유무 구조체
const STRUCT_MARITALSTATUS = 'maritalstatusStruct'; // 결혼 유무 구조체
const FIELD_MARITALSTATUS = 'maritalstatus'; // 결혼 유무 값 저장

// 아이 유무 구조체
const STRUCT_CHILDREN = 'childrenStruct'; // 아이 유무 구조체
const FIELD_CHILDREN = 'children'; // 아이 유무 값 저장

// 국적 구조체
const STRUCT_NATIONALITY = 'nationalityStruct'; // 국적 값 구조체
const FIELD_NATIONALITY = 'nationality'; // 국적 값 구조체

// 생년월일 구조체
const STRUCT_BIRTH = 'birthStruct';
const FIELD_BIRTH = 'birth';

// issues: #46 학력정보 입력, 검색 생성 - ellee
const STRUCT_EDUCATION = 'educationStruct';
const FIELD_EDUCATION = 'education';

// 주소 구조체
const STRUCT_ADDRESS = 'addressStruct'; // 주소 전체 구조체
const STRUCT_ROAD = 'roadAddressStruct'; // 도로명 구조체 (주소 -> 도로명)
const STRUCT_PARCEL = 'parcelAddressStruct'; // 지번 구조체 (주소 -> 지번)
const FIELD_LEVEL1 = 'level1'; // 시 도 ex) 서울특별시
const FIELD_LEVEL2 = 'level2'; // 시 군 구 ex) 서초구
const FIELD_LEVEL4A = 'level4a'; // (도로)행정읍 면 동 명 (지번)지원안함 ex) 방배1동
const FIELD_LEVEL4L = 'level4l'; // (도로)도로명, (지번)법정읍 면 동 명 ex) 방배동
const FIELD_LEVEL5 = 'level5'; // (도로)길, (지번)번지 ex) 897-2
const FIELD_TEXT = 'text'; // 전체 주소

// 신체정보 구조체
const STRUCT_BODY = 'bodyStruct';
const STRUCT_BODYHEIGHT = 'bodyHeightStruct';
const STRUCT_BODYWEIGHT = 'bodyWeightSturct';
const STRUCT_BODYVISION = 'bodyVisionSturct';
const STRUCT_BODYBLOODTYPE = 'bodyBloodTypeSturct';
const STRUCT_BODYFOOTSIZE = 'bodyFootSizeSturct';
const FIELD_BODYHEIGHT = 'height';
const FIELD_BODYWEIGHT = 'weight';
const FIELD_BODYLEFTVISION = 'leftvision';
const FIELD_BODYRIGHTVISION = 'rightvision';
const FIELD_BODYBLOODTYPE = 'bloodtype';
const FIELD_BODYFOOTSIZE = 'footsize';
// issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
const FIELD_BODYHEIGHTSTART = 'bodyHeightStart';
const FIELD_BODYHEIGHTEND = 'bodyHeightEnd';
const FIELD_BODYWEIGHTSTART = 'bodyWeightStart';
const FIELD_BODYWEIGHTEND = 'bodyWeightEnd';
const FIELD_BODYRIGHTVISIONSTART = 'bodyRightVisionStart';
const FIELD_BODYRIGHTVISIONEND = 'bodyRightVisionEND';
const FIELD_BODYLEFTVISIONSTART = 'bodyLeftVisionStart';
const FIELD_BODYLEFTVISIONEND = 'bodyLeftVisionEND';
const FIELD_BODYFOOTSIZESTART = 'bodyFootSizeStart';
const FIELD_BODYFOOTSIZEEND = 'bodyFootSizeEnd';

// 건강정보 구조체
const STRUCT_HEALTH = 'healthStruct';
const STRUCT_HEALTHTABACCO = 'healthTabaccoStruct';
const STRUCT_HEALTHALCOHOL = 'healthAlcoholStruct';
const STRUCT_HEALTHEXERCISE = 'healthExerciseStruct';
const FIELD_HEALTHTABACCO = 'tabacco';
const FIELD_HEALTHALCOHOL = 'alcohol';
const FIELD_HEALTHEXERCISE = 'exercise';
const FIELD_HEALTHTABACCOSTART = 'healthTabaccoStart';
const FIELD_HEALTHTABACCOEND = 'healthTabaccoEnd';
const FIELD_HEALTHALCOHOLSTART = 'healthAlcoholStart';
const FIELD_HEALTHALCOHOLEND = 'healthAlcoholEnd';
const FIELD_HEALTHEXERCISESTART = 'healthExerciseStart';
const FIELD_HEALTHEXERCISEEND = 'healthExerciseEnd';

//성격정보 구조체
const STRUCT_PERSONALITY = 'personalityStruct';
const STRUCT_PERSONALITYMBTI = 'personalityMBTIStruct';
const STRUCT_PERSONALITYSTARSIGN = 'personalityStarSignStruct';
const FIELD_PERSONALITYMBTI = 'MBTI';
const FIELD_PERSONALITYSTARSIGN = 'StarSign';

// 경제정보 구조체
const STRUCT_ECONOMIC = 'economicStruct';
const STRUCT_ECONOMICPROPERTY = 'economicProperotyStruct';
const STRUCT_ECONOMICCAR = 'economicCarStruct';
const FIELD_ECONOMICPROPERTY = 'property';
const FIELD_ECONOMICCAR = 'economicCar';
const FIELD_ECONOMICCARFUEL = 'economicCarFuel';

// 선택 유저키 구조체
const STRUCT_SELECTUSERLIST = 'selectUserList';
const FIELD_A = 'a';
const FIELD_B = 'b';
const FIELD_C = 'c';
const FIELD_D = 'd';
const FIELD_E = 'e';
const FIELD_F = 'f';
const FIELD_G = 'g';
const FIELD_H = 'h';

// 선택 토큰키 구조체
const STRUCT_SELECTUSERTOKENLIST = 'selectUserTokenList';
const FIELD_TOKEN_A = 'a';
const FIELD_TOKEN_B = 'b';
const FIELD_TOKEN_C = 'c';
const FIELD_TOKEN_D = 'd';
const FIELD_TOKEN_E = 'e';
const FIELD_TOKEN_F = 'f';
const FIELD_TOKEN_G = 'g';
const FIELD_TOKEN_H = 'h';

// 데이터 값
const DATA_NONE = 'none';
const DATA_ATTENDANCE = 'attendanceCheck';
const DATA_ANONYMOUS = 'Anonymous';

// Selldy 수수료
// issues: #47 계산식 부동소수점 계산이 누적될 수록 손실되는 계산이 많아져 스트링으로 변환 후 decimal 함수를 사용함 - ellee
const SELLDY_PEE = '0.30'; // 소각 포인트
const FIRST_PEE = '0.10'; // 정보 이용료
const SECOND_PEE = '0.90'; // 정보를 봤을때 받을 이용료

// 1일 95%
// 2일 90%
// 3일 85%
// 4일 80%
// 5일 75%
// 6일 70%
// 7일 75%
const EXPIRE_PEE = '0.05'; // 하루당 5%씩

// Address
const ADDRESS_TOTAL = 'total';
const ADDRESS_CURRENT = 'current';
const ADDRESS_SIZE = 'size';
const ADDRESS_PAGE = 'page';
const ADDRESS_RESULT = 'result';
const ADDRESS_CRS = 'crs';
const ADDRESS_TYPE = 'type';
const ADDRESS_ITEMS = 'items';
const ADDRESS_ID = 'id';
const ADDRESS_ADDRESS = 'address';
const ADDRESS_POINT = 'point';
const ADDRESS_X = 'x';
const ADDRESS_Y = 'y';
const ADDRESS_CATEGORY = 'category';
const ADDRESS_ZIPCODE = 'zipcode';
const ADDRESS_ROAD = 'road';
const ADDRESS_PARCEL = 'parcel';
const ADDRESS_BLDNM = 'bldnm';
const ADDRESS_BLDNMDC = 'bldnmdc';
const ADDRESS_INPUT = 'input';
const ADDRESS_TEXT = 'text';
const ADDRESS_STRUCTURE = 'structure';
const ADDRESS_DETAIL = 'detail';
const ADDRESS_LEVEL0 = 'level0';
const ADDRESS_LEVEL1 = 'level1';
const ADDRESS_LEVEL2 = 'level2';
const ADDRESS_LEVEL3 = 'level3';
const ADDRESS_LEVEL4L = 'level4L';
const ADDRESS_LEVEL4LC = 'level4LC';
const ADDRESS_LEVEL4A = 'level4A';
const ADDRESS_LEVEL4AC = 'level4AC';
const ADDRESS_LEVEL5 = 'level5';

// issues: #56 상점 API 정보 모델링 정보
const SHOP_CODE = 'code';
const SHOP_MESSAGE = 'message';
const SHOP_RESULT = 'result';
const SHOP_GOODSDETAIL = 'goodsDetail';
const SHOP_GOODSIMGS = 'goodsImgS';
const SHOP_BRANDNAME = 'brandName';
const SHOP_GOODSNAME = 'goodsName';
const SHOP_GOODSCODE = 'goodsCode';
const SHOP_CONTENT = 'content';
const SHOP_REALPRICE = 'realPrice';
const SHOP_COUPON_GOODSCD = 'goodsCd';
const SHOP_COUPON_PINSTATUSCD = 'pinStatusCd';
const SHOP_COUPON_GOODSNM = 'goodsNm';
const SHOP_COUPON_BRANDNM = 'brandNm';
const SHOP_COUPON_MMSBRANDTHUMIMG = 'mmsBrandThumImg';
const SHOP_COUPON_VALIDPRDENDDT = 'validPrdEndDt';
const SHOP_COUPON_INFOLIST = 'couponInfoList';
