import 'dart:io';
import 'package:equatable/equatable.dart';

sealed class MerchantPhoto extends Equatable {
  const MerchantPhoto();
}

final class MerchantPhotoFile extends MerchantPhoto {
  const MerchantPhotoFile(this.file);

  final File file;

  @override
  List<Object?> get props => [file.path];
}

final class MerchantPhotoUrl extends MerchantPhoto {
  const MerchantPhotoUrl(this.url);

  final String url;

  @override
  List<Object?> get props => [url];
}
