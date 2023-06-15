import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class SeasonDetailArgument extends Equatable {
  final int id;
  final Season season;

  const SeasonDetailArgument({
    required this.id,
    required this.season,
  });

  @override
  List<Object?> get props => [id, season];
}
