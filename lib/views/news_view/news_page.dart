import 'package:Valoguide/core/constants/adMob.dart';
import 'package:flutter/material.dart';

import '../coming_soon.dart';

class NewsPage extends StatelessWidget {
  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: onWillPop, child: ComingSoon());
  }
}
