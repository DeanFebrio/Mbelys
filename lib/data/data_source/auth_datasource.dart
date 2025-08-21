import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/data/models/user_model.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserModel> signIn({
    required String email,
    required String password
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      if (userCredential.user == null){
        throw FirebaseAuthException(
            code: 'user-not-found',
            message: 'User tidak ditemukan!'
        );
      }

      final String uid = userCredential.user!.uid;
      final DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return UserModel.fromFirebase(snapshot);
      } else {
        throw Exception("Data User tidak ditemukan!");
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan tidak terduga saat login: $e");
    }
  }

  Future<UserModel> signUp ({
    required String email,
    required String password,
    required String name,
    required String phone
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
      final userData = {
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp()
      };
      await firestore.collection('users').doc(userCredential.user!.uid).set(userData);

      return UserModel(
          uid: user.uid,
          name: name,
          email: email,
          phone: phone
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat register: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData (String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) return doc.data();
    return null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword ({
    required String email
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateName ({
    required String name
  }) async {
    await currentUser!.updateDisplayName(name);
  }

  Future<void> deleteAccount ({
    required String email,
    required String password
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: email, password: password
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: email, password: oldPassword
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}