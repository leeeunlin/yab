import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/page/home/not_found_page.dart';
import 'package:yab_v2/src/size_config.dart';

final List<String> eventImgPath = [
  "assets/images/entertainment/1.jpg",
  "assets/images/entertainment/2.jpg",
  "assets/images/entertainment/3.jpg",
];

final List<Widget> eventPage = [
  const NotFoundPage(), // 이벤트페이지 연결부분 차후 수정 필요
  const NotFoundPage(), //  이벤트페이지 연결부분 차후 수정 필요
  const NotFoundPage(), // 이벤트페이지 연결부분 차후 수정 필요
];

class Entertainment extends StatelessWidget {
  Entertainment({Key? key}) : super(key: key);

  final controller = PageController(viewportFraction: 0.9, keepPage: true);
  final pages = List.generate(
    3, // 이벤트 페이지 그림을 여러개 넣을 경우 해당 숫자 수정 필요
    (index) => InkWell(
      onTap: () async {
        await Get.to(() => eventPage[index]);
      },
      child: Container(
        margin: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(20)),
        child: ExtendedImage.asset(
          eventImgPath[index],
          fit: BoxFit.fill,
          borderRadius: BorderRadius.circular(16),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: Get.size.height * 0.2,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (_, index) {
                return pages[index % pages.length];
              },
            ),
          ),
        ],
      ),
    );
  }
}
