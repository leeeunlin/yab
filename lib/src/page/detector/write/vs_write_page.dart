import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/size_config.dart';

class VSWritePage extends GetView<UserInfoDetectorController> {
  const VSWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _devider = Divider(
      height: 0,
      thickness: 1,
      color: Colors.grey[350],
      indent: getProportionateScreenWidth(20),
      endIndent: getProportionateScreenWidth(20),
    );

    var _border = const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));

    TextFormField _textFieldTitle(String hintText,
        TextEditingController controller, TextInputType textInputType) {
      return TextFormField(
        maxLength: 30,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      );
    }

    TextFormField _textField(String hintText, TextEditingController controller,
        TextInputType textInputType) {
      return TextFormField(
        maxLength: 20,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      );
    }

    return Column(
      children: [
        _textFieldTitle(
            '제목을 작성해주세요.', controller.vsTitle, TextInputType.multiline),
        _devider,
        _textField(
            '첫번째 항목을 작성해주세요.', controller.vsADetail, TextInputType.multiline),
        _devider,
        _textField(
            '두번째 항목을 작성해주세요.', controller.vsBDetail, TextInputType.multiline),
        _devider
      ],
    );
  }
}
