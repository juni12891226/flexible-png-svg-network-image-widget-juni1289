import 'package:flexible_png_svg_network_image_widget_juni1289/flexible_png_svg_network_image_juni1289.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pngURL = "https://openexpoeurope.com/wp-content/uploads/2019/12/flutter-logo-sharing.png";
  String svgURL = "https://raw.githubusercontent.com/dart-lang/site-shared/master/src/_assets/image/flutter/logo/default.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "from Assets with error",
              textAlign: TextAlign.center,
            ),
            const FlexiblePngSvgNetworkImageWidget(
              networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
              imagePathOrURL: "assets/icons/cat.png",
              height: 50,
              width: 30,
              filterQuality: FilterQuality.high,
            ),
            const Text(
              "from Assets with no error",
              textAlign: TextAlign.center,
            ),
            const FlexiblePngSvgNetworkImageWidget(
              networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
              imagePathOrURL: "assets/images/cat.png",
              height: 50,
              width: 30,
              filterQuality: FilterQuality.high,
            ),
            const Text(
              "from network for PNG with no error",
              textAlign: TextAlign.center,
            ),
            FlexiblePngSvgNetworkImageWidget(
              networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
              imagePathOrURL: pngURL,
              height: 90,
              width: 60,
              filterQuality: FilterQuality.high,
              isNetworkImage: true,
              colorProgressLoaderIndicator: Colors.purple,
            ),
            const Text(
              "from network for PNG with error",
              textAlign: TextAlign.center,
            ),
            const FlexiblePngSvgNetworkImageWidget(
              networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
              imagePathOrURL: "https://openexpoeurope.com/wp-content/uploads/2019/12.png",
              height: 90,
              width: 60,
              filterQuality: FilterQuality.high,
              isNetworkImage: true,
              colorProgressLoaderIndicator: Colors.purple,
            ),
            const Text(
              "from network for SVG with no error",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: FlexiblePngSvgNetworkImageWidget(
                  networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
                  imagePathOrURL: svgURL,
                  height: 90,
                  width: 60,
                  filterQuality: FilterQuality.high,
                  isNetworkImage: true,
                  colorProgressLoaderIndicator: Colors.purple,
                ),
              ),
            ),
            const Text(
              "from network for SVG with error",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: FlexiblePngSvgNetworkImageWidget(
                  networkErrorPlaceHolderImagePath: "assets/images/placeholder.png",
                  imagePathOrURL: "${svgURL}sdkjk",
                  height: 90,
                  width: 60,
                  filterQuality: FilterQuality.high,
                  isNetworkImage: true,
                  colorProgressLoaderIndicator: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
