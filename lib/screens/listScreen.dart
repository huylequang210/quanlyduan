import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/widgets/appBar.dart';
import 'package:quanlydetai/widgets/itemList.dart';

import 'addScreen.dart';

class DbDashboardScreen extends StatefulWidget {
  @override
  _DbDashboardScreenState createState() => _DbDashboardScreenState();
}

class _DbDashboardScreenState extends State<DbDashboardScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.mainColor,
        title: AppBarTitle(
          sectionName: 'CRUD',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DbAddScreen(),
            ),
          );
        },
        backgroundColor: MyColor.myBlue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: DbItemList(),
        ),
      ),
    );
  }
}
