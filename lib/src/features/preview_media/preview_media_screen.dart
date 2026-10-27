import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

import 'preview_media_args.dart';

class PreviewMediaScreen extends StatelessWidget {
  const PreviewMediaScreen({super.key, required this.args});
  final PreviewMediaArgs args;

  @override
  Widget build(BuildContext context) {
    return SdPreviewMediaViewV5(items: args.items);
  }
}
