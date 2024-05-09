// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  int? id;
  final String nmTempat;
  final String alamat;
  final String gambar;

  Kuliner({
    required this.id,
    required this.nmTempat,
    required this.alamat,
    required this.gambar,
  });

  Kuliner copyWith({
    int? id,
    String? nmTempat,
    String? alamat,
    String? gambar,
  }) {
    return Kuliner(
      id: id ?? this.id,
      nmTempat: nmTempat ?? this.nmTempat,
      alamat: alamat ?? this.alamat,
      gambar: gambar ?? this.gambar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nmTempat': nmTempat,
      'alamat': alamat,
      'gambar': gambar,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      id: map['id'] != null ? map['id'] as int : null,
      nmTempat: map['nmTempat'] as String,
      alamat: map['alamat'] as String,
      gambar: map['gambar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(id: $id, nmTempat: $nmTempat, alamat: $alamat, gambar: $gambar)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nmTempat == nmTempat &&
      other.alamat == alamat &&
      other.gambar == gambar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nmTempat.hashCode ^
      alamat.hashCode ^
      gambar.hashCode;
  }
}
