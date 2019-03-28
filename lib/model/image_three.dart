import 'package:json_annotation/json_annotation.dart';

part 'image_three.g.dart';

@JsonSerializable()
class ImageThree {
  // 图片

  final String small;
  final String large;
  final String medium;

  ImageThree(this.small, this.large, this.medium);

  factory ImageThree.fromJson(Map<String, dynamic> json) => _$ImageThreeFromJson(json);


}