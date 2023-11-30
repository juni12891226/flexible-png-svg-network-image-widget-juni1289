import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGCachedNetworkImageView extends StatelessWidget {
  final String imagePathOrURL;
  final int? svgLoadRetryLimit;
  final Duration? timeOutDuration;
  final bool? useDiskCacheForSVG;
  final Duration? cacheRuleStaleDuration;
  final Function? onSVGLoadFailedCallback;

  ///[imagePathOrURL] is required
  ///[timeOutDuration] is optional | for SVG you can set the load timeout | default is 30 seconds
  ///[svgLoadRetryLimit] is optional | for SVG you can set the retry load limit | default is 1 times | single
  ///[useDiskCacheForSVG] is optional | default is true
  ///[cacheRuleStaleDuration] is optional | for how much time the images needs to be caches | default is 500 days
  ///[onSVGLoadFailedCallback] is optional
  const SVGCachedNetworkImageView(
      {Key? key,
      this.timeOutDuration,
      this.useDiskCacheForSVG,
      this.cacheRuleStaleDuration,
      this.onSVGLoadFailedCallback,
      this.svgLoadRetryLimit,
      required this.imagePathOrURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture(AdvancedNetworkSvg(
        imagePathOrURL,
        (theme) => (bytes, colorFilter, key) {
              return svg.svgPictureDecoder(bytes ?? Uint8List.fromList(const []), false, colorFilter, key, theme: theme);
            },
        retryLimit: svgLoadRetryLimit ?? 1,
        timeoutDuration: timeOutDuration ?? const Duration(seconds: 30),
        useDiskCache: useDiskCacheForSVG ?? true,
        cacheRule: CacheRule(maxAge: cacheRuleStaleDuration ?? const Duration(days: 500), storeDirectory: StoreDirectoryType.temporary), loadFailedCallback: () {
      if (onSVGLoadFailedCallback != null) {
        onSVGLoadFailedCallback!();
      }
    }));
  }
}
