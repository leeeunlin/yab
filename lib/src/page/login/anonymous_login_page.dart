import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/anonymous_login_controller.dart';
import 'package:yab_v2/src/size_config.dart';

class AnonymousLoginPage extends GetView<AnonymousLoginController> {
  const AnonymousLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
      color: Color.fromRGBO(253, 216, 53, 1),
      size: 40,
    );
    return Scaffold(
      body: FutureBuilder(
        future: controller.signInWithFirstLogin(),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo/app-icon.png', height: 80),
                SizedBox(height: getProportionateScreenHeight(15)),
                const Text('아이디 생성중입니다.'),
                spinkit,
              ],
            ),
          );
        },
      ),
    );
  }
}
