import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/model/user_model.dart';

class AnonymousLoginController extends GetxController {
  static AnonymousLoginController get to => Get.find();

  // 최초 로그인 할때
  Future<void> signInWithFirstLogin() async {
    if (FirebaseAuth.instance.currentUser == null) {
      UserCredential userAuth = await siginInWithAnonymous();
      await AuthController.to.loginUser(userAuth.user!.uid);
      UserModel newUserModel =
          await AuthController.to.createUserModel(userAuth);
      await AuthController.to.submitSignup(newUserModel);
      return;
    }

    UserModel? _userModel = await AuthController.to
        .loginUser(FirebaseAuth.instance.currentUser!.uid);
    if (_userModel != null) {
      return;
    } else {
      UserCredential userAuth = await siginInWithAnonymous();
      await AuthController.to.loginUser(userAuth.user!.uid);
      UserModel newUserModel =
          await AuthController.to.createUserModel(userAuth);
      await AuthController.to.submitSignup(newUserModel);
    }
  }

  // 익명 로그인
  Future<UserCredential> siginInWithAnonymous() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  // @override
  // void onInit() async {
  //   await signInWithFirstLogin();

  //   super.onInit();
  // }
}
