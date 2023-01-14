import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/address_search_controller.dart';

class AddressSearchPage extends GetView<AddressSearchController> {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1, // 앱바와 바디 사이의 선
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: Text(
          '주소 찾기',
          style: Get.theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .requestFocus(FocusNode()); // TextFormField에서 포커스 사라질 시 키보드 숨김
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: controller.addressTextEditngController,
                  onFieldSubmitted: (text) async {
                    controller.isGettingLocation(true);
                    controller.addressModel.value =
                        await controller.searchAddressByStr(text);
                    controller.isGettingLocation(false);
                  }, // 입력하는 화면의 키보드에서 완료 버튼을 눌렀을 시 발생
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: '도로명으로 검색 (상세주소는 입력받지 않습니다.)',
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey)), // 언더라인을 설정 여러가지를 변경할 수 있음
                      prefixIconConstraints: const BoxConstraints(
                          minWidth: 24, maxHeight: 24)), // 아이콘 넣기 패팅 조절 언더라인 변경
                ),
              ),
              if (controller.addressModel.value != null)
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (controller.addressModel.value.result == null ||
                            controller.addressModel.value.result!.items ==
                                null ||
                            controller.addressModel.value.result!.items![index]
                                    .address ==
                                null) return Container();
                        return ListTile(
                          onTap: () async {
                            controller.setAddress(index, 50);

                            Get.back();
                          },
                          title: Text(
                              '${controller.addressModel.value.result!.items![index].address!.road} ${controller.addressModel.value.result!.items![index].address!.bldnmdc}'),
                          subtitle: Text(controller.addressModel.value.result!
                                  .items![index].address!.parcel ??
                              ""),
                        );
                      },
                      itemCount: (controller.addressModel.value.result ==
                                  null ||
                              controller.addressModel.value.result!.items ==
                                  null)
                          ? 0
                          : controller.addressModel.value.result!.items!.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            controller.isGettingLocation(true);
            controller.addressModel.value = await controller
                .searchAddressByStr(controller.addressTextEditngValue.value);
            controller.isGettingLocation(false);
            Get.focusScope!.unfocus(); // 키보드 밑으로 내리기
          },
          child: const Text('주소 찾기'),
        ),
      ),
    );
  }
}
