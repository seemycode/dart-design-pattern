part of '../main.dart';

/// Interface for all commands
abstract class IoTCommand {
  execute();
}

/// Light's receiver (may call business layer)
class Light {
  on() => stdout.writeln('Light is on');
  off() => stdout.writeln('Light is off');
}

/// Light's concrete command #1
class LightOnCommand implements IoTCommand {
  Light light;
  LightOnCommand({required this.light});

  @override
  execute() => light.on();
}

/// Light's concrete command #2
class LightOffCommand implements IoTCommand {
  Light light;
  LightOffCommand({required this.light});

  @override
  execute() => light.off();
}

/// SmartTV's receiver (may call business layer)
class SmartTV {
  on() => stdout.writeln('SmartTV is on');
  off() => stdout.writeln('SmartTV is off');
  setBluetooth() => stdout.writeln('SmartTV is set to Bluetooth');
  setUSB() => stdout.writeln('SmartTV is set to USB');
  setVolume(int volume) => stdout.writeln('SmartTV volume set to $volume');
}

class SmartTVBluetoothOnCommand implements IoTCommand {
  SmartTV smartTV;
  SmartTVBluetoothOnCommand({required this.smartTV});

  @override
  execute() {
    smartTV.on();
    smartTV.setBluetooth();
    smartTV.setVolume(5);
  }
}

class SmartTVUSBOnCommand implements IoTCommand {
  SmartTV smartTV;
  SmartTVUSBOnCommand({required this.smartTV});

  @override
  execute() {
    smartTV.on();
    smartTV.setUSB();
    smartTV.setVolume(10);
  }
}

class SmartTVOffCommand implements IoTCommand {
  SmartTV smartTV;
  SmartTVOffCommand({required this.smartTV});

  @override
  execute() {
    smartTV.off();
  }
}

/// Just a optional class to capture device name
class IoTDevice {
  String name;
  IoTDevice({required this.name});
}

class RemoteControl extends IoTDevice {
  final commands = <IoTCommand>[];

  RemoteControl({required String name}) : super(name: name);

  /// Assign commands to remote control
  setAndExecute(IoTCommand command) {
    commands.add(command);
    command.execute();
  }
}

/// Invoker #2: Mobile Phone
class MobilePhoneControl extends IoTDevice {
  final commands = <IoTCommand>[];

  MobilePhoneControl({required String name}) : super(name: name);

  /// Assign commands to mobile phone control
  setAndExecute(IoTCommand command) {
    commands.add(command);
    command.execute();
  }

  undoCommand(IoTCommand command) {
    commands.removeLast().execute();
  }
}

class Command {
  static invoke() {
    stdout.writeln(
        '''The Command design pattern encapsulates a request as an object, 
thereby letting you parameterize clients with different requests,
 queue or log requests, and support undoable operations.
''');

    stdout.writeln('''Pros
- Single Responsibility Principle - decouple invokers and performers classes
- Open/Closed Principle - introduce new commands without breaking existing client code
- Can implement undo/redo
- Can implement deferred execution of operations
- Can assemble a set of simple commands into a complex one
Cons
- Code may become more complicated since a whole new layer sits between senders and receivers
\n''');

    stdout.writeln('Output of SmartDevice control system:\n');

    /// IoT invokers
    final remoteControl = RemoteControl(name: 'samsumg control');
    final mobilePhone = MobilePhoneControl(name: 'iphone 6');

    /// IoT receivers
    final bedRoomLamps = Light();
    final kitchenTV = SmartTV();

    /// Attach commands
    final lightOn = LightOnCommand(light: bedRoomLamps);
    final lightOff = LightOffCommand(light: bedRoomLamps);
    final tvOnWithBluetooth = SmartTVBluetoothOnCommand(smartTV: kitchenTV);
    final tvOnWithUSB = SmartTVBluetoothOnCommand(smartTV: kitchenTV);

    /// Run
    stdout.writeln('When you have just arrived at home...');
    remoteControl.setAndExecute(lightOn);
    remoteControl.setAndExecute(tvOnWithUSB);
    stdout.writeln(
        'and you was just shared a song while cooking and want to listen to it...');
    mobilePhone.setAndExecute(lightOff);
    mobilePhone.setAndExecute(tvOnWithBluetooth);
  }
}
