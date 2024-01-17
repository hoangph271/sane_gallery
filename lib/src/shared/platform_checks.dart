import 'dart:io';
import 'package:flutter/foundation.dart';

bool get isMobile {
  if (kIsWeb) {
    return false;
  }

  return Platform.isAndroid || Platform.isIOS;
}

bool get isSaveAsSupported {
  if (kIsWeb) {
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
