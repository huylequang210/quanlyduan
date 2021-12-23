import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/widgets/appBar.dart';
import 'package:quanlydetai/widgets/addItemForm.dart';

class DbAddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColor.mainColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColor.mainColor,
          title: AppBarTitle(
            sectionName: '',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbAddItemForm(

            ),
          ),
        ),
      ),
    );
  }
}
