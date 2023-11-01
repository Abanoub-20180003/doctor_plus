import 'package:firebase_auth/firebase_auth.dart';
import '../Model/doctor.dart';
import '../Controller/db_constants.dart';

class Authentication {
  Future<UserCredential> signInEmail(String email, String pass) async {
    UserCredential userCredential =
        await dbConstants.auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return userCredential;
  }

  Future<UserCredential> signUpWithEmail(String email, String pass) async {
    UserCredential userCredential =
        await dbConstants.auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return userCredential;
  }

  // Future<User> signUpWithEmail(String email, String pass) async {
  //   try {
  //     UserCredential userCredential =
  //         await dbConstants.auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: pass,
  //     );
  //     final User user = userCredential.user!;
  //     //return userCredential.user!;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print("the password is weak");
  //     } else if (e.code == 'email-already-in-use') {
  //       print('the account already exists for this email');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
