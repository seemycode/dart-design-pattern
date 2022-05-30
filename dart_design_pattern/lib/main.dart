import 'dart:io';

part 'behavioral/chain_of_responsibility.dart';
part 'behavioral/command.dart';
part 'behavioral/interpreter.dart';

void client(List<String> arguments) {
  exitCode = 0;
  String? option;
  do {
    stdout.writeln('\x1B[33mRun a design pattern:\x1B[0m');
    stdout.writeln("[1]. Behaviour > Chain of Responsibility");
    stdout.writeln("[2]. Behaviour > Command");
    stdout.writeln("[3]. Behaviour > Command");
    stdout.writeln("[q]. Exit");

    option = stdin.readLineSync();
    stdout.writeln("============");
    switch (option) {
      case 'q':
        exitCode = 0;
        break;
      case '1':
        stdout.writeln(
            '\x1B[36mChain of Responsibility - Behavioral pattern\x1B[0m\n');
        ChainOfReponsibility.invoke();
        break;
      case '2':
        stdout.writeln('\x1B[36mCommand - Behavioral Pattern\x1B[0m\n');
        Command.invoke();
        break;
      case '3':
        stdout.writeln('\x1B[36mInterpreter - Behavioral Pattern\x1B[0m\n');
        Interpreter.invoke();
        break;
    }
    if (option != 'q') stdout.writeln("============\n\n");
  } while (option != 'q');
}
