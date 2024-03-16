import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/track_model.dart';

class PlaylistTrackModel extends Equatable {
  final TrackModel track;

  const PlaylistTrackModel({
    required this.track,
  });

  PlaylistTrackModel copyWith({
    TrackModel? track,
  }) {
    return PlaylistTrackModel(
      track: track ?? this.track,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'track': track,
    };
  }

  factory PlaylistTrackModel.fromMap(Map<String, dynamic> map) {
    return PlaylistTrackModel(
      track: TrackModel.fromMap(map['track'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistTrackModel.fromJson(String source) =>
      PlaylistTrackModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaylistTrackModel(track:$track)';
  }

  @override
  List<Object> get props => [track];
}
