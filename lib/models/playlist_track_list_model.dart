import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/playlist_track_model.dart';

class PlaylistTrackListModel extends Equatable {
  final List<PlaylistTrackModel> items;

  const PlaylistTrackListModel({
    required this.items,
  });

  PlaylistTrackListModel copyWith({
    List<PlaylistTrackModel>? items,
  }) {
    return PlaylistTrackListModel(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory PlaylistTrackListModel.fromMap(Map<String, dynamic> map) {
    return PlaylistTrackListModel(
      items: (map['items'] as List<dynamic>)
          .map((e) => PlaylistTrackModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistTrackListModel.fromJson(String source) =>
      PlaylistTrackListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaylistTrackListModel(items:$items)';
  }

  @override
  List<Object> get props => [items];
}
