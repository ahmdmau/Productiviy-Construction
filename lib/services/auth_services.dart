part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SigninSignupResult> signUp(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = result.user.convertToUser(name: name);
      await UserServices.updateUser(userModel);
      return SigninSignupResult(user: userModel);
    } catch (e) {
      return SigninSignupResult(message: e.toString());
    }
  }

  static Future<SigninSignupResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserModel user = await result.user.fromFirestore();
      return SigninSignupResult(user: user);
    } on FirebaseAuthException catch (e) {
      return SigninSignupResult(message: e.message);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User> get userStream => _auth.authStateChanges();
}

class SigninSignupResult {
  UserModel user;
  String message;

  SigninSignupResult({this.user, this.message});
}
