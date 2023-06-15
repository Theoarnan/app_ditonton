import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class Widgets {
  static Widget imageCachedNetworkCard(
    String? image, {
    bool noSizeImageError = false,
  }) {
    /// Handle image on empty Widget
    Widget imageHandleEmptyWidget() {
      if (noSizeImageError) {
        return Image.asset(
          noImageAsset,
          fit: BoxFit.cover,
          key: const Key('loading_image_empty'),
        );
      } else {
        return SizedBox(
          key: const Key('loading_image_empty'),
          height: 150,
          width: 98,
          child: Image.asset(
            noImageAsset,
            fit: BoxFit.cover,
          ),
        );
      }
    }

    if (checkIsEmpty(image)) {
      return baseImageWidget(
        noSizeImageError,
        widgetImage: imageHandleEmptyWidget(),
      );
    }
    return baseImageWidget(
      noSizeImageError,
      widgetImage: CachedNetworkImage(
        imageUrl: '$baseImageURL$image',
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) {
          return Padding(
            key: Key('error_image$image'),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.error),
                Text(
                  'Sorry',
                  style: kBodyText,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget baseImageWidget(
    bool noSizeImageError, {
    required Widget widgetImage,
  }) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(16),
      ),
      child: widgetImage,
    );
  }
}
