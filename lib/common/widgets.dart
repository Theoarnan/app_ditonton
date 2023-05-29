import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Widgets {
  static Widget imageCachedNetwork(
    String image, {
    double width = 0,
    bool noSizeImageError = false,
  }) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(16),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => noSizeImageError
            ? Image.asset(
                'assets/no-image.gif',
                fit: BoxFit.cover,
              )
            : SizedBox(
                height: 150,
                width: 98,
                child: Image.asset(
                  'assets/no-image.gif',
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
