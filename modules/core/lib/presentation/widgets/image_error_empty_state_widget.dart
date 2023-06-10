import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ImageErrorEmptyStateWidget extends StatelessWidget {
  final bool isEmptyState;
  final bool isMovieState;
  const ImageErrorEmptyStateWidget({
    super.key,
    this.isEmptyState = false,
    this.isMovieState = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageHandle()),
          Text(
            textHandle(),
            textAlign: TextAlign.center,
            style: kHeading6,
          )
        ],
      ),
    );
  }

  String imageHandle() {
    const imgEmpty = 'assets/empty-data.gif';
    const imgError = 'assets/error-data.gif';
    return isEmptyState ? imgEmpty : imgError;
  }

  String textHandle() {
    if (isMovieState) {
      if (isEmptyState) return 'Oops, data movies is empty.';
      return 'Sorry, failed load data movies.';
    }
    if (isEmptyState) return 'Oops, data tvseries is empty.';
    return 'Sorry, failed load data tvseries.';
  }
}
