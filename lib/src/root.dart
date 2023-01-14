import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/model/user_model.dart';
import 'package:yab_v2/src/page/loding/loding_page.dart';
import 'package:yab_v2/src/page/login/anonymous_login_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return FutureBuilder<UserModel?>(
            future: controller.loginUser(user.data!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const App();
              } else {
                return Obx(() => controller.userModel.value.userKey != null
                    ? const App()
                    : snapshot.connectionState == ConnectionState.done
                        // ? const LoginPage()
                        ? const LodingPage()
                        : const LodingPage());
              }
            },
          );
        } else {
          return const AnonymousLoginPage();
        }
      },
    );
  }
}
