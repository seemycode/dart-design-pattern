import 'dart:io';
part '../lib/behavioral/chain_of_responsibility.dart';

void main(List<String> arguments) {
  exitCode = 0;
  String? option;
  do {
    stdout.writeln('\x1B[33mRun a design pattern:\x1B[0m');
    stdout.writeln("[1]. Behaviour > Chain of Responsibility");
    stdout.writeln("[q]. Exit");

    option = stdin.readLineSync();
    stdout.writeln("============");
    switch (option) {
      case 'q':
        exitCode = 0;
        break;
      case '1':
        stdout.writeln('\x1B[36mBehavioral pattern\x1B[0m\n');
        ChainOfReponsibility.invoke();
        break;
    }
    stdout.writeln("============\n\n");
  } while (option != 'q');
}
