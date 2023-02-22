// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromJson(jsonString);

import 'dart:convert';
import 'package:app_movies/models/movie.dart';

class PopularResponse {
    PopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movies> results;
    int totalPages;
    int totalResults;

    factory PopularResponse.fromjson(String str) => PopularResponse.fromMap(json.decode(str));

    factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
