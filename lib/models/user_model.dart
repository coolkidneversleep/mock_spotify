import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockspotify/models/album_model.dart';
import 'package:mockspotify/models/artist_model.dart';
import 'package:mockspotify/models/image_model.dart';

class UserModel extends Equatable {
  final String id;
  final List<ImageModel> images;

  const UserModel({
    required this.id,
    required this.images,
  });

  UserModel copyWith({
    String? id,
    List<ImageModel>? images,
  }) {
    return UserModel(
      id: id ?? this.id,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      images: (map['images'] as List<dynamic>)
          .map((e) => ImageModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id:$id, images: $images)';
  }

  @override
  List<Object> get props => [id, images];
}
