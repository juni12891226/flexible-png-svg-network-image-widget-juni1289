import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexible_png_svg_network_image_widget_juni1289/flexible_png_svg_network_image_juni1289.dart';
import 'package:flutter/material.dart';

class PNGCachedNetworkImageView extends StatelessWidget {
  final String imagePathOrURL;
  final double height;
  final double width;
  final BoxFit? boxFit;
  final FilterQuality? filterQuality;
  final Color? colorProgressLoaderIndicator;
  final String networkErrorPlaceHolderImagePath;
  final Widget? errorWidget;
  final Widget? progressIndicatorWidget;
  final bool useOldPngImageOnUrlChange;

  ///[imagePathOrURL] is required | image path from the assets or the network URL
  ///[height] is required
  ///[width] is required
  ///[boxFit] is optional
  ///[filterQuality] is optional and default is High Quality
  ///[colorProgressLoaderIndicator] is optional default is blue
  ///[networkErrorPlaceHolderImagePath] is required | in case of error the default placeholder image asset path
  ///[errorWidget] is optional | if you want to show your own error widget in case of png image
  ///[progressIndicatorWidget] is optional | if you want to show your own progress widget
  ///[useOldPngImageOnUrlChange] in order to use the old image on new URL default is false
  const PNGCachedNetworkImageView(
      {Key? key,
      this.useOldPngImageOnUrlChange = false,
      this.progressIndicatorWidget,
      required this.networkErrorPlaceHolderImagePath,
      this.colorProgressLoaderIndicator,
      this.errorWidget,
      this.boxFit,
      required this.imagePathOrURL,
      required this.height,
      required this.width,
      this.filterQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return boxFit != null
        ? CachedNetworkImage(
            useOldImageOnUrlChange: useOldPngImageOnUrlChange,
            imageUrl: imagePathOrURL,
            height: height,
            width: width,
            filterQuality: filterQuality ?? FilterQuality.high,
            fit: boxFit,
            progressIndicatorBuilder: (BuildContext context, url, downloadProgress) {
              return progressIndicatorWidget ??
                  SizedBox(height: height, width: width, child: Center(child: CircularProgressIndicator(color: colorProgressLoaderIndicator ?? Colors.blue)));
            },
            errorWidget: (BuildContext context, url, error) {
              return errorWidget ??
                  Center(
                      child: FlexiblePngSvgNetworkWidget(
                          networkErrorPlaceHolderImagePath: networkErrorPlaceHolderImagePath,
                          imagePathOrURL: networkErrorPlaceHolderImagePath,
                          height: height,
                          width: width,
                          filterQuality: filterQuality ?? FilterQuality.high));
            })
        : CachedNetworkImage(
            imageUrl: imagePathOrURL,
            height: height,
            width: width,
            filterQuality: filterQuality ?? FilterQuality.high,
            progressIndicatorBuilder: (BuildContext context, url, downloadProgress) {
              return progressIndicatorWidget ??
                  SizedBox(height: height, width: width, child: Center(child: CircularProgressIndicator(color: colorProgressLoaderIndicator ?? Colors.blue)));
            },
            errorWidget: (BuildContext context, url, error) {
              return errorWidget ??
                  Center(
                      child: FlexiblePngSvgNetworkWidget(
                          networkErrorPlaceHolderImagePath: networkErrorPlaceHolderImagePath,
                          imagePathOrURL: networkErrorPlaceHolderImagePath,
                          height: height,
                          width: width,
                          filterQuality: filterQuality ?? FilterQuality.high));
            });
  }
}
