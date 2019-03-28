import 'package:flutter_movie/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_movie.g.dart';

@JsonSerializable()
class ListMovie {
  final int count;
  final int start;
  final int total;
  final List<MovieInfo> subjects;
  final String title;

  ListMovie(this.count, this.start, this.total, this.title, this.subjects);

  factory ListMovie.fromJson(Map<String, dynamic> json) =>
      _$ListMovieFromJson(json);
}
