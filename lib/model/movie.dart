import 'package:flutter_movie/model/image_three.dart';
import 'package:flutter_movie/model/person.dart';
import 'package:flutter_movie/model/rating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class MovieInfo {

  final Rating rating;

  final List<String> genres; //分类

  final String title;

  final List<Person> casts; //演员

  final List<String> durations; // 时长

  final int collect_count; //收藏

  final String mainland_pubdate; //上映日期

  final String year; //年份

  final bool has_video;

  final String original_title;

  final String subtype;

  final List<String> pubdates; // 地区

  final List<Person> directors; //导演

  final ImageThree images;

  @JsonKey(nullable: false)
  final String alt; // 豆瓣详情

  final String id;

  MovieInfo(
      this.rating,
      this.genres,
      this.title,
      this.casts,
      this.durations,
      this.collect_count,
      this.mainland_pubdate,
      this.year,
      this.has_video,
      this.original_title,
      this.subtype,
      this.pubdates,
      this.directors,
      this.images,
      this.alt,
      this.id);

  factory MovieInfo.fromJson(Map<String, dynamic> json) => _$MovieInfoFromJson(json);
}
