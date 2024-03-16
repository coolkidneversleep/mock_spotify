import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/image_model.dart';

class ArtistModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final List<ImageModel> images;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.type,
    required this.images,
  });

  ArtistModel copyWith({
    String? id,
    String? name,
    String? type,
    List<ImageModel>? images,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'images': images,
    };
  }

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromMap(e))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistModel.fromJson(String source) =>
      ArtistModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArtistModel(id:$id,name: $name, type: $type, images: $images)';
  }

  @override
  List<Object> get props => [id, name, type, images];
}
