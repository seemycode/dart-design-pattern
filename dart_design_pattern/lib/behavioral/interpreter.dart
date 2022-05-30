part of '../main.dart';

class Context {
  String input;
  int output;
  Context({this.input = '', this.output = 0});
}

abstract class Expression {
  interpret(Context context) {
    if (context.input.isEmpty) return;
    if (context.input.startsWith(nine)) {
      context.output += 9 * multiplier;
      context.input = context.input.substring(2);
    }
    if (context.input.startsWith(four)) {
      context.output += 4 * multiplier;
      context.input = context.input.substring(2);
    }
    if (context.input.startsWith(five)) {
      context.output += 5 * multiplier;
      context.input = context.input.substring(1);
    }
    while (context.input.startsWith(one)) {
      context.output += 1 * multiplier;
      context.input = context.input.substring(1);
    }
  }

  String get one => ' ';
  String get four => ' ';
  String get five => ' ';
  String get nine => ' ';
  int get multiplier;
}

class ThousandExpression extends Expression {
  @override
  String get one => 'M';

  @override
  int get multiplier => 1000;
}

class HundredExpression extends Expression {
  @override
  String get one => 'C';

  @override
  String get four => 'CD';

  @override
  String get five => 'D';

  @override
  String get nine => 'CM';

  @override
  int get multiplier => 100;
}

class TenExpression extends Expression {
  @override
  String get one => 'X';

  @override
  String get four => 'XL';

  @override
  String get five => 'L';

  @override
  String get nine => 'XC';

  @override
  int get multiplier => 10;
}

class OneExpression extends Expression {
  @override
  String get one => 'I';

  @override
  String get four => 'IV';

  @override
  String get five => 'V';

  @override
  String get nine => 'IX';

  @override
  int get multiplier => 1;
}

class Interpreter {
  static invoke() {
    stdout.writeln(
        '''Defines a representation for its grammar along with an interpreter 
that uses the representation to interpret sentences in the language.
''');

    stdout.writeln('''Pros
- Easy to change and exchange the grammar since it uses classes to represent rules.
Cons
- Complex grammars are hard to maintain since it defines at least a class for every rule.
\n''');

    stdout.writeln('Output of Roman to Int interpreter:\n');

    String roman = "MMXXII";
    Context context = Context(input: roman);

    var tree = <Expression>[
      ThousandExpression(),
      HundredExpression(),
      TenExpression(),
      OneExpression(),
    ];

    for (var exp in tree) {
      exp.interpret(context);
    }

    stdout.writeln('$roman = ${context.output}');
  }
}
