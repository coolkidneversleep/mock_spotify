import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/album_model.dart';
import 'package:mockspotify/models/artist_model.dart';
import 'package:mockspotify/models/image_model.dart';

class PlaylistModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<ImageModel> images;

  const PlaylistModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
  });

  PlaylistModel copyWith({
    String? id,
    String? name,
    String? description,
    List<ImageModel>? images,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: (map['images'] as List<dynamic>)
          .map((e) => ImageModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) =>
      PlaylistModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaylistModel(id:$id, name: $name, description: $description, images: $images)';
  }

  @override
  List<Object> get props => [id, name, description, images];
}
