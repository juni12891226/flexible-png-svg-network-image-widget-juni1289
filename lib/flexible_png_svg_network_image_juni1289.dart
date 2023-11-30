import 'package:flexible_png_svg_network_image_widget_juni1289/empty_container_helper_widget.dart';
import 'package:flexible_png_svg_network_image_widget_juni1289/png_cached_network_image_view.dart';
import 'package:flexible_png_svg_network_image_widget_juni1289/svg_cached_network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlexiblePngSvgNetworkWidget extends StatelessWidget {
  final String imagePathOrURL;
  final double height;
  final double width;
  final BoxFit? boxFit;
  final FilterQuality? filterQuality;
  final Color? colorSVG;
  final bool isNetworkImage;
  final Color? colorProgressLoaderIndicator;
  final String networkErrorPlaceHolderImagePath;
  final Widget? errorWidget;
  final Widget? progressIndicatorWidget;
  final int? svgLoadRetryLimit;
  final Duration? networkTimeOutDuration;
  final bool? useDiskCacheForSVG;
  final Duration? cacheRuleStaleDuration;
  final Function? onSVGLoadFailedCallback;
  final bool useOldPngImageOnUrlChange;

  ///A generic widget to show the images from the Assets or from the network
  ///[imagePathOrURL] is required | image path from the assets or the network URL
  ///[height] is required
  ///[width] is required
  ///[boxFit] is optional
  ///[filterQuality] is optional and default is High Quality
  ///[colorSVG] is optional
  ///[isNetworkImage] is required | true if load from network | false if load from assets
  ///[colorProgressLoaderIndicator] is optional default is blue
  ///[networkErrorPlaceHolderImagePath] is required | in case of error the default placeholder image asset path
  ///[errorWidget] is optional | if you want to show your own error widget in case of png image
  ///[progressIndicatorWidget] is optional | if you want to show your own progress widget
  ///[networkTimeOutDuration] is optional | for SVG you can set the load timeout | default is 30 seconds
  ///[svgLoadRetryLimit] is optional | for SVG you can set the retry load limit | default is 1 times | single
  ///[useDiskCacheForSVG] is optional | default is true
  ///[cacheRuleStaleDuration] is optional | for how much time the images needs to be caches | default is 500 days
  ///[onSVGLoadFailedCallback] is optional
  ///[useOldPngImageOnUrlChange] in order to use the old image on new URL default is false
  const FlexiblePngSvgNetworkWidget(
      {Key? key,
      required this.networkErrorPlaceHolderImagePath,
      required this.imagePathOrURL,
      required this.height,
      required this.width,
      this.useOldPngImageOnUrlChange = false,
      this.networkTimeOutDuration,
      this.useDiskCacheForSVG,
      this.cacheRuleStaleDuration,
      this.onSVGLoadFailedCallback,
      this.svgLoadRetryLimit,
      this.progressIndicatorWidget,
      this.errorWidget,
      this.colorProgressLoaderIndicator,
      this.isNetworkImage = false,
      this.colorSVG,
      this.boxFit,
      this.filterQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      if (imagePathOrURL.endsWith(".svg")) {
        return SVGCachedNetworkImageView(
          imagePathOrURL: imagePathOrURL,
          timeOutDuration: networkTimeOutDuration,
          useDiskCacheForSVG: useDiskCacheForSVG,
          cacheRuleStaleDuration: cacheRuleStaleDuration,
          onSVGLoadFailedCallback: onSVGLoadFailedCallback,
          svgLoadRetryLimit: svgLoadRetryLimit,
        );
      } else {
        return PNGCachedNetworkImageView(
            useOldPngImageOnUrlChange: useOldPngImageOnUrlChange,
            progressIndicatorWidget: progressIndicatorWidget,
            errorWidget: errorWidget,
            networkErrorPlaceHolderImagePath: networkErrorPlaceHolderImagePath,
            colorProgressLoaderIndicator: colorProgressLoaderIndicator,
            boxFit: boxFit,
            imagePathOrURL: imagePathOrURL,
            height: height,
            width: width,
            filterQuality: filterQuality);
      }
    } else {
      return _getImageFromAssetView();
    }
  }

  Widget _getImageFromAssetView() {
    if (imagePathOrURL.isNotEmpty) {
      if (boxFit != null) {
        if (imagePathOrURL.endsWith(".png")) {
          return Image.asset(imagePathOrURL, height: height, width: width, filterQuality: filterQuality ?? FilterQuality.high, fit: boxFit,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorWidget ?? Image.asset(networkErrorPlaceHolderImagePath, height: height, width: width, filterQuality: filterQuality ?? FilterQuality.high);
          });
        } else if (imagePathOrURL.endsWith(".svg")) {
          return SvgPicture.asset(imagePathOrURL, height: height, width: width, fit: boxFit!, color: colorSVG);
        } else {
          return const EmptyContainerHelperWidget();
        }
      } else {
        if (imagePathOrURL.endsWith(".png")) {
          return Image.asset(imagePathOrURL, height: height, width: width, filterQuality: filterQuality ?? FilterQuality.high,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorWidget ?? Image.asset(networkErrorPlaceHolderImagePath, height: height, width: width, filterQuality: filterQuality ?? FilterQuality.high);
          });
        } else if (imagePathOrURL.endsWith(".svg")) {
          return SvgPicture.asset(imagePathOrURL, height: height, width: width, color: colorSVG);
        } else {
          return const EmptyContainerHelperWidget();
        }
      }
    } else {
      return const EmptyContainerHelperWidget();
    }
  }
}
