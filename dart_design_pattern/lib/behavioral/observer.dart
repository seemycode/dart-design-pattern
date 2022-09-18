part of '../main.dart';

/// Subject - hold reference to all observers
abstract class AppNotification {
  final widgets = <AppWidget>[];

  void include(AppWidget widget) {
    widgets.add(widget);
  }

  void remove(AppWidget widget) {
    widgets.remove(widget);
  }

  void send() {
    for (var widget in widgets) {
      widget.update();
    }
  }
}

/// ConcreteSubject - hold subject state
class Notification extends AppNotification {
  final String from;
  final String to;
  final String content;
  Notification({
    required this.from,
    required this.to,
    required this.content,
  });
}

/// Observer - interface
abstract class AppWidget {
  void update();
}

/// ConcreteObserver - hold observer state
class Widget extends AppWidget {
  final String name;
  late Notification notification;
  Widget(this.name);

  Widget registerTo(notification) {
    print('Observer $name has been attached to ${notification.to}');
    this.notification = notification;
    return this;
  }

  @override
  void update() {
    print(
      '$name received \'${notification.content}\' from ${notification.from}',
    );
  }
}

class Observer {
  static invoke() {
    stdout.writeln('''
      The Observer design pattern defines a one-to-many dependency 
      between objects so that when one object changes state, all its
      dependents are notified and updated automatically.
      ''');

    stdout.writeln('''Pros
    - Open/Closed Principle. You can introduce new subscriber 
    classes without having to change the publisher’s code 
    (and vice versa if there’s a publisher interface).
    - You can establish relations between objects at runtime.
    ''');

    stdout.writeln('''Output of an in-app notification system:\n''');

    // Widgets
    final homeWidget = Widget('HomeWidget');
    final cartWidget = Widget('CartWidget');

    // Subjects
    final discountBanner = Notification(
      from: 'Sales list',
      to: 'qualified users',
      content: 'Special deal 10% off!',
    );
    final appUpdateWarning = Notification(
      from: 'Support list',
      to: 'all users',
      content: 'Maintenance scheduled!',
    );

    // Observers to special deal
    discountBanner.include(cartWidget.registerTo(discountBanner));
    discountBanner.send();
    print('');

    // Observers to maintenance warning
    appUpdateWarning.include(homeWidget.registerTo(appUpdateWarning));
    appUpdateWarning.include(cartWidget.registerTo(appUpdateWarning));
    appUpdateWarning.send();
    print('');

    // Detach an observer
    print('Removing CartWidget and re-sending maintenance warning...');
    appUpdateWarning.remove(cartWidget);
    appUpdateWarning.send();
  }
}
