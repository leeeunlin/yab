import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';
import 'package:yab_v2/src/binding/init_bindings.dart';
import 'package:yab_v2/src/controller/notification_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/user_economicinfo/user_economic.dart';
import 'package:yab_v2/src/model/user_healthinfo/user_health.dart';
import 'package:yab_v2/src/model/user_info/education.dart';
import 'package:yab_v2/src/model/user_model.dart';
import 'package:yab_v2/src/model/user_personalityinfo/user_personality.dart';
import 'package:yab_v2/src/repository/user_repository.dart';
import 'package:yab_v2/src/model/user_bodyinfo/user_body.dart';
import 'package:yab_v2/src/model/user_info/address.dart';
import 'package:yab_v2/src/model/user_info/birth.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/gender.dart' as mygender;
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/utils/logger.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<UserModel> userModel = UserModel().obs;
  Rx<String> errorCode = ''.obs;

  // 서버에 유저의 uid값이 있는지 확인하는 단계
  Future<UserModel?> loginUser(String uid) async {
    UserModel? userData = await UserRepository.loginUserByUid(
        uid); // USERS COLLECTION 안에 해당 uid 값이 있는지 확인 하는 함수 있으면 UserModel을 가져옴
    if (userData != null) {
      // 데이터가 NULL이 아니면 유저가 있는것임.
      userModel(userData); // user에 값을 넣음
      InitBinding.additionalBinding(); // 로그인이 완료하고 난후 컨트롤러 메모리에 올리기
      UserRepository.updateFCMToken(
          uid); // FCM토큰을 가져와 해당 유저의 Document에 fcm_token Field에 값을 넣는 함수 (로그인 시 상시로 갱신함)
    }
    return userData;
  }

  // 로그인 하려는 유저가 신규유저인지 기존유저인지 확인하는 함수
  // 신규유저이면 데이터베이스 생성을 하여 저장을 함
  Future<void> submitSignup(UserModel signupUser) async {
    bool result =
        await UserRepository.signup(signupUser); // 유저가 있는지 없는지 확인하고 변수 저장
    if (result) {
      await loginUser(signupUser.userKey!);
    }
  }

  // 신규유저 모델 생성 부분 통합하여 코드
  Future<UserModel> createUserModel(UserCredential userAuth) async {
    String? token = await NotificationController.to.getToken();
    return UserModel(
      userKey: userAuth.user!.uid,
      email: userAuth.user!.email,
      coin: 0,
      createdDate: DateTime.now(),
      gender: mygender.Gender.init(),
      maritalStatus: MaritalStatus.init(),
      children: Children.init(),
      nationality: Nationality.init(),
      birth: Birth.init(),
      address: Address.init(),
      body: Body.init(),
      // issues: #45 건강정보 입력, 검색 생성 - ellee
      health: Health.init(),
      // issues: #46 학력정보 입력, 검색 생성 - ellee
      education: Education.init(),
      // issues: #51 성격정보 입력, 검색 생성 - ellee
      personality: Personality.init(),
      // issues: #55 경제정보 모델 생성 - ellee
      economic: Economic.init(),
      fcmToken: token,
    );
  }

  // 익명 로그인
  Future<UserCredential> siginInWithAnonymous() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  // 익명 로그인 버튼
  void loginButtonAnonymous() async {
    UserCredential userAuth = await siginInWithAnonymous();
    UserModel newUserModel = await createUserModel(userAuth);
    await AuthController.to.submitSignup(newUserModel);
  }

  // 구글 인증 함수
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // 익명 로그인에서 구글 로그인으로 변경
  Future<OAuthCredential?> anonymousToGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(
              credential); // Authentication Anonymous -> Google로 변경
      await UserController.to.updateEmailAddress(
          userCredential!.user!.email!); // 서버 & 컨트롤러 유저모델에 이메일 주소를 변경
      await FirebaseAuth.instance.currentUser!.reload();
      errorCode.value = "Success";
      // return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          logger.e("The provider has already been linked to the user.");
          errorCode.value = "provider-already-linked";
          break;
        case "invalid-credential":
          logger.e("The provider's credential is not valid.");
          errorCode.value = "invalid-credential";
          break;
        case "credential-already-in-use":
          logger
              .e("The account corresponding to the credential already exists, "
                  "or is already linked to a Firebase User.");
          errorCode.value = "credential-already-in-use";
          break;
        // See the API reference for the full list of error codes.
        default:
          logger.e("Unknown error.");
          errorCode.value = "Unknown";
          break;
      }
    }
    return credential;
  }

  // 익명 로그인에서 구글 로그인으로 변경하면서 이미 있는 계정 로그인 변경
  Future<void> alredyGoogleLogin(OAuthCredential? credential) async {
    await UserController.to.deleteUser(); // 게스트 계정 삭제
    await FirebaseAuth.instance.signOut(); // 게스트 계정 파이어베이스 로그아웃
    await GoogleSignIn().signOut(); // 게스트 계정 구글 로그아웃

    UserCredential userAuth =
        await FirebaseAuth.instance.signInWithCredential(credential!);
    UserModel? _userModel = await loginUser(userAuth.user!.uid);
    await AuthController.to.submitSignup(_userModel!);

    // await Get.offAll(const App());
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // 최초 구글 로그인 버튼
  Future<void> loginButtonGoogle() async {
    UserCredential userAuth = await signInWithGoogle();
    UserModel newUserModel = await createUserModel(userAuth);
    await AuthController.to.submitSignup(newUserModel);
  }

  // 익명 로그인에서 애플 로그인으로 변경
  Future<OAuthCredential?> anonymousToApple() async {
    // 13버전 이상이거나 Android일 경우 (true)
    bool isAvailable = await SignInWithApple.isAvailable();
    final OAuthCredential credential;

    if (isAvailable) {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "com.selldy.yab-flutter-firebase-sns-login-web",
          redirectUri: Uri.parse(
              "https://deeply-hazel-quill.glitch.me/callbacks/sign_in_with_apple"),
        ),
      );

      credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
    } else {
      final clientState = const Uuid().v4();
      final url = Uri.https('appleid.apple.com', '/auth/authorize', {
        'response_type': 'code id_token',
        'client_id': "com.selldy.yab-flutter-firebase-sns-login-web",
        'response_mode': 'form_post',
        'redirect_uri':
            'https://deeply-hazel-quill.glitch.me/callbacks/apple/sign_in_with_apple',
        'scope': 'email name',
        'state': clientState,
      });

      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: "applink");

      final body = Uri.parse(result).queryParameters;
      credential = OAuthProvider("apple.com").credential(
        idToken: body['id_token'],
        accessToken: body['code'],
      );
    }
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(
              credential); // Authentication Anonymous -> Apple로 변경
      await UserController.to.updateEmailAddress(
          userCredential!.user!.email!); // 서버 & 컨트롤러 유저모델에 이메일 주소를 변경
      await FirebaseAuth.instance.currentUser!.reload();
      errorCode.value = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          logger.e("The provider has already been linked to the user.");
          errorCode.value = "provider-already-linked";
          break;
        case "invalid-credential":
          logger.e("The provider's credential is not valid.");
          errorCode.value = "invalid-credential";
          break;
        case "credential-already-in-use":
          logger
              .e("The account corresponding to the credential already exists, "
                  "or is already linked to a Firebase User.");
          errorCode.value = "credential-already-in-use";
          break;
        // See the API reference for the full list of error codes.
        default:
          logger.e("Unknown error.");
          errorCode.value = "Unknown";
          break;
      }
    }
    return credential;
  }

  // 익명 로그인에서 애플 로그인으로 변경하면서 이미 있는 계정 로그인 변경
  // 익명 -> 애플 로그인 할때 2번 인증을 해야 함 (추후 수정)
  Future<void> alredyAppleLogin(OAuthCredential? credential) async {
    await UserController.to.deleteUser(); // 게스트 계정 삭제
    await FirebaseAuth.instance.signOut(); // 게스트 계정 파이어베이스 로그아웃
    await GoogleSignIn().signOut(); // 게스트 계정 구글 로그아웃

    // UserCredential userAuth =
    //     await FirebaseAuth.instance.signInWithCredential(credential!); // 에러
    UserCredential userAuth = await signInWithApple();
    UserModel? _userModel = await loginUser(userAuth.user!.uid);
    await AuthController.to.submitSignup(_userModel!);
  }

  // Apple IOS 13버전 이상 인증 함수 & Android 인증 함수
  Future<UserCredential> signInWithApple() async {
    // 13버전 이상이거나 Android일 경우 (true)
    bool isAvailable = await SignInWithApple.isAvailable();
    if (isAvailable) {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "com.selldy.yab-flutter-firebase-sns-login-web",
          redirectUri: Uri.parse(
              "https://deeply-hazel-quill.glitch.me/callbacks/sign_in_with_apple"),
        ),
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } else {
      final clientState = const Uuid().v4();
      final url = Uri.https('appleid.apple.com', '/auth/authorize', {
        'response_type': 'code id_token',
        'client_id': "com.selldy.yab-flutter-firebase-sns-login-web",
        'response_mode': 'form_post',
        'redirect_uri':
            'https://deeply-hazel-quill.glitch.me/callbacks/apple/sign_in_with_apple',
        'scope': 'email name',
        'state': clientState,
      });

      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: "applink");

      final body = Uri.parse(result).queryParameters;
      logger.i(body);
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: body['id_token'],
        accessToken: body['code'],
      );
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    }
  }

  // 애플 로그인 버튼
  Future<void> loginButtonApple() async {
    UserCredential userAuth = await signInWithApple();
    UserModel newUserModel = await createUserModel(userAuth);
    await AuthController.to.submitSignup(newUserModel);
  }
}
