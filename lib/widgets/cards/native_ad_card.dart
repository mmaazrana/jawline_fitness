import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/widgets/loader.dart';

class NativeAdCard extends StatefulWidget {
  const NativeAdCard({Key? key}) : super(key: key);

  @override
  State<NativeAdCard> createState() => _NativeAdCardState();
}

class _NativeAdCardState extends State<NativeAdCard> {
  void onAdPressed() {}

  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nativeAd!.dispose();
  }

  // TODO: replace this test ad unit with your own ad unit.
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-1277898408996893/6652438566'
      : 'ca-app-pub-3940256099942544/3986624511';

  /// Loads a native ad.
  void loadAd() {
    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (ad) {},
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (ad) {},
        // For iOS only. Called before dismissing a full screen view
        onAdWillDismissScreen: (ad) {},
        // Called when an ad receives revenue value.
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      // Styling
      nativeTemplateStyle: NativeTemplateStyle(
        // Required: Choose a template.
        templateType: TemplateType.small,
        // Optional: Customize the ad's style.
        mainBackgroundColor: AppColors.darkGrey,
        cornerRadius: 0.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: AppColors.lightBlack,
            backgroundColor: AppColors.yellow,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
            textColor: AppColors.grey,
            style: NativeTemplateFontStyle.bold,
            size: 22.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: AppColors.yellow,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: AppColors.darkGrey,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    // Small template
    final smallAdContainer = Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(
        minWidth: 320, // minimum recommended width
        minHeight: 68, // minimum recommended height
        maxWidth: 400,
        maxHeight: 95,
      ),
      child: AdWidget(ad: _nativeAd!),
    );

    return !_nativeAdIsLoaded
        ? Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Loader(text: "Loading Data"),
          )
        : smallAdContainer;
  }
}
