import 'package:flutter/material.dart';

import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/utils/database.dart';
import 'package:quanlydetai/utils/checkValid.dart';

import 'custiomFormField.dart';

class DbEditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode studentFocusNode;
  final String currentTitle;
  final String currentDescription;
  final String currentStudent;
  final String documentId;

  const DbEditItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.studentFocusNode,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentStudent,
    required this.documentId,
  });

  @override
  _DbEditItemFormState createState() => _DbEditItemFormState();
}

class _DbEditItemFormState extends State<DbEditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _studentController;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );

    _studentController = TextEditingController(
      text: widget.currentStudent,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Tên đề tài',
                  hint: 'Ghi tên đề tài',
                ),
                SizedBox(height: 5.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _studentController,
                  focusNode: widget.studentFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Tên sinh viên',
                  hint: 'Tên sinh viên',
                ),
                SizedBox(height: 5.0),
                CustomFormField(
                  maxLines: 8,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  focusNode: widget.descriptionFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Mô tả đề tài',
                  hint: 'Nhập mô tả đề tài',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      MyColor.myBlue,
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        MyColor.myBlue,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();

                      if (_editItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateItem(
                          docId: widget.documentId,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          student: _studentController.text,
                        );

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text(
                        'Cập nhật đề tài',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: MyColor.myWhite,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
