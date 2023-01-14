import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('서비스 이용약관')),
      body: FutureBuilder(
        future: rootBundle.loadString("assets/document/PrivacyPolicy.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Markdown(
                data: snapshot.data!,
                styleSheet: MarkdownStyleSheet(
                    h1Align: WrapAlignment.center,
                    h2Align: WrapAlignment.center));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
