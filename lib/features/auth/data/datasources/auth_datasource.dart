import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Stream<User?> get authStateChanges;
  User? get currentUser;

  Future<User> signIn (String email, String password);
  Future<User> signUp (String email, String password, String name);
  Future<void> signOut ();

  Future<void> forgotPassword (String email);
  Future<void> changePassword (String oldPassword, String newPassword);

  Future<void> beginEmailChange ({ required String newEmail });
  Future<String?> finalizeEmailChange();

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
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
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
  }

  @override
  Future<void> forgotPassword(String email) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> beginEmailChange ({ required String newEmail }) async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }

    Future<void> _send() => user.verifyBeforeUpdateEmail(newEmail);

    try {
      await _send();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        final providers = user.providerData.map((p) => p.providerId).toList();

        if (providers.contains('google.com')) {
          await user.reauthenticateWithProvider(GoogleAuthProvider());
          await _send();
          return;
        }

        if (providers.contains('facebook.com')) {
          await user.reauthenticateWithProvider(FacebookAuthProvider());
          await _send();
          return;
        }
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<String?> finalizeEmailChange () async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }
    await user.reload();
    return user.email;
  }

  @override
  Future<void> updateName ({ required String name }) async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }
    await user.updateDisplayName(name);
    return;
  }

  @override
  Future<void> reloadUser() async {
    final user = currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'Pengguna belum masuk');
    }
    await user.reload();
    return;
  }
}