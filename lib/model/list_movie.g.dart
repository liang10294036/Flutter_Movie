// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMovie _$ListMovieFromJson(Map<String, dynamic> json) {
  return ListMovie(
      json['count'] as int,
      json['start'] as int,
      json['total'] as int,
      json['title'] as String,
      (json['subjects'] as List)
          ?.map((e) =>
              e == null ? null : MovieInfo.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ListMovieToJson(ListMovie instance) => <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
      'subjects': instance.subjects,
      'title': instance.title
    };
