import 'package:auto_rng/services/duration_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../helpers/ad_helper.dart';
import '../widgets/duration_selector.dart';
import '../widgets/randomizer.dart';
import '../widgets/unique_duration_selector.dart';

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({Key? key, required this.items}) : super(key: key);

  final List items;

  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  late bool isRandomizerActive = false;
  int millisecondDuration = 0;
  final DurationService durationService = DurationService();
  DurationType durationType = DurationType.traditional;
  BannerAd? bannerAd;

  @override
  void initState() {
    durationService.getDurationType().then((DurationType value) => {
      setState(() => durationType = value)
    });
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  void toggleRandomizer(bool isActive) {
    setState(() => isRandomizerActive = isActive);
  }

  void updateDuration(int duration) {
    setState(() => millisecondDuration = duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your duration'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isRandomizerActive && (durationType == DurationType.traditional),
                  maintainState: true,
                  child: DurationSelector(updateDuration: updateDuration, toggleRandomizer: toggleRandomizer)
                ),
                Visibility(
                    visible: !isRandomizerActive && (durationType == DurationType.unique),
                    maintainState: true,
                    child: UniqueDurationSelector(updateDuration: updateDuration, toggleRandomizer: toggleRandomizer)
                ),
                Visibility(
                    visible: isRandomizerActive,
                    child: Randomizer(toggleRandomizer: toggleRandomizer, milliseconds: millisecondDuration, items: widget.items)
                ),
              ],
            ),
          ),
          if (bannerAd != null)
            Align(
              alignment: const Alignment(0.0, 0.9),
              child: SizedBox(
                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}
