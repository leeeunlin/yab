import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yab_v2/src/size_config.dart';

class LodingPage extends StatelessWidget {
  const LodingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinkit =
        SpinKitRing(color: Color.fromRGBO(253, 216, 53, 1), size: 40);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo/app-icon.png', height: 80),
            SizedBox(height: getProportionateScreenHeight(15)),
            spinkit,
          ],
        ),
      ),
    );
  }
}
