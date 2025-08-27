import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/services/service_locator.dart';

abstract class AuthDataSource {
  Stream<User?> get authStateChanges;
  User? get currentUser;

  Future<User> signIn (String email, String password);
  Future<User> signUp (String email, String password, String name);
  Future<void> signOut ();

  Future<void> forgotPassword (String email);
  Future<void> changePassword (String oldPassword, String newPassword);
  Future<void> changeEmail (String email);

  Future<void> reloadUser();
}

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth firebaseAuth = sl<FirebaseAuth>();

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<User> signIn(String email, String password) async {
    final cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    if (cred.user == null) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'Pengguna tidak ditemukan!');
    }
    return cred.user!;
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<User> signUp(String email, String password, String name) async {
    final account = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    final user = account.user;
    if (user == null) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'Gagal membuat akun!');
    }
    await user.updateDisplayName(name);
    return user;
  }

  @override
  Future<void> changeEmail(String email) async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }
    await user.verifyBeforeUpdateEmail(email);
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengugna belum masuk');
    }
    final email = user.email;
    if (email == null) {
      throw FirebaseAuthException(code: 'no-email', message: 'Akun tidak memiliki email');
    }
    final cred = EmailAuthProvider.credential(email: email, password: oldPassword);
    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> forgotPassword(String email) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> reloadUser() async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }
    await user.reload();
  }
}