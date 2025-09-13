import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  level: kDebugMode ? Level.debug : Level.warning,
  printer: kDebugMode ?
  PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 100,
    colors: true,
    printEmojis: true,
    printTime: false,
  ) :
  SimplePrinter(printTime: true),
);

void logInfoLazy(String Function() message) {
  if (kDebugMode) logger.i(message());
}

void logDebugLazy(String Function() message) {
  if (kDebugMode) logger.d(message());
}

void logVerboseLazy(String Function() message) {
  if (kDebugMode) logger.v(message());
}