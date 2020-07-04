import 'package:Valoguide/core/constants/data.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/widgets.dart';

//const String TestAppId = "ca-app-pub-3940256099942544~3347511713";

class Ads {
  static BannerAd bannerAd;
  static InterstitialAd interstitialAd;
  static bool bannerIsShown = false;
  static bool bannerIsGoingToBeShown = false;
  static bool interstitialIsShown = false;
  static bool interstitialIsGoingToBeShown = false;
  static void initialize() {
//    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    FirebaseAdMob.instance.initialize(
      appId: ADMOB_APP_ID,
    );
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: adMobKeyWords,
    contentUrl: 'https://www.forbes.com',
    childDirected: false,

//    testDevices: TestAppId != null
//        ? [TestAppId]
//        : null, // Android emulators are considered test devices
  );

  static _createBannerAd() {
    bannerAd = BannerAd(
//      adUnitId: BannerAd.testAdUnitId,
      adUnitId: BANNER_AD_UNIT,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          bannerIsShown = true;
          bannerIsGoingToBeShown = false;
        } else if (event == MobileAdEvent.failedToLoad) {
          bannerIsShown = false;
          bannerIsGoingToBeShown = false;
        }
        print("BannerAd event is $event");
      },
    );
  }

  static _createInterstitialAd() {
    interstitialAd = InterstitialAd(
//        adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: INTERSTITIAL_AD_UNIT,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            interstitialIsShown = true;
            interstitialIsGoingToBeShown = false;
          } else if (event == MobileAdEvent.failedToLoad) {
            interstitialIsShown = false;
            interstitialIsGoingToBeShown = false;
          } else if (event == MobileAdEvent.closed) {
            interstitialAd..load();
          }
          print("InterstitialAd event is $event");
        });
  }

  static void showBannerAd([State state]) {
    if (state != null && !state.mounted) return;
    if (bannerAd == null) _createBannerAd();
    if (!bannerIsShown && !bannerIsGoingToBeShown) {
      bannerIsGoingToBeShown = true;
      bannerAd
        ..load()
        ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
    }
  }

  static void hideBannerAd() {
    if (bannerAd != null && !bannerIsGoingToBeShown) {
      bannerAd.dispose().then((disposed) {
        bannerIsShown = !disposed;
      });
      bannerAd = null;
    }
  }

  static void showInterstitialAd([State state]) {
    if (state != null && !state.mounted) return;
    if (interstitialAd == null) _createInterstitialAd();
    if (!interstitialIsShown && !interstitialIsGoingToBeShown) {
      interstitialIsGoingToBeShown = true;
      interstitialAd
        ..load()
        ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
    }
  }

  static void hideInterstitialAd() {
    if (interstitialAd != null && !interstitialIsGoingToBeShown) {
      interstitialAd.dispose().then((disposed) {
        interstitialIsShown = !disposed;
      });
      interstitialAd = null;
    }
  }
}

const List<String> adMobKeyWords = [
  "marketing",
  "game",
  'gaming',
  "dating",
  "insurance",
  "university",
  "trading",
  "shopping",
  "amazon",
  "premium",
];
