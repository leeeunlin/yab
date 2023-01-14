import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_v2/src/utils/logger.dart';

class AdmobController extends GetxController {
  static AdmobController get to => Get.find();
  RewardedAd? rewardedAd; // 리워드 광고

  @override
  void onInit() async {
    _loadRewardedAd(); // 리워드 광고 설정
    super.onInit();
  }

  // 리워드 광고 함수
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: kReleaseMode
          ? GetPlatform.isIOS
              ? 'ca-app-pub-2175953775265407/4701690352'
              : 'ca-app-pub-2175953775265407/2150429072'
          : GetPlatform.isIOS
              ? 'ca-app-pub-3940256099942544/5224354917'
              : 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;

          rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) =>
                logger.i('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              logger.i('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              rewardedAd = null;
              _loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              logger.i('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              rewardedAd = null;
              _loadRewardedAd();
            },
            onAdImpression: (RewardedAd ad) =>
                logger.i('$ad impression occurred.'),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          logger.i("RewardedAd failed to load: $error");
        },
      ),
    );
  }
}
