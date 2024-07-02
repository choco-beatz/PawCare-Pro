import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';

class PrivacyDialoge extends StatelessWidget {
  PrivacyDialoge({super.key, this.radius = 8, required this.mdFileName})
      : assert(mdFileName.contains('.md'));
  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      backgroundColor: mainBG,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future:
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString(
                "asset/$mdFileName",
              );
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: Colors.white),
                    h1: const TextStyle(color: Colors.white),
                    h2: const TextStyle(color: Colors.white),
                    h3: const TextStyle(color: Colors.white),
                    h4: const TextStyle(color: Colors.white),
                    h5: const TextStyle(color: Colors.white),
                    h6: const TextStyle(color: Colors.white),
                    strong: const TextStyle(color: Colors.white),
                    em: const TextStyle(color: Colors.white),
                    code: const TextStyle(color: Colors.white),
                    blockquote: const TextStyle(color: Colors.white),
                  ),
                  data: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: cancelButton,
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
