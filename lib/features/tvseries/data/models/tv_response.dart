import 'package:app_ditonton/features/tvseries/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from(
          (json["results"] as List).map((x) => TvModel.fromJson(x)).where(
                (element) => element.posterPath != null,
              ),
        ),
      );

  @override
  List<Object> get props => [tvList];
}