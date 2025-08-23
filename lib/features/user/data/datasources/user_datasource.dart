
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/features/auth/data/models/user_model.dart';

class UserDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  const UserDataSource({
    required this.firestore,
    required this.auth
  });

  User? get currentUser => auth.currentUser;

  Future<UserModel> syncOnRegister ({
    required String uid,
    required String email,
    required String name,
    required String phone,
  }) async {
    final docRef = firestore.collection("users").doc(uid);
    final snap = await docRef.get();

    final now = FieldValue.serverTimestamp();

    final userData = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': now,
      'updatedAt': now
    };

    if (!snap.exists) {
      await docRef.set(userData);
    } else {
      await docRef.update({
        'email': email,
        'name': name,
        'phone': phone,
        'updatedAt': now
      });
    }
    final fresh = await docRef.get();
    return UserModel.fromFirebase(fresh);
  }

  Future<UserModel?> getUserData (String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) return UserModel.fromFirebase(doc);
    return null;
  }

  Future<void> updateName (String name) async {
    try {
      final user = currentUser;
      if (user == null) throw FirebaseAuthException(code: 'no-user', message: 'User tidak login');
      await user.updateDisplayName(name);
      await firestore.collection("users").doc(user.uid).update({
        'name': name,
        'updatedAt': FieldValue.serverTimestamp()
      });
      await user.reload();
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan saat update nama: $e");
    }
  }

  Future<void> updatePhone (String phone) async {
    try {
      final user = currentUser;
      if (user == null) throw FirebaseAuthException(code: 'no-user', message: 'User tidak login');
      await firestore.collection("users").doc(user.uid).update({
        'phone': phone,
        'updatedAt': FieldValue.serverTimestamp()
      });
      await user.reload();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan saat update nomor telepon: $e");
    }
  }

  Future<void> requestUpdateEmail (String newEmail) async {
    try {
      final user = currentUser;
      if (user == null) throw FirebaseAuthException(code: 'no-user', message: 'User tidak login');
      await user.verifyBeforeUpdateEmail(newEmail);
      await firestore.collection("users").doc(user.uid).set({
        'pendingEmail': newEmail,
        'emailChangeStatus': 'Menunggu Verifikasi',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan saat update email: $e");
    }
  }

  Future<bool> finalizeEmailChange () async {
    try {
      await currentUser?.reload();
      final user = currentUser;
      if (user == null) throw FirebaseAuthException(code: 'no-user', message: 'User tidak login');

      final docRef = firestore.collection("users").doc(user.uid);
      final snap = await docRef.get();
      final pendingEmail = (snap.data() ?? const {})['pendingEmail'] as String?;

      if (pendingEmail == null) return false;

      if (user.email == pendingEmail) {
        await docRef.update({
          'email': pendingEmail,
          'pendingEmail': FieldValue.delete(),
          'emailChangeStatus': FieldValue.delete(),
          'updatedAt': FieldValue.serverTimestamp()
        });
        return true;
      }
      return false;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      throw Exception("Terjadi kesalahan saat sinkron email: $e");
    }
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
    await auth.signOut();
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