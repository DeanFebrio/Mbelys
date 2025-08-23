import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;

  const AuthDataSource({required this.firebaseAuth});

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<User> signIn({
    required String email,
    required String password
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'User tidak ditemukan!'
        );
      }
      return user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan tidak terduga saat login: $e");
    }
  }

  Future<User> signUp ({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = userCredential.user;

      if (user == null){
        throw FirebaseAuthException(
            code: 'user-creation-failed',
            message: 'Gagal membuat akun!'
        );
      }
      await userCredential.user!.updateDisplayName(name);
      return user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat register: $e');
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword ({
    required String email
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}