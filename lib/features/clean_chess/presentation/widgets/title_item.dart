import 'package:flutter/material.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart' as lichess;

class TitleItem extends StatelessWidget {
  const TitleItem({super.key, required this.title});
  final lichess.Title? title;

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const SizedBox.shrink();
    }
    Color color = Colors.white;
    String cutTitle = title
        .toString()
        .toUpperCase()
        .substring(title.toString().indexOf('.') + 1, title.toString().length);
    final colors = {
      'GM': Colors.amber,
      'WGM': Colors.amber,
      'IM': Colors.pink,
      'WIM': Colors.pink,
      'FM': Colors.blue,
      'WFM': Colors.blue,
      'NM': Colors.green,
      'WNM': Colors.green,
      'CM': Colors.purple,
      'WCM': Colors.purple,
    };
    if (cutTitle == 'null') {
      return const SizedBox.shrink();
    } else {
      color = colors[cutTitle]!;
    }
    return Text(
      cutTitle,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
