import 'package:flutter/material.dart';

import 'package:quanlydetai/utils/custom_colors.dart';

class AppBarTitle extends StatelessWidget {
  final String sectionName;

  const AppBarTitle({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 8),
        Text(
          'Quản lý đề tài',
          style: TextStyle(
            color: MyColor.myEmber,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
