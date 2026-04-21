import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppLogger {
  static void setup() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        debugPrint('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }

  static Logger get(String name) => Logger(name);
}
