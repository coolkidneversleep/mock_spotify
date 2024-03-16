import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/track_model.dart';

class TrackListModel extends Equatable {
  final List<TrackModel> items;

  const TrackListModel({
    required this.items,
  });

  TrackListModel copyWith({
    List<TrackModel>? items,
  }) {
    return TrackListModel(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory TrackListModel.fromMap(Map<String, dynamic> map) {
    return TrackListModel(
      items: (map['items'] as List<dynamic>)
          .map((e) => TrackModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackListModel.fromJson(String source) =>
      TrackListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrackListModel(items:$items)';
  }

  @override
  List<Object> get props => [items];
}
