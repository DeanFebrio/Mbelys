import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/core/error/failure.dart';

Failure mapFirebaseStorageError(FirebaseException e) {
  switch (e.code) {
    case 'unauthorized':
      return const PermissionFailure("Anda tidak memiliki izin untuk mengakses file ini.");
    case 'user-not-found':
      return const AuthFailure("Pengguna tidak ditemukan.");
    case 'object-not-found':
      return const NotFoundFailure("File tidak ditemukan.");
    case 'canceled':
      return const NetworkFailure("Upload/download dibatalkan.");
    case 'retry-limit-exceeded':
      return const NetworkFailure("Batas percobaan ulang terlampaui. Cek koneksi internet.");
    case 'cannot-slice-blob':
      return const NetworkFailure("Terjadi kesalahan saat memproses file.");
    case 'quota-exceeded':
      return const ResourceExhaustedFailure("Kuota penyimpanan telah penuh.");
    case 'download-limit-exceeded':
      return const ResourceExhaustedFailure("Batas download telah terlampaui.");
    case 'file-too-large':
      return const ValidationFailure("File terlalu besar. Ukuran maksimal 10MB.");
    case 'invalid-argument':
      return const ValidationFailure("Format file tidak valid.");
    case 'invalid-format':
      return const ValidationFailure("Format file tidak didukung.");
    case 'internal-error':
      return const ServerFailure("Terjadi kesalahan internal server.");
    case 'server-file-wrong-size':
      return const ServerFailure("File korup atau rusak.");
    default:
      return StorageFailure(
        "Terjadi kesalahan saat mengupload file: ${e.message}",
        code: e.code,
        cause: e,
      );
  }
}