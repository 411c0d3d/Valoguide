import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_config/flutter_config.dart';

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
    // TODO : USE a .env file to extract AdMobAppId
    FirebaseAdMob.instance.initialize(
      appId: FlutterConfig.get("ADMOB_APP_ID"),
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
      // TODO : Replace the testAdUnitId with an ad unit id from the AdMob dash.

//      adUnitId: BannerAd.testAdUnitId,
      adUnitId: FlutterConfig.get("BANNER_AD_UNIT"),
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

  static _createInterstitialAd() {
    interstitialAd = InterstitialAd(
        // TODO : Replace the testAdUnitId with an ad unit id from the AdMob dash.
        adUnitId: FlutterConfig.get("INTERSTITIAL_AD_UNIT"),
//        adUnitId: InterstitialAd.testAdUnitId,
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
  "advertising",
  'fashion',
  "insurance",
  "health insurance",
  "travel insurance",
  "jobs",
  "car insurance",
  "stock",
  "options",
  "business",
  "crypto",
  "online education",
  "legal",
  "ebay",
  "amazon",
  "lawyer",
  "mortgage",
  "degree",
  "education",
  "visa",
  "trading",
  "kids",
  "gambling",
  "sponsored",
  "luxury",
  "luxury",
  "Internet",
  "Telecom",
];
