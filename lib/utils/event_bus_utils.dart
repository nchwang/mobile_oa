import 'package:event_bus/event_bus.dart';

class Global {
  static EventBus eventBus = new EventBus();
}

class LoginEvent {
  String text;

  LoginEvent(this.text);
}

class LoginEventName {
  static const String login = 'login';
}
