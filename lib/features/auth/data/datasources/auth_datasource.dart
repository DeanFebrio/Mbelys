import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Stream<User?> get authStateChanges;
  User? get currentUser;

  Future<User> signIn (String email, String password);
  Future<User> signUp (String email, String password, String name);
  Future<void> signOut ();

  Future<void> forgotPassword (String email);
  Future<void> changePassword (String oldPassword, String newPassword);

  Future<void> updateName ({ required String name });

  Future<void> reloadUser();
}

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthDataSource({required this.firebaseAuth});

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (cred.user == null) {
        throw FirebaseAuthException(code: 'user-not-found', message: 'Pengguna tidak ditemukan!');
      }
      return cred.user!;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<User> signUp(String email, String password, String name) async {
    try {
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
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    try {
      return firebaseAuth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
      }
      final email = user.email;
      if (email == null) {
        throw FirebaseAuthException(code: 'no-email', message: 'Akun tidak memiliki email');
      }
      final cred = EmailAuthProvider.credential(email: email, password: oldPassword);
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      return;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> updateName ({ required String name }) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
      }
      await user.updateDisplayName(name);
      return;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
      }
      await user.reload();
      return;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}