import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String formatVoteAverage(double voteAverage) {
  return NumberFormat("#,##0.0", "id_ID").format(
    (voteAverage / 2),
  );
}

String formatDate(String date) {
  return DateFormat.yMMMEd().format(
    DateTime.parse(date),
  );
}

bool checkIsEmpty(String? data) {
  if (data == null) return true;
  if (data.isEmpty) return true;
  return false;
}
