import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/utils/base/BaseBloc.dart';

abstract class AuthBase extends BaseBloc{
  void signIn();

  Future<String> signUp();

  Future<FirebaseUser> getCurrentUser();

  void sendEmailVerification();

  void signOut();

  Future<bool> isEmailVerified();
}
