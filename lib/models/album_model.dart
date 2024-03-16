import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/artist_model.dart';
import 'package:mockspotify/models/image_model.dart';

class AlbumModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final List<ArtistModel> artists;
  final List<ImageModel> images;

  const AlbumModel({
    required this.id,
    required this.name,
    required this.type,
    required this.images,
    required this.artists,
  });

  AlbumModel copyWith({
    String? id,
    String? name,
    String? type,
    List<ImageModel>? images,
    List<ArtistModel>? artists,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      images: images ?? this.images,
      artists: artists ?? this.artists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'images': images,
      'artists': artists,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromMap(e))
              .toList() ??
          [],
      artists: (map['artists'] as List<dynamic>?)
              ?.map((e) => ArtistModel.fromMap(e))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(String source) =>
      AlbumModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlbumModel(id:$id, name: $name, type: $type,images: $images,  artists: $artists)';
  }

  @override
  List<Object> get props => [id, name, type, images, artists];
}
