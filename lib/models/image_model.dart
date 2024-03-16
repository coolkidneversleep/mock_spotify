import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String url;
  final int width;
  final int height;

  const ImageModel({
    required this.url,
    required this.width,
    required this.height,
  });
  ImageModel copyWith({
    String? url,
    int? width,
    int? height,
  }) {
    return ImageModel(
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['url'] ?? '',
      width: map['width']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageModel(url: $url, width: $width, height: $height,)';
  }

  @override
  List<Object> get props => [url, width, height];
}
