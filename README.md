**A flexible Flutter widget that supports the PNG and SVG images from the network, can cache them. Actually 3 in 1, supports PNG SVG as well as image from local assets**

<div align="center">
    <img src="/Screenshot_1701358352.png" width="400px" height="10px">  
</div>

## Features

* Supports PNG Network Image with Cache
* Supports SVG Network Image with Cache
* Supports Images files from Local Assets

* You just have to select if you have to load the image from the network or from the local assets using **bool -> isNetworkImage**
* You just have to provide the **String -> imagePathOrURL** to specify the path of the image
* You can cache PNG Images as well as SVG Images as long as you want!

## Additional Information

* The package itself checks for the PNG or SVG extension
* Easy to manage and flexible to use

## Basic Setup

```
    FlexiblePngSvgNetworkWidget(
              networkErrorPlaceHolderImagePath: placeHolderImagePathLocal,
              imagePathOrURL: imageURL,
              isNetworkImage: true | false,
              height: 50,
              width: 30,
              filterQuality: FilterQuality.high,
              svgLoadRetryLimit: 2,
                cacheRuleStaleDuration:Duration(days: 100)
            )
```

## Main Widget Signature

```
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
```