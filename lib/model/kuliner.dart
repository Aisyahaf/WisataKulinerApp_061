// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  final String id;
  final String nmTempat;
  final String menu;
  final String note;
  final String alamat;

  Kuliner({
    required this.id,
    required this.nmTempat,
    required this.menu,
    required this.note,
    required this.alamat,
  });

  Kuliner copyWith({
    String? id,
    String? nmTempat,
    String? menu,
    String? note,
    String? alamat,
  }) {
    return Kuliner(
      id: id ?? this.id,
      nmTempat: nmTempat ?? this.nmTempat,
      menu: menu ?? this.menu,
      note: note ?? this.note,
      alamat: alamat ?? this.alamat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nmTempat': nmTempat,
      'menu': menu,
      'note': note,
      'alamat': alamat,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      id: map['id'] as String,
      nmTempat: map['nmTempat'] as String,
      menu: map['menu'] as String,
      note: map['note'] as String,
      alamat: map['alamat'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(id: $id, nmTempat: $nmTempat, menu: $menu, note: $note, alamat: $alamat)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nmTempat == nmTempat &&
      other.menu == menu &&
      other.note == note &&
      other.alamat == alamat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nmTempat.hashCode ^
      menu.hashCode ^
      note.hashCode ^
      alamat.hashCode;
  }
}
