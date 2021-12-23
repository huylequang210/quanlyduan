import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/utils/database.dart';
import 'package:quanlydetai/widgets/appBar.dart';
import 'package:quanlydetai/widgets/editItemForm.dart';

class DbEditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentStudent;
  final String documentId;

  DbEditScreen({
    required this.currentTitle,
    required this.currentDescription,
    required this.currentStudent,
    required this.documentId,
  });

  @override
  _DbEditScreenState createState() => _DbEditScreenState();
}

class _DbEditScreenState extends State<DbEditScreen> {
  final FocusNode _titleFocus = FocusNode();

  final FocusNode _descriptionFocus = FocusNode();

  final FocusNode _studentFocus = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocus.unfocus();
        _descriptionFocus.unfocus();
        _studentFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColor.mainColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColor.mainColor,
          title: AppBarTitle(sectionName: 'CRUD'),
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbEditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocus,
              descriptionFocusNode: _descriptionFocus,
              studentFocusNode: _studentFocus,
              currentTitle: widget.currentTitle,
              currentStudent: widget.currentStudent,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }
}
