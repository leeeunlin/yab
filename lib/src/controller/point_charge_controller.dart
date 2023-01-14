import 'package:get/get.dart';

class PointChargeController extends GetxController {
  static PointChargeController get to => Get.find();
  RxString selected = '5750'.obs;

  List<String> price = ['5750', '11500', '33900', '55900', '109000', '209000'];
  onChangePrice(dynamic price) {
    selected.value = price;
  }
}
