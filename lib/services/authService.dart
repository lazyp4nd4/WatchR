import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential result;

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User user = userCredential.user;
        bool ans = false;
        if (user.phoneNumber == null) {
          ans = await DatabaseServices(user.uid)
              .createUser(user.displayName, "Not Found");
        } else {
          ans = await DatabaseServices(user.uid)
              .createUser(user.displayName, user.phoneNumber);
        }
        if (ans == true) return true;
        return false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          return e;
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          return e;
        }
      } catch (e) {
        // handle the error here
        return e;
      }
    }

    return true;
  }

  Future<dynamic> registerWithEmail(email, password, name, phoneNumber) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      bool res = await DatabaseServices(userCredential.user.uid)
          .createUser(name, phoneNumber);
      if (res == true) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        String res = 'The password provided is too weak.';
        return res;
      } else if (e.code == 'email-already-in-use') {
        String res = 'The account already exists for that email.';
        return res;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> signInWithEmail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user.uid);

      String name, phoneNumber;

      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userCredential.user.uid)
          .get()
          .then((value) {
        name = value["name"];
        phoneNumber = value["phoneNumber"];
      });

      print(name);
      print(phoneNumber);

      bool ans1 = await SharedFunctions.saveUserName(name);
      bool ans2 = await SharedFunctions.saveUserPN(phoneNumber);
      bool ans3 = await SharedFunctions.saveUserUid(userCredential.user.uid);

      return (ans1 && ans2 && ans3);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        String res = 'The password provided is incorrect. Please try again!';
        return res;
      } else if (e.code == 'user-not-found') {
        String res = 'No account exists for this email.';
        return res;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  signOutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await _auth.signOut();
  }
}
