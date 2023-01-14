import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/page/detector/write/promotion_multi_image_select.dart';
import 'package:yab_v2/src/size_config.dart';

class PromotionWritePage extends GetView<UserInfoDetectorController> {
  const PromotionWritePage({Key? key}) : super(key: key);

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
        controller: controller,
        keyboardType: textInputType,
        minLines: 1, //Normal textInputField will be displayed
        maxLines: null,
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
        const PromotionMultiImageSelect(),
        _devider,
        _textFieldTitle(
            '제목을 작성해주세요.', controller.promotionTitle, TextInputType.multiline),
        _devider,
        _textField('게시글 내용을 작성해주세요.', controller.promotionDetail,
            TextInputType.multiline),
      ],
    );
  }
}
