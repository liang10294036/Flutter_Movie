// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) {
  return MovieInfo(
      json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      (json['genres'] as List)?.map((e) => e as String)?.toList(),
      json['title'] as String,
      (json['casts'] as List)
          ?.map((e) =>
              e == null ? null : Person.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['durations'] as List)?.map((e) => e as String)?.toList(),
      json['collect_count'] as int,
      json['mainland_pubdate'] as String,
      json['year'] as String,
      json['has_video'] as bool,
      json['original_title'] as String,
      json['subtype'] as String,
      (json['pubdates'] as List)?.map((e) => e as String)?.toList(),
      (json['directors'] as List)
          ?.map((e) =>
              e == null ? null : Person.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['images'] == null
          ? null
          : ImageThree.fromJson(json['images'] as Map<String, dynamic>),
      json['alt'] as String,
      json['summary'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) => <String, dynamic>{
      'rating': instance.rating,
      'genres': instance.genres,
      'title': instance.title,
      'casts': instance.casts,
      'durations': instance.durations,
      'collect_count': instance.collect_count,
      'mainland_pubdate': instance.mainland_pubdate,
      'year': instance.year,
      'has_video': instance.has_video,
      'original_title': instance.original_title,
      'subtype': instance.subtype,
      'pubdates': instance.pubdates,
      'directors': instance.directors,
      'images': instance.images,
      'alt': instance.alt,
      'summary': instance.summary,
      'id': instance.id
    };
