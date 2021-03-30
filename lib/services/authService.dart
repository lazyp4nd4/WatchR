import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential result;

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        print("Error - 1");
        return false;
      } else {
        result = await _auth.signInWithCredential(GoogleAuthProvider.credential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken));
      }
      if (result.user == null) {
        print("Error - 2");
        return false;
      } else {
        User user = result.user;
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
      }
    } catch (error) {
      print("Error - 3");
      return false;
    }
  }

  Future<bool> registerWithEmail(email, password, name, phoneNumber) async {
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
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signInWithEmail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String name, phoneNumber;

      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userCredential.user.uid)
          .get()
          .then((value) {
        name = value["name"];
        phoneNumber = value["phoneNumber"];
      });

      bool ans1 = await SharedFunctions.saveUserName(name);
      bool ans2 = await SharedFunctions.saveUserPN(phoneNumber);
      bool ans3 = await SharedFunctions.saveUserUid(userCredential.user.uid);

      return (ans1 && ans2 && ans3);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
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
