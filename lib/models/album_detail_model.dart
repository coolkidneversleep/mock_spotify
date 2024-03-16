import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/artist_model.dart';
import 'package:mockspotify/models/image_model.dart';
import 'package:mockspotify/models/track_list_model.dart';

class AlbumDetailModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final String releaseDate;
  final TrackListModel tracks;
  final List<ArtistModel> artists;
  final List<ImageModel> images;

  const AlbumDetailModel({
    required this.id,
    required this.name,
    required this.type,
    required this.releaseDate,
    required this.tracks,
    required this.images,
    required this.artists,
  });

  AlbumDetailModel copyWith({
    String? id,
    String? name,
    String? type,
    String? releaseDate,
    TrackListModel? tracks,
    List<ImageModel>? images,
    List<ArtistModel>? artists,
  }) {
    return AlbumDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      releaseDate: releaseDate ?? this.releaseDate,
      tracks: tracks ?? this.tracks,
      images: images ?? this.images,
      artists: artists ?? this.artists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'releaseDate': releaseDate,
      'tracks': tracks,
      'images': images,
      'artists': artists,
    };
  }

  factory AlbumDetailModel.fromMap(Map<String, dynamic> map) {
    return AlbumDetailModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      releaseDate: map['release_date'] ?? '',
      tracks:
          TrackListModel.fromMap(map['tracks'] ?? TrackListModel(items: [])),
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

  factory AlbumDetailModel.fromJson(String source) =>
      AlbumDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlbumDetailModel(id:$id, name: $name, type: $type, releaseDate: $releaseDate,images: $images, tracks: $tracks, artists: $artists)';
  }

  @override
  List<Object> get props =>
      [id, name, type, releaseDate, tracks, images, artists];
}
