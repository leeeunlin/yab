import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yab_v2/src/controller/app_info_controller.dart';
import 'package:yab_v2/src/page/my/body_menu_widget.dart';
import 'package:yab_v2/src/page/my/header_menu_widget.dart';
import 'package:yab_v2/src/size_config.dart';

class MyPage extends GetView<AppInfoController> {
  const MyPage({Key? key}) : super(key: key);

  Container gap() {
    return Container(
      height: getProportionateScreenHeight(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: const Text('설정'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const HeaderMenuWidget(),
            Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, bottom: 10, right: 10),
                width: double.infinity,
                child: Text(
                  '나의 정보',
                  style: Get.theme.textTheme.subtitle1,
                )),
            BodyMenuWidget(bodyMenuList: iconLoginMenu),
            gap(),
            Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, bottom: 10, right: 10),
                width: double.infinity,
                child: Text(
                  '파트너 센터',
                  style: Get.theme.textTheme.subtitle1,
                )),
            BodyMenuWidget(bodyMenuList: iconMenu2),
            gap(),
            Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, bottom: 10, right: 10),
                width: double.infinity,
                child: Text(
                  'YAB 앱 가이드',
                  style: Get.theme.textTheme.subtitle1,
                )),
            BodyMenuWidget(bodyMenuList: logOutMenu),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Text('v ${controller.packageInfo!.version}',
                    textAlign: TextAlign.end))
          ],
        ),
      ),
    );
  }
}
