import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget utilitiesGridItem(UtilitiesGridItem utilitiesGridItem) {
  return Container(
    child: Column(
      children: [
        Container(
            height: 70,
            width: 70,
            child:
                Expanded(child: SvgPicture.network(utilitiesGridItem.svgUrl))),
        SizedBox(
          height: 10,
        ),
        Text(
          utilitiesGridItem.utilityName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    ),
  );
}

class UtilitiesGridItem {
  UtilitiesGridItem({required this.utilityName, required this.svgUrl});
  final String utilityName;
  final String svgUrl;
}
