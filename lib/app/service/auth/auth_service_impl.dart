import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_timer_dw/app/core/exceptions/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> signInGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
