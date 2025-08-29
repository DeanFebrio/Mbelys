import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/error/failure.dart';

Failure mapFirebaseAuthError (FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-credential':
      return const AuthFailure("Email belum terdaftar", code:'wrong-password');
    case 'wrong-password':
      return const AuthFailure("Email atau Password salah", code:'wrong-password');
    case 'user-not-found':
      return const AuthFailure("Akun tidak ditemukan", code: 'user-not-found');
    case 'email-already-in-use':
      return const AuthFailure("Email telah terdaftar", code: 'email-already-in-use');
    case 'invalid-email':
      return const AuthFailure("Format email tidak valid", code: 'invalid-email');
    case 'weak-password':
      return const AuthFailure("Password terlalu lemah", code: 'weak-password');
    case 'requires-recent-login':
      return const AuthFailure('Silahkan login ulang lalu coba lagi', code: 'requires-recent-login');
    case 'too-many-requests':
      return const AuthFailure('Terlalu banyak percobaan', code: 'too-many-requests');
    case 'network-request-failed':
      return const NetworkFailure('Tidak ada koneksi internet', code: 'network-request-failed');
    default:
      return UnknownFailure("Autentikasi gagal", code: e.code, cause: e);
  }
}