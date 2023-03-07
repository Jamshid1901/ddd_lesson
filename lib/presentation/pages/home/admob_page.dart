import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobPage extends StatefulWidget {
  const AdmobPage({Key? key}) : super(key: key);

  @override
  State<AdmobPage> createState() => _AdmobPageState();
}

class _AdmobPageState extends State<AdmobPage> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  RewardedInterstitialAd? _rewardeInterstitialdAd;
  bool _isLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  // final admobId = Platform.isAndroid
  //     ? 'ca-app-pub-8153801723284884/4119002933'
  //     : 'ca-app-pub-8153801723284884/3502821612';

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  final adUnitId2 = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  final adUnitId3 = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  final adUnitId4 = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';

  void loadAdBanner() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: ${err.message} ');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  void loadAdInterstitial() {
    _isLoaded = true;
    setState(() {});
    InterstitialAd.load(
        adUnitId: adUnitId2,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            _interstitialAd = ad;
            _isLoaded = false;
            setState(() {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            _isLoaded = false;
            setState(() {});
          },
        ));
  }

  void loadAdRewarded() {
    RewardedAd.load(
      adUnitId: adUnitId3,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void loadAdRewardedInterstitial() {
    RewardedInterstitialAd.load(
        adUnitId: adUnitId4,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardeInterstitialdAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ),);
  }

  @override
  void initState() {
    loadAdBanner();
    loadAdInterstitial();
    loadAdRewarded();
    loadAdRewardedInterstitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Text("Admob Banner"),
          if (_bannerAd != null)
            SizedBox(
              width: _bannerAd?.size.width.toDouble(),
              height: _bannerAd?.size.height.toDouble(),
              child: SafeArea(
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                _interstitialAd!.show();
                Navigator.pop(context);
              },
              child: _isLoaded
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text("AdMob Interstitial")),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                _rewardedAd!.show(onUserEarnedReward: (s, d) {});
              },
              child: _isLoaded
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text("AdMob Rewarded")),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                _rewardeInterstitialdAd!.show(onUserEarnedReward: (s, d) {});
              },
              child: _isLoaded
                  ? CircularProgressIndicator(
                color: Colors.white,
              )
                  : Text("AdMob Rewarde Interstitial"))
        ],
      ),
    );
  }
}
