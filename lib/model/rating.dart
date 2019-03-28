import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  final int max;
  final int min;
  final double average;
  final String stars;

  Rating(this.max, this.min, this.average, this.stars);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
