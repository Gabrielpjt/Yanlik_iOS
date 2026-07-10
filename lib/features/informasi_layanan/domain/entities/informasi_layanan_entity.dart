import 'package:equatable/equatable.dart';

class InformasiLayananEntity extends Equatable {
  final int id;
  final String judul;
  final String deskripsi;
  final String? imageUrl;
  final String? thumbnailUrl;
  final int kategoriInformasiLayananId;
  final String? kategoriInformasiLayananNama;
  final int dibuatOleh;
  final String? dibuatOlehNama;
  final int? diubahOleh;
  final String? diubahOlehNama;
  final int editor;
  final String? editorNama;
  final DateTime? dibuatPada;
  final DateTime? diubahPada;

  const InformasiLayananEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.imageUrl,
    this.thumbnailUrl,
    required this.kategoriInformasiLayananId,
    this.kategoriInformasiLayananNama,
    required this.dibuatOleh,
    this.dibuatOlehNama,
    this.diubahOleh,
    this.diubahOlehNama,
    required this.editor,
    this.editorNama,
    this.dibuatPada,
    this.diubahPada,
  });

  @override
  List<Object?> get props => [
    id,
    judul,
    deskripsi,
    imageUrl,
    thumbnailUrl,
    kategoriInformasiLayananId,
    kategoriInformasiLayananNama,
    dibuatOleh,
    dibuatOlehNama,
    diubahOleh,
    diubahOlehNama,
    editor,
    editorNama,
    dibuatPada,
    diubahPada,
  ];
}