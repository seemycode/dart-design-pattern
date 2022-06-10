part of '../main.dart';

abstract class Dialog {
  notify(Component sender, {required String content});
}

class AuthenticationDialog implements Dialog {
  late Field title;
  late Field userName;
  late Field password;
  late Field validationMessage;
  late Button logInButton;

  AuthenticationDialog() {
    // initial components state
    title = Field(this, 'title', content: 'Welcome!');
    userName = Field(this, 'userName');
    password = Field(this, 'password');
    validationMessage = Field(this, 'validationMessage');
    logInButton = Button(this, 'logInButton');

    printAll(title, userName, password, validationMessage, logInButton);
  }

  @override
  notify(Component sender, {required String content}) {
    // update
    userName.content = sender.name == 'userName' ? content : userName.content;
    password.content = sender.name == 'password' ? content : password.content;

    // Field cleared up
    if (content.isEmpty) {
      // propagate
      if (userName.content.isEmpty && password.content.isEmpty) {
        title.content = 'Welcome!';
        validationMessage.content = '';
        logInButton.state = 'disabled';
      } else {
        title.content = 'You\'re about to get in...';
        validationMessage.content = 'Fill out all fields!';
        logInButton.state = 'disabled';
      }
    }

    // Field filled out
    else {
      // propagate
      if (userName.content.isEmpty || password.content.isEmpty) {
        title.content = 'You\'re about to get in...';
        validationMessage.content = 'Fill out all fields!';
        logInButton.state = 'disabled';
      } else {
        title.content = 'Alright! Tap on log in...';
        validationMessage.content = '';
        logInButton.state = 'enabled';
      }
    }

    printAll(title, userName, password, validationMessage, logInButton);
  }
}

class Component {
  String name;
  Dialog dialog;
  Component(this.dialog, this.name);

  onChange(String content) => dialog.notify(this, content: content);
}

class Field extends Component {
  String content;
  Field(super.dialog, super.name, {this.content = ''});
}

class Button extends Component {
  String state;
  Button(super.dialog, super.name, {this.state = 'disabled'});
}

class Mediator {
  static invoke() {
    stdout.writeln(
        '''The Mediator design pattern defines an object that encapsulates 
how a set of objects interact. Mediator promotes loose coupling 
by keeping objects from referring to each other explicitly, and it 
lets you vary their interaction independently.
''');

    stdout.writeln('''Pros
- SRP: segmented communication makes it easy to comprehend and maintain
- OCP: can introduce new mediators without changing existing components
- reduce coupling between components
- reuse individual components easily

Cons
- mediator can quickly evolve to a God Object
\n''');

    stdout.writeln('Output of a log in screen behaviour:\n');

    // Initial state
    print('Initial state');
    final dialog = AuthenticationDialog();

    // Filled out user name
    print('Filled out user name');
    dialog.userName.onChange('Maria');

    // and the password
    print('and the password');
    dialog.password.onChange('9#33GY*3');
  }
}

void printAll(title, userName, password, validationMessage, logInButton) {
  print('- title: ${title.content} \n'
      '- userName: ${userName.content} \n'
      '- password: ${password.content} \n'
      '- validationMessage: ${validationMessage.content} \n'
      '- logInButton: ${logInButton.state} \n\n');
}
