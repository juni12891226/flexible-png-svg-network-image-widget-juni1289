import 'package:flexible_png_svg_network_image_widget_juni1289/empty_container_helper_widget.dart';
import 'package:flexible_png_svg_network_image_widget_juni1289/png_cached_network_image_view.dart';
import 'package:flexible_png_svg_network_image_widget_juni1289/svg_cached_network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///A Flutter widget to load the images from the network or from the local assets
///It can load the images from the URL for PNG as well as SVG images
///It decided for the image file extension itself
///The [isNetworkImage] param decides whether to load the image from the URL or from the local assets
///Mainly there are 2 image file types can be loaded PNG or SVG
class FlexiblePngSvgNetworkImageWidget extends StatelessWidget {
  ///The image path or the URL for the image to be loaded
  ///Determines the type of the image PNG or SVG
  final String imagePathOrURL;

  ///Required param to set the height of the image
  final double height;

  ///Required param to set the width of the image
  final double width;

  ///To set the boxfit props for the image
  final BoxFit? boxFit;

  ///To set the filter quality for the PNG images, default is High
  final FilterQuality? filterQuality;

  ///To set the SVG color, depends if your provided SVG supports the color change
  final Color? colorSVG;

  ///To set if this widget should load the image from the remote server or from the load assets
  final bool isNetworkImage;

  ///To set the color for the progress loader for PNG images
  ///By default a progress loader with blue color would be shown
  ///You can provide your own widget while waiting for the PNG image to load
  final Color? colorProgressLoaderIndicator;

  ///To set the path of the network image placeholder that is when the image fails to load and this as a default image to be shown
  final String networkErrorPlaceHolderImagePath;

  ///To set the error widget
  ///Custom widget that you can set in place of as an error widget
  ///When the image is failed to load
  final Widget? errorWidget;

  ///If you want to show your own progress indicator widget
  ///You can use Lottie animation widget
  ///By default a progress widget is shown
  final Widget? progressIndicatorWidget;

  ///To set the SVG load retry limit
  ///The default is set to 1
  final int? svgLoadRetryLimit;

  ///To set the network timeout duration while loading the image from the remote network
  ///The default is 30 seconds
  final Duration? networkTimeOutDuration;

  ///The flag control the disk cache will be used or not.
  final bool? useDiskCacheForSVG;

  ///This duration can be used to set the cache stale rule
  ///The default duration is 500 days
  final Duration? svgCacheRuleStaleDuration;

  ///The callback is for checking when the SVG is failed to load
  final Function? onSVGLoadFailedCallback;

  ///To set if it should use the old PNG image for a new URL
  ///if it is set to true, will always use the old image for every new URL
  ///else, will always change the image for every new URL
  ///Cache refreshing
  ///Default value is false
  final bool useOldPngImageOnUrlChange;

  ///The callback can be used to check when the SVG is loaded
  final Function? svgLoadedCallback;

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
  ///[svgCacheRuleStaleDuration] is optional | for how much time the images needs to be caches | default is 500 days
  ///[onSVGLoadFailedCallback] is optional
  ///[useOldPngImageOnUrlChange] in order to use the old image on new URL default is false
  const FlexiblePngSvgNetworkImageWidget(
      {Key? key,
      required this.networkErrorPlaceHolderImagePath,
      required this.imagePathOrURL,
      required this.height,
      required this.width,
      this.svgLoadedCallback,
      this.useOldPngImageOnUrlChange = false,
      this.networkTimeOutDuration,
      this.useDiskCacheForSVG,
      this.svgCacheRuleStaleDuration,
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
    //check if load from network
    if (isNetworkImage) {
      //check if the url is for SVG
      if (imagePathOrURL.endsWith(".svg")) {
        return SVGCachedNetworkImageView(
          svgLoadedCallback: svgLoadedCallback,
          imagePathOrURL: imagePathOrURL,
          timeOutDuration: networkTimeOutDuration,
          useDiskCacheForSVG: useDiskCacheForSVG,
          svgCacheRuleStaleDuration: svgCacheRuleStaleDuration,
          onSVGLoadFailedCallback: onSVGLoadFailedCallback,
          svgLoadRetryLimit: svgLoadRetryLimit,
        );
      } else {
        //url is for PNG
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
      //load from assets
      return _getImageFromAssetView();
    }
  }

  ///Load the image from the local assets
  Widget _getImageFromAssetView() {
    if (imagePathOrURL.isNotEmpty) {
      if (boxFit != null) {
        if (imagePathOrURL.endsWith(".png")) {
          return Image.asset(imagePathOrURL,
              height: height,
              width: width,
              filterQuality: filterQuality ?? FilterQuality.high,
              fit: boxFit, errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorWidget ??
                Image.asset(networkErrorPlaceHolderImagePath,
                    height: height,
                    width: width,
                    filterQuality: filterQuality ?? FilterQuality.high);
          });
        } else if (imagePathOrURL.endsWith(".svg")) {
          return SvgPicture.asset(imagePathOrURL,
              height: height, width: width, fit: boxFit!, color: colorSVG);
        } else {
          return const EmptyContainerHelperWidget();
        }
      } else {
        if (imagePathOrURL.endsWith(".png")) {
          return Image.asset(imagePathOrURL,
              height: height,
              width: width,
              filterQuality: filterQuality ?? FilterQuality.high, errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorWidget ??
                Image.asset(networkErrorPlaceHolderImagePath,
                    height: height,
                    width: width,
                    filterQuality: filterQuality ?? FilterQuality.high);
          });
        } else if (imagePathOrURL.endsWith(".svg")) {
          return SvgPicture.asset(imagePathOrURL,
              height: height, width: width, color: colorSVG);
        } else {
          return const EmptyContainerHelperWidget();
        }
      }
    } else {
      return const EmptyContainerHelperWidget();
    }
  }
}
