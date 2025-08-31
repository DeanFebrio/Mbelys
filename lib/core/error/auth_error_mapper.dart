import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/error/failure.dart';

Failure mapFirebaseAuthError (FirebaseAuthException e) {
  switch (e.code) {
    case 'wrong-password':
    case 'invalid-credential':
      return const AuthFailure("Email atau Password salah");
    case 'user-not-found':
      return const AuthFailure("Akun tidak ditemukan");
    case 'user-disabled':
      return const AuthFailure("Akun ini telah dinonaktifkan");
    case 'email-already-in-use':
      return const AuthFailure("Email telah terdaftar");
    case 'invalid-email':
      return const AuthFailure("Format email tidak valid");
    case 'weak-password':
      return const AuthFailure("Password terlalu lemah");
    case 'requires-recent-login':
      return const AuthFailure('Sesi Anda telah berakhir. Silakan login ulang lalu coba lagi');
    case 'too-many-requests':
      return const AuthFailure('Terlalu banyak percobaan, coba lagi nanti');
    case 'network-request-failed':
      return const NetworkFailure('Tidak ada koneksi internet');
    case 'invalid-action-code':
      return const AuthFailure('Link verifikasi tidak valid atau telah kedaluwarsa');
    case 'operation-not-allowed':
      return const AuthFailure('Metode login ini tidak diizinkan');
    case 'account-exists-with-different-credential':
      return const AuthFailure('Akun sudah ada dengan metode login yang berbeda');
    default:
      return UnknownFailure("Terjadi kesalahan. Coba lagi.", code: e.code, cause: e);
  }
}