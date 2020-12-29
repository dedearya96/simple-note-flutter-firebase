import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class Ads {
  static BannerAd _bannerAd;

  static InterstitialAd _interstitialAd;
  static void initialize() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9695181715864417~6973755002");
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  static BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-2330507057963783/3457134718",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  static InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-2330507057963783/9521664390",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  static void showBannerAd() {
    if (_bannerAd == null) _bannerAd = _createBannerAd();
    _bannerAd
      ..load()
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
  }

  static void showInterstitialAd() {
    if (_interstitialAd == null) _interstitialAd = _createInterstitialAd();
    _interstitialAd
      ..load()
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
  }

  static void hideBannerAd() async {
    await _bannerAd.dispose();
    _bannerAd = null;
  }

  static void hideIntersttialAd() async {
    await _interstitialAd.dispose();
    _interstitialAd = null;
  }
}
