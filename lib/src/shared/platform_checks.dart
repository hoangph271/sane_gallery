import 'dart:io';
import 'package:flutter/foundation.dart';

bool isMobile = Platform.isAndroid || Platform.isIOS;
const bool isWeb = kIsWeb;

bool get isSaveAsSupported {
  if (isWeb) {
    return false;
  } else if (Platform.isAndroid) {
    return true;
  } else if (Platform.isIOS) {
    return true;
  } else if (Platform.isMacOS) {
    return true;
  } else {
    return false;
  }
}

bool get isShareSupported {
  if (isWeb) {
    if (Platform.isMacOS) {
      return false;
    }
  }

  return true;
}
