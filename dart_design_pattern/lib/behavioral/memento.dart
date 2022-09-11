part of '../main.dart';

/// This code implements the memento pattern with even stricter encapsulation
/// Find it at refactoring.guru/design-patterns/memento

/// The Originator interface
abstract class IApprovalSystem {
  ApprovalEvent approveOrder();
  void createOrder(String orderNumber);
}

/// The Originator class
class ApprovalSystem implements IApprovalSystem {
  late String _orderNumber;

  @override
  ApprovalEvent approveOrder() {
    print('Added approval $_orderNumber');
    return ApprovalEvent(this, _orderNumber);
  }

  @override
  void createOrder(String orderNumber) {
    print('Created order $orderNumber');
    _orderNumber = orderNumber;
  }
}

/// The Memento interface
abstract class IApprovalEvent {
  void restore();
}

/// The Memento class
class ApprovalEvent implements IApprovalEvent {
  late IApprovalSystem _system;
  late String _orderNumber;

  ApprovalEvent(system, orderNumber) {
    _system = system;
    _orderNumber = orderNumber;
  }

  @override
  void restore() {
    print('Restoring order...');
    _system.createOrder(_orderNumber);
  }
}

/// The Caretaker class
class ApprovalHistory {
  final approvals = <IApprovalEvent>[];

  /// Extended implementation to trace back history of [steps]
  void undo(int steps) {
    if (steps < approvals.length) {
      approvals[approvals.length - steps - 1].restore();
    }
  }
}

class Memento {
  static invoke() {
    stdout.writeln(
        '''The Memento design pattern without violating encapsulation, captures and 
externalizes an object‘s internal state so that 
the object can be restored to this state later.
''');

    stdout.writeln('''Pros
- Produces object state snapshots without breaking encapsulation
- Simple originators delegating to caretakers to keep the history
Cons
- Consume RAM when creating mementos too often
- Caretakers follow originator's life to destroy obsoletes mementos
- Some languages don't guarantee state keeping
\n''');

    stdout.writeln('Output of a Simplified Order Approval System:\n');

    IApprovalSystem system = ApprovalSystem();
    ApprovalHistory history = ApprovalHistory();

    system.createOrder('#001');
    system.createOrder('#002');
    system.createOrder('#003');
    history.approvals.add(system.approveOrder());
    system.createOrder('#004');
    system.createOrder('#005');
    history.approvals.add(system.approveOrder());
    system.createOrder('#006');

    // check results
    history.undo(0);
    history.undo(1);
  }
}
