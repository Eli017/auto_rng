import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1655051670432168/1296773130';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1655051670432168/1810658894';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}