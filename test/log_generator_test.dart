import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:log_generator/log_generator.dart';

void main() {
  final log = [];
  const String tag = 'tag';
  const String message = 'message';

  void Function() overridePrint(void Function() testFn) => () {
        final spec = ZoneSpecification(print: (_, __, ___, String msg) {
          log.add(msg);
        });
        return Zone.current.fork(specification: spec).run<void>(testFn);
      };

  tearDown(() => log.clear());

  group('Print log as', () {
    test('function withTag', overridePrint(() {
      LogGenerator().withTag(tag: tag, object: message);
      expect(log, ['\x1B[36m[$tag] $message\x1B[m']);
    }));

    test('error', overridePrint(() {
      LogGenerator().error(message);
      expect(log, ['\x1B[31m[ERROR] $message\x1B[m']);
    }));

    test('info', overridePrint(() {
      LogGenerator().info(message);
      expect(log, ['\x1B[32m[INFO] $message\x1B[m']);
    }));

    test('warning', overridePrint(() {
      LogGenerator().warning(message);
      expect(log, ['\x1B[33m[WARNING] $message\x1B[m']);
    }));

    test('analytics', overridePrint(() {
      LogGenerator().analytics(message);
      expect(log, ['\x1B[34m[ANALYTICS] $message\x1B[m']);
    }));
  });
}
