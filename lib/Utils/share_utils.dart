import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static void shareAppLink(BuildContext context, String appLink) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final String text = 'Check out our amazing app!\nDownload it now from $appLink';
    print(text);

    Share.share(text,
        subject: 'Check out this app!',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}