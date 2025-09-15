import 'package:mbelys/core/error/failure.dart';

extension FailureMessageExtensions on Failure {
  String toUserMessage() {
    return switch (this) {
      ValidationFailure() => message,
      UnknownFailure() => "Terjadi kesalahan yang tidak terduga. Coba lagi nanti.",
      AuthFailure() => "Sesi Anda telah berakhir. Silakan login ulang.",
      ServerFailure() => "Terjadi kesalahan pada server. Silakan coba lagi nanti.",
      StorageFailure() => "Gagal mengupload gambar. Pastikan file valid dan coba lagi.",
      NotFoundFailure() => "Data kandang tidak ditemukan.",
      DatabaseFailure() => "Gagal menyimpan perubahan data.",
      PermissionFailure() => "Anda tidak memiliki izin untuk melakukan perubahan ini.",
      TimeoutFailure() => "Waktu permintaan habis. Silakan coba lagi.",
      _ => message,
    };
  }
}