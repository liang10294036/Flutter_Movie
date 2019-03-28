// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(json['max'] as int, json['min'] as int,
      (json['average'] as num)?.toDouble(), json['stars'] as String);
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
      'average': instance.average,
      'stars': instance.stars
    };
