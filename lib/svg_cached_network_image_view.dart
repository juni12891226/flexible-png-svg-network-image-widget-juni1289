import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

///SVG cached network image
///To load the SVG images from the URL
///And cache them on the device storage until the image loader URL gets updated
///The [svgCacheRuleStaleDuration] can be provided for cache stale period
class SVGCachedNetworkImageView extends StatelessWidget {
  ///The image path URL for the SVG image to be loaded from the remote server
  final String imagePathOrURL;

  ///To set the SVG retry load limit, default is 1
  final int? svgLoadRetryLimit;

  ///The duration for setting the timeout from the remote server
  final Duration? timeOutDuration;

  ///The flag control the disk cache will be used or not.
  final bool? useDiskCacheForSVG;

  ///This duration can be used to set the cache stale rule
  ///The default duration is 500 days
  final Duration? svgCacheRuleStaleDuration;

  ///The callback is for checking when the SVG is failed to load
  final Function? onSVGLoadFailedCallback;

  ///The callback can be used to check when the SVG is loaded
  final Function? svgLoadedCallback;

  ///[imagePathOrURL] is required
  ///[timeOutDuration] is optional | for SVG you can set the load timeout | default is 30 seconds
  ///[svgLoadRetryLimit] is optional | for SVG you can set the retry load limit | default is 1 times | single
  ///[useDiskCacheForSVG] is optional | default is true
  ///[svgCacheRuleStaleDuration] is optional | for how much time the images needs to be caches | default is 500 days
  ///[onSVGLoadFailedCallback] is optional
  const SVGCachedNetworkImageView(
      {Key? key,
      this.svgLoadedCallback,
      this.timeOutDuration,
      this.useDiskCacheForSVG,
      this.svgCacheRuleStaleDuration,
      this.onSVGLoadFailedCallback,
      this.svgLoadRetryLimit,
      required this.imagePathOrURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture(AdvancedNetworkSvg(
        imagePathOrURL,
        (theme) => (bytes, colorFilter, key) {
              return svg.svgPictureDecoder(
                  bytes ?? Uint8List.fromList(const []),
                  false,
                  colorFilter,
                  key,
                  theme: theme);
            },
        retryLimit: svgLoadRetryLimit ?? 1,
        timeoutDuration: timeOutDuration ?? const Duration(seconds: 30),
        useDiskCache: useDiskCacheForSVG ?? true,
        cacheRule: CacheRule(
            maxAge: svgCacheRuleStaleDuration ?? const Duration(days: 500),
            storeDirectory: StoreDirectoryType.temporary),
        loadFailedCallback: () {
      if (onSVGLoadFailedCallback != null) {
        onSVGLoadFailedCallback!();
      }
    }, loadedCallback: () {
      if (svgLoadedCallback != null) {
        svgLoadedCallback!();
      }
    }));
  }
}
