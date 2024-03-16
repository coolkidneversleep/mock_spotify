import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/image_model.dart';
import 'package:mockspotify/models/playlist_track_list_model.dart';

class PlaylistDetailModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<ImageModel> images;
  final PlaylistTrackListModel tracks;

  const PlaylistDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.tracks,
  });

  PlaylistDetailModel copyWith({
    String? id,
    String? name,
    String? description,
    List<ImageModel>? images,
    PlaylistTrackListModel? tracks,
  }) {
    return PlaylistDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      tracks: tracks ?? this.tracks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'tracks': tracks,
    };
  }

  factory PlaylistDetailModel.fromMap(Map<String, dynamic> map) {
    return PlaylistDetailModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: (map['images'] is List)
          ? (map['images'] as List<dynamic>)
              .map((e) => ImageModel.fromMap(e))
              .toList()
          : [], // Return an empty list if 'images' is not a List
      tracks: PlaylistTrackListModel.fromMap(
          map['tracks'] ?? const PlaylistTrackListModel(items: [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistDetailModel.fromJson(String source) =>
      PlaylistDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaylistDetailModel(id:$id, name: $name, description: $description, images: $images, tracks: $tracks)';
  }

  @override
  List<Object> get props => [id, name, description, images, tracks];
}
