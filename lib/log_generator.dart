library log_generator;

import 'dart:io';

import 'package:flutter/foundation.dart';

part 'printer.dart';

enum _LogColor {
  reset('\x1b[m'),
  red('\x1b[31m'),
  yellow('\x1b[33m'),
  green('\x1b[32m'),
  blue('\x1b[36m');

  final String ansiCode;

  const _LogColor(this.ansiCode);
}

class LogGenerator {
  final Printer printer;

  LogGenerator({this.printer = const Printer()});

  void _log(_LogColor color, Object object) {
    if (kDebugMode) {
      print('${color.ansiCode}'
          '${printer.start}$object${printer.end}'
          '${_LogColor.reset.ansiCode}');
    }
    stdout.writeln('${color.ansiCode}'
        '${printer.start}$object${printer.end}'
        '${_LogColor.reset.ansiCode}');
  }

  void info(Object object) {
    _log(_LogColor.green, '[INFO] $object');
  }

  void warning(Object object) {
    _log(_LogColor.blue, '[WARNING] $object');
  }

  void error(Object object) {
    _log(_LogColor.red, '[ERROR] $object');
  }

  void analytics(Object object) {
    _log(_LogColor.yellow, '[ANALYTICS] $object');
  }
}
