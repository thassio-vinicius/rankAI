import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rankai/core/presentation/routes/my_navigator.dart';
import 'package:share_plus/share_plus.dart';

class ImagePreviewScreen extends StatefulWidget {
  final Uint8List image;
  const ImagePreviewScreen({required this.image, super.key});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => MyNavigator(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  IconButton(
                    onPressed: () async {
                      final dir = await getApplicationDocumentsDirectory();
                      final file =
                          await File('${dir.path}${DateTime.now()}.png')
                              .writeAsBytes(widget.image);

                      await Share.shareXFiles(
                        [XFile(file.path)],
                      );
                    },
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.share : Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Hero(
                tag: widget.image,
                child: Image.memory(
                  widget.image,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
