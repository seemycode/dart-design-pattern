part of '../../bin/main.dart';

/// Contains information about requested [Loan]
/// [amount] requested for the loan
/// [purpose] what this loan is for
/// [number] client's id
class Loan {
  double amount;
  String purpose;
  int number;
  Loan(this.amount, this.purpose, this.number);
}

/// Interface for all concrete [Approver]'s handlers
abstract class Approver {
  final String name;
  Approver(this.name);

  Approver? successor;
  processRequest(Loan loan);
}

class Clerk extends Approver {
  Clerk(String name) : super(name);

  @override
  processRequest(Loan loan) {
    if (loan.amount < 25000) {
      stdout.writeln('$name approved request #${loan.number}');
    } else if (successor != null) {
      successor!.processRequest(loan);
    }
  }
}

class AssistantManager extends Approver {
  AssistantManager(String name) : super(name);

  @override
  processRequest(Loan loan) {
    if (loan.amount < 45000) {
      stdout.writeln(
          '$name, our assistant manager, approved request #${loan.number}');
    } else if (successor != null) {
      successor!.processRequest(loan);
    }
  }
}

class Manager extends Approver {
  Manager(String name) : super(name);

  @override
  processRequest(Loan loan) {
    if (loan.amount < 100000) {
      stdout.writeln('$name, our manager, approved request #${loan.number}');
    } else if (successor != null) {
      successor!.processRequest(loan);
    } else {
      stdout.writeln('Request #${loan.number} requires an executive meeting!');
    }
  }
}

/// Entry point to the pattern
class ChainOfReponsibility {
  /// Execute the pattern
  static invoke() {
    stdout.writeln(
        '''The Chain of Responsibility design pattern avoids coupling the sender of
a request to its receiver by giving more than one object a chance to handle the request. 
This pattern chains the receiving objects and passes the request along 
the chain until an object handles it.
''');

    stdout.writeln('''Pros
- You control the order of request handling.
- Single Responsibility Principle - decouples invokers to operation performers classes
- Open/Closed Principle - adding handlers doesn't break client code.
\n''');

    stdout.writeln('Output of a loan approval process:\n');

    Approver clerk = Clerk('diego');
    Approver assistantManager = AssistantManager('celso');
    Approver manager = Manager('anna');

    clerk.successor = assistantManager;
    assistantManager.successor = manager;

    clerk.processRequest(Loan(23000.00, 'car loan', 1));
    clerk.processRequest(Loan(44500, 'motorcycle loan', 2));
    clerk.processRequest(Loan(99000, 'better car loan', 3));
    clerk.processRequest(Loan(156200, 'apartment loan', 4));
  }
}
