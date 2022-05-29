import 'package:roggle/roggle.dart';

final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: '[APP]',
    printCaller: false,
  ),
);
