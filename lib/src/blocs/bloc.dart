import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final _emailContoller = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Add data to sink
  Function(String) get changeEmail => _emailContoller.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Add data to stream
  Stream<String> get emailStream =>
      _emailContoller.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  submit() {
    final validEmail = _emailContoller.value;
    final validPassword = _passwordController.value;

    print('$validEmail and $validPassword');
  }

  dispose() {
    _emailContoller.close();
    _passwordController.close();
  }
}
