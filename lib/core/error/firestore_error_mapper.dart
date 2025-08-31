import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/failure.dart';

Failure mapFirestoreError(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
      return const ServerFailure("Anda tidak memiliki izin untuk melakukan aksi ini.");
    case 'not-found':
      return const NotFoundFailure("Data yang Anda cari tidak ditemukan.");
    case 'unavailable':
      return const NetworkFailure("Layanan tidak tersedia. Cek koneksi internet Anda.");
    case 'cancelled':
      return const ServerFailure("Operasi dibatalkan oleh pengguna.");
    case 'resource-exhausted':
      return const ServerFailure("Penyimpanan penuh atau kuota terlampaui.");
    case 'internal':
      return const ServerFailure("Terjadi kesalahan internal pada server. Coba lagi nanti.");
    default:
      return UnknownFailure("Terjadi kesalahan yang tidak diketahui.", code: e.code, cause: e);
  }
}