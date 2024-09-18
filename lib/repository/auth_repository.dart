import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // Facebook Sign-In (If integrated)
  Future<User?> signInWithFacebook() async {
    // Implement Facebook login logic here
    // For example, using the Facebook SDK
    throw UnimplementedError();
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut(); // Optional: Sign out from Google
  }

  // Current User
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
