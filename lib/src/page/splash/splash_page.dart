import 'package:flutter/material.dart';
import 'package:yab_v2/src/size_config.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo/app-icon.png', height: 80),
              SizedBox(
                height: getProportionateScreenHeight(60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
