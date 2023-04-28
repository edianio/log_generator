import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:log_generator/log_generator.dart';

void main() {
  var log = [];
  const String message = 'message';

  void Function() overridePrint(void Function() testFn) => () {
    var spec = ZoneSpecification(
        print: (_, __, ___, String msg) {
          log.add(msg);
        }
    );
    return Zone.current.fork(specification: spec).run<void>(testFn);
  };

  group('Print log as', () {
    test('error', overridePrint(() {
      LogGenerator().error(message);
      expect(log, ['\x1B[31m[ERROR] $message\x1B[m']);
      log.clear();
    }));

    test('info', overridePrint(() {
      LogGenerator().info(message);
      expect(log, ['\x1B[32m[INFO] $message\x1B[m']);
      log.clear();
    }));

    test('warning', overridePrint(() {
      LogGenerator().warning(message);
      expect(log, ['\x1B[36m[WARNING] $message\x1B[m']);
      log.clear();
    }));

    test('analytics', overridePrint(() {
      LogGenerator().analytics(message);
      expect(log, ['\x1B[33m[ANALYTICS] $message\x1B[m']);
      log.clear();
    }));
  });
}
