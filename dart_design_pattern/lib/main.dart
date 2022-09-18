import 'dart:io';

part 'behavioral/chain_of_responsibility.dart';
part 'behavioral/command.dart';
part 'behavioral/interpreter.dart';
part 'behavioral/iterator.dart';
part 'behavioral/mediator.dart';
part 'behavioral/memento.dart';
part 'behavioral/observer.dart';

void client(List<String> arguments) {
  exitCode = 0;
  String? option;
  do {
    stdout.writeln('\x1B[33mRun a design pattern:\x1B[0m');
    stdout.writeln("[1]. Behaviour > Chain of Responsibility");
    stdout.writeln("[2]. Behaviour > Command");
    stdout.writeln("[3]. Behaviour > Interpreter");
    stdout.writeln("[4]. Behaviour > Iterator");
    stdout.writeln("[5]. Behaviour > Mediator");
    stdout.writeln("[6]. Behaviour > Memento");
    stdout.writeln("[7]. Behaviour > Observer");
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
      case '4':
        stdout.writeln('\x1B[36mIterator - Behavioral Pattern\x1B[0m\n');
        Iterator.invoke();
        break;
      case '5':
        stdout.writeln('\x1B[36mMediator - Behavioral Pattern\x1B[0m\n');
        Mediator.invoke();
        break;
      case '6':
        stdout.writeln('\x1B[36mMemento - Behavioral Pattern\x1B[0m\n');
        Memento.invoke();
        break;
      case '7':
        stdout.writeln('\x1B[36mObserver - Behavioral Pattern\x1B[0m\n');
        Observer.invoke();
        break;
    }
    if (option != 'q') stdout.writeln("============\n\n");
  } while (option != 'q');
}
