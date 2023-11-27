import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final User? user = FirebaseAuth.instance.currentUser;

  final db = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var user = result.user;

      if (user != null) {
        var userProfile = UserProfile(
          userId: user.uid,
          email: email,
          profilePicture: user.photoURL ?? '',
        );

        saveUserToFirebase(userProfile);
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void saveUserToFirebase(UserProfile userProfile) async {
    try {
      await db
          .collection('users')
          .doc(userProfile.userId)
          .set(userProfile.toJson(), SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
