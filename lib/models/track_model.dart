import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/artist_model.dart';

class TrackModel extends Equatable {
  final String id;
  final String uri;
  final String name;
  final int duration;
  final List<ArtistModel> artists;

  const TrackModel({
    required this.id,
    required this.uri,
    required this.name,
    required this.duration,
    required this.artists,
  });

  TrackModel copyWith({
    String? id,
    String? uri,
    String? name,
    int? duration,
    List<ArtistModel>? artists,
  }) {
    return TrackModel(
      id: id ?? this.id,
      uri: uri ?? this.uri,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      artists: artists ?? this.artists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uri': uri,
      'name': name,
      'duration': duration,
      'artists': artists,
    };
  }

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      id: map['id'] ?? '',
      uri: map['uri'] ?? '',
      name: map['name'] ?? '',
      duration: map['duration_ms'] ?? 0,
      artists: (map['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackModel.fromJson(String source) =>
      TrackModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrackModel(id:$id,uri: $uri, name: $name, duration: $duration, artists: $artists)';
  }

  @override
  List<Object> get props => [id, uri, name, duration, artists];
}
