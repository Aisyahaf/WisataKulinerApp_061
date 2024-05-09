// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  final String nmTempat;
  final String alamat;
  final String gambar;

  Kuliner({
    required this.nmTempat,
    required this.alamat,
    required this.gambar,
  });

  Kuliner copyWith({
    String? nmTempat,
    String? alamat,
    String? gambar,
  }) {
    return Kuliner(
      nmTempat: nmTempat ?? this.nmTempat,
      alamat: alamat ?? this.alamat,
      gambar: gambar ?? this.gambar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nmTempat': nmTempat,
      'alamat': alamat,
      'gambar': gambar,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      nmTempat: map['nmTempat'] as String,
      alamat: map['alamat'] as String,
      gambar: map['gambar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Kuliner(nmTempat: $nmTempat, alamat: $alamat, gambar: $gambar)';

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;

    return other.nmTempat == nmTempat &&
        other.alamat == alamat &&
        other.gambar == gambar;
  }

  @override
  int get hashCode => nmTempat.hashCode ^ alamat.hashCode ^ gambar.hashCode;
}
