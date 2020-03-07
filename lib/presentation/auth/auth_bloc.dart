import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebase/presentation/auth/auth_base.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class AuthBloc implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController texPassword = TextEditingController();

  StreamController _streamLoginMessage = StreamController<String>.broadcast();

  StreamController _streamUser = StreamController<FirebaseUser>.broadcast();

  Function(String) get _sinkLoginMessage => _streamLoginMessage.sink.add;

  Function(FirebaseUser) get _sinkUser => _streamUser.sink.add;

  Stream<String> get loginMessage => _streamLoginMessage.stream;

  Stream<FirebaseUser> get currentUser => _streamUser.stream;

  @override
  void dispose() {
    _streamUser.close();
    _streamLoginMessage.close();
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() {
    // TODO: implement isEmailVerified
    return null;
  }

  @override
  void sendEmailVerification() {
    // TODO: implement sendEmailVerification
  }

  @override
  Future<void> signIn() async {
    Future<AuthResult> result = _firebaseAuth.signInWithEmailAndPassword(
        email: tecEmail.text, password: texPassword.text);

    await result.then((AuthResult result) => _sinkUser(result.user)).catchError((e) {
      authProblems errorType;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = authProblems.UserNotFound;
            break;
          case 'Error 17009':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = authProblems.NetworkError;
            break;
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      _sinkLoginMessage(errorType.toString());
    });
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }

  @override
  Future<String> signUp() async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: tecEmail.text, password: texPassword.text);
    FirebaseUser user = result.user;
    return user.uid;
  }
}
