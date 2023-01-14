import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/gender.dart';
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/page/detector/detector_address_search_page.dart';

class SelectUserInfoPage extends GetView<UserInfoDetectorController> {
  const SelectUserInfoPage({Key? key}) : super(key: key);

//issues: #20 주소검색 추가 - ellee
  Widget _addressSelect() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const AutoSizeText(
                '주소 검색',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await Get.to(() => const DetectorAddressSearchPage());
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (controller.userModelAddressLevel1SelectedValue.value != 'all')
            Text(controller.userModelAddressLevel1SelectedValue.value != 'all'
                ? controller.userModelAddressLevel1SelectedValue.value
                : '전체'),
          Text(controller.userModelAddressLevel2SelectedValue.value != 'all'
              ? controller.userModelAddressLevel2SelectedValue.value
              : '전체'),
          Text(controller.userModelAddressLevel4LSelectedValue.value != 'all'
              ? controller.userModelAddressLevel4LSelectedValue.value
              : '전체'),
        ],
      ),
    );
  }

//issues: #44 생년월일에 따른 연령 필터생성 -ellee
  Widget _birthSelect() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birthAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                  color: controller.birthAll.value ? Colors.white : Colors.grey,
                ),
              ),
              onPressed: () {
                if (controller.birthAll.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = false;
                  controller.birth30.value = false;
                  controller.birth40.value = false;
                  controller.birth50.value = false;
                  controller.birth60.value = false;
                  controller.birthAll.value = true;

                  controller.birthSelectedValue.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth10.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '10대 이하',
                style: TextStyle(
                    color:
                        controller.birth10.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth10.value == false) {
                  controller.birth10.value = true;
                  controller.birth20.value = false;
                  controller.birth30.value = false;
                  controller.birth40.value = false;
                  controller.birth50.value = false;
                  controller.birth60.value = false;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '10';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth20.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '20대',
                style: TextStyle(
                    color:
                        controller.birth20.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth20.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = true;
                  controller.birth30.value = false;
                  controller.birth40.value = false;
                  controller.birth50.value = false;
                  controller.birth60.value = false;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '20';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth30.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '30대',
                style: TextStyle(
                    color:
                        controller.birth30.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth30.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = false;
                  controller.birth30.value = true;
                  controller.birth40.value = false;
                  controller.birth50.value = false;
                  controller.birth60.value = false;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '30';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth40.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '40대',
                style: TextStyle(
                    color:
                        controller.birth40.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth40.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = false;
                  controller.birth30.value = false;
                  controller.birth40.value = true;
                  controller.birth50.value = false;
                  controller.birth60.value = false;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '40';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth50.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '50대',
                style: TextStyle(
                    color:
                        controller.birth50.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth50.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = false;
                  controller.birth30.value = false;
                  controller.birth40.value = false;
                  controller.birth50.value = true;
                  controller.birth60.value = false;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '50';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.birth60.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '60대 이상',
                style: TextStyle(
                    color:
                        controller.birth60.value ? Colors.white : Colors.grey),
              ),
              onPressed: () {
                if (controller.birth60.value == false) {
                  controller.birth10.value = false;
                  controller.birth20.value = false;
                  controller.birth30.value = false;
                  controller.birth40.value = false;
                  controller.birth50.value = false;
                  controller.birth60.value = true;
                  controller.birthAll.value = false;

                  controller.birthSelectedValue.value = '60';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

// issues: #46 학력정보 필터 생성 - ellee
  Widget _educationSelect() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                    color: controller.educationAll.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationAll.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = true;

                  controller.education.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationElementary.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '초등학교 졸업',
                style: TextStyle(
                    color: controller.educationElementary.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationElementary.value == false) {
                  controller.educationElementary.value = true;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'Elementary';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationMiddle.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '중학교 졸업',
                style: TextStyle(
                    color: controller.educationMiddle.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationMiddle.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = true;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'Middle';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationHigh.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '고등학교 졸업',
                style: TextStyle(
                    color: controller.educationHigh.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationHigh.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = true;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'High';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationJuniorCollege.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전문학사',
                style: TextStyle(
                    color: controller.educationJuniorCollege.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationJuniorCollege.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = true;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'JuniorCollege';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationUniversity.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '학사',
                style: TextStyle(
                    color: controller.educationUniversity.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationUniversity.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = true;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'University';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationMaster.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '석사',
                style: TextStyle(
                    color: controller.educationMaster.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationMaster.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = true;
                  controller.educationDoctor.value = false;
                  controller.educationAll.value = false;

                  controller.education.value = 'Master';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.educationDoctor.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '박사',
                style: TextStyle(
                    color: controller.educationDoctor.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.educationDoctor.value == false) {
                  controller.educationElementary.value = false;
                  controller.educationMiddle.value = false;
                  controller.educationHigh.value = false;
                  controller.educationJuniorCollege.value = false;
                  controller.educationUniversity.value = false;
                  controller.educationMaster.value = false;
                  controller.educationDoctor.value = true;
                  controller.educationAll.value = false;

                  controller.education.value = 'Doctor';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _genderSelect() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.genderAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                    color: controller.genderAll.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.genderAll.value == false) {
                  controller.genderMale.value = false;
                  controller.genderWoman.value = false;
                  controller.genderAll.value = true;
                  controller.genderSelectedValue.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.genderMale.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                genderMapEngToKor.values.elementAt(1),
                style: TextStyle(
                    color: controller.genderMale.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.genderMale.value == false) {
                  controller.genderMale.value = true;
                  controller.genderWoman.value = false;
                  controller.genderAll.value = false;
                  controller.genderSelectedValue.value =
                      genderMapKorToEng.values.elementAt(1);
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.genderWoman.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                genderMapEngToKor.values.elementAt(2),
                style: TextStyle(
                    color: controller.genderWoman.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.genderWoman.value == false) {
                  controller.genderMale.value = false;
                  controller.genderWoman.value = true;
                  controller.genderAll.value = false;
                  controller.genderSelectedValue.value =
                      genderMapKorToEng.values.elementAt(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _nationalitySelect() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.nationalityAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                    color: controller.nationalityAll.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.nationalityAll.value == false) {
                  controller.nationalityLocal.value = false;
                  controller.nationalityForeigner.value = false;
                  controller.nationalityAll.value = true;
                  controller.genderSelectedValue.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.nationalityLocal.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                nationalityMapEngToKor.values.elementAt(1),
                style: TextStyle(
                    color: controller.nationalityLocal.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.nationalityLocal.value == false) {
                  controller.nationalityLocal.value = true;
                  controller.nationalityForeigner.value = false;
                  controller.nationalityAll.value = false;
                  controller.nationalitySelectedValue.value =
                      nationalityMapKorToEng.values.elementAt(1);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.nationalityForeigner.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                nationalityMapEngToKor.values.elementAt(2),
                style: TextStyle(
                    color: controller.nationalityForeigner.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.nationalityForeigner.value == false) {
                  controller.nationalityLocal.value = false;
                  controller.nationalityForeigner.value = true;
                  controller.nationalityAll.value = false;
                  controller.nationalitySelectedValue.value =
                      nationalityMapKorToEng.values.elementAt(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _maritalstatusSelect() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.maritalstatusAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                    color: controller.maritalstatusAll.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.maritalstatusAll.value == false) {
                  controller.maritalstatusMarried.value = false;
                  controller.maritalstatusSingle.value = false;
                  controller.maritalstatusAll.value = true;
                  controller.maritalstatusSelectedValue.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.maritalstatusMarried.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                maritalstatusMapEngToKor.values.elementAt(1),
                style: TextStyle(
                    color: controller.maritalstatusMarried.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.maritalstatusMarried.value == false) {
                  controller.maritalstatusMarried.value = true;
                  controller.maritalstatusSingle.value = false;
                  controller.maritalstatusAll.value = false;
                  controller.maritalstatusSelectedValue.value =
                      maritalstatusMapKorToEng.values.elementAt(1);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.maritalstatusSingle.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                maritalstatusMapEngToKor.values.elementAt(2),
                style: TextStyle(
                    color: controller.maritalstatusSingle.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.maritalstatusSingle.value == false) {
                  controller.maritalstatusMarried.value = false;
                  controller.maritalstatusSingle.value = true;
                  controller.maritalstatusAll.value = false;
                  controller.maritalstatusSelectedValue.value =
                      maritalstatusMapKorToEng.values.elementAt(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _childrenSelect() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.childrenAll.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                '전체',
                style: TextStyle(
                    color: controller.childrenAll.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.childrenAll.value == false) {
                  controller.childrenExistence.value = false;
                  controller.childrenNonexistence.value = false;
                  controller.childrenAll.value = true;
                  controller.childrenSelectedValue.value = 'all';
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.childrenExistence.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                childrenMapEngToKor.values.elementAt(1),
                style: TextStyle(
                    color: controller.childrenExistence.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.childrenExistence.value == false) {
                  controller.childrenExistence.value = true;
                  controller.childrenNonexistence.value = false;
                  controller.childrenAll.value = false;
                  controller.childrenSelectedValue.value =
                      childrenMapKorToEng.values.elementAt(1);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: controller.childrenNonexistence.value
                      ? Colors.deepPurpleAccent
                      : Colors.white),
              child: AutoSizeText(
                childrenMapEngToKor.values.elementAt(2),
                style: TextStyle(
                    color: controller.childrenNonexistence.value
                        ? Colors.white
                        : Colors.grey),
              ),
              onPressed: () {
                if (controller.childrenNonexistence.value == false) {
                  controller.childrenExistence.value = false;
                  controller.childrenNonexistence.value = true;
                  controller.childrenAll.value = false;
                  controller.childrenSelectedValue.value =
                      childrenMapKorToEng.values.elementAt(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

//issues: #20 주소검색 추가 - ellee
  Widget _categoryAddressSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !controller.addressSelect.value
              ? Colors.white
              : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = true;
            controller.birthSelect.value = false;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '주소',
                style: TextStyle(
                    fontSize: 13,
                    color: !controller.addressSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.addressSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

//issues: #44 생년월일에 따른 연령 필터생성 -ellee
  Widget _categoryBirthSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              !controller.birthSelect.value ? Colors.white : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = true;
            controller.educationSelect.value = false;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '연령',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.birthSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.birthSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryEducationSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !controller.educationSelect.value
              ? Colors.white
              : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = false;
            controller.educationSelect.value = true;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '학력',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.educationSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.educationSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryGenderSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              !controller.genderSelect.value ? Colors.white : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = false;
            controller.educationSelect.value = false;
            controller.genderSelect.value = true;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '성별',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.genderSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.genderSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryNationalitySelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !controller.nationalitySelect.value
              ? Colors.white
              : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = false;
            controller.educationSelect.value = false;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = true;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '국적',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.nationalitySelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.nationalitySelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryMaritalstatusSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !controller.maritalstatusSelect.value
              ? Colors.white
              : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = false;
            controller.educationSelect.value = false;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = true;
            controller.childrenSelect.value = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '혼인 여부',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.maritalstatusSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.maritalstatusSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryChildrenSelect() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !controller.childrenSelect.value
              ? Colors.white
              : Colors.deepPurple,
        ),
        child: InkWell(
          onTap: () {
            controller.addressSelect.value = false;
            controller.birthSelect.value = false;
            controller.educationSelect.value = false;
            controller.genderSelect.value = false;
            controller.nationalitySelect.value = false;
            controller.maritalstatusSelect.value = false;
            controller.childrenSelect.value = true;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '자녀 유무',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: !controller.childrenSelect.value
                        ? Colors.black
                        : Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right,
                  color: !controller.childrenSelect.value
                      ? Colors.black
                      : Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: Get.size.width / 3,
            child: Column(
              children: [
                //issues: #20 주소검색 추가 - ellee
                // _categoryAddressSelect(),
                // const Divider(color: Colors.grey, thickness: 2),
                _categoryBirthSelect(),
                const Divider(color: Colors.grey, thickness: 2),
                _categoryEducationSelect(),
                const Divider(color: Colors.grey, thickness: 2),
                _categoryGenderSelect(),
                const Divider(color: Colors.grey, thickness: 2),
                _categoryNationalitySelect(),
                const Divider(color: Colors.grey, thickness: 2),
                _categoryMaritalstatusSelect(),
                const Divider(color: Colors.grey, thickness: 2),
                _categoryChildrenSelect(),
              ],
            ),
          ),
        ),
        const VerticalDivider(color: Colors.grey, thickness: 1),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: Get.size.width / 2,
            child: Obx(
              () => Column(
                children: [
                  //issues: #20 주소검색 추가 - ellee
                  if (!controller.addressSelect.value &&
                      !controller.birthSelect.value &&
                      !controller.educationSelect.value &&
                      !controller.genderSelect.value &&
                      !controller.nationalitySelect.value &&
                      !controller.maritalstatusSelect.value &&
                      !controller.childrenSelect.value)
                    Column(
                      children: [
                        Image.asset('assets/images/logo/app-icon.png',
                            height: 80),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('원하는 필터를 적용하여 유저를 검색해 보세요'),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '우측 상단의',
                                  style: Get.theme.textTheme.bodyMedium,
                                ),
                                const WidgetSpan(
                                    child: Icon(
                                  Icons.filter_alt,
                                  size: 16,
                                )),
                                TextSpan(
                                  text: '버튼으로 \n필터를 확인할 수 있습니다.',
                                  style: Get.theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('초기화 버튼으로 모든 선택 내역을 초기화 할 수 있습니다.'),
                        const SizedBox(height: 20),
                        const Text('당연하겠지만 많은 필터를 적용하면 검색되는 유저가 줄어들겠죠?'),
                      ],
                    ),
                  if (controller.addressSelect.value) _addressSelect(),
                  if (controller.birthSelect.value) _birthSelect(),
                  if (controller.educationSelect.value) _educationSelect(),
                  if (controller.genderSelect.value) _genderSelect(),
                  if (controller.nationalitySelect.value) _nationalitySelect(),
                  if (controller.maritalstatusSelect.value)
                    _maritalstatusSelect(),
                  if (controller.childrenSelect.value) _childrenSelect()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
