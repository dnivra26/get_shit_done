import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  GoogleSignInAccount currentUser = _googleSignIn.currentUser;
  if (currentUser == null) {
    currentUser = await _googleSignIn.signInSilently();
  }
  if (currentUser == null) {
    currentUser = await _googleSignIn.signIn();
  }

  final GoogleSignInAuthentication auth = await currentUser.authentication;

  final FirebaseUser user = await _auth.signInWithGoogle(
    idToken: auth.idToken,
    accessToken: auth.accessToken,
  );

  assert(user != null);
  assert(!user.isAnonymous);

  return user;
}
