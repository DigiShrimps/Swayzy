import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_text_styles.dart';

late InAppWebViewController webViewController;
final WebUri _url = WebUri("https://github.com/DigiShrimps/Swayzy");
const _titleText = "GitHub";

class InnerBrowser extends StatelessWidget {
  const InnerBrowser({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
        leading: IconButton(
          color: AppColors.accent,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: _url),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}