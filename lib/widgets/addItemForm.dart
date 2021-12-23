import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/utils/database.dart';
import 'package:quanlydetai/utils/checkValid.dart';

import 'custiomFormField.dart';

final FocusNode titleFocus = FocusNode();
final FocusNode studentFocus = FocusNode();
final FocusNode descriptionFocus = FocusNode();

class DbAddItemForm extends StatefulWidget {

  @override
  _DbAddItemFormState createState() => _DbAddItemFormState();
}

class _DbAddItemFormState extends State<DbAddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addItemFormKey,
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
                  focusNode: titleFocus,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Tên đề tài',
                  hint: 'Nhập tên đề tài',
                ),
                SizedBox(height: 2.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _studentController,
                  focusNode: studentFocus,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Tên sinh viên',
                  hint: 'Nhập tên sinh viên',
                ),
                SizedBox(height: 2.0),
                CustomFormField(
                  maxLines: 7,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  focusNode: descriptionFocus,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Mô tả',
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
                      titleFocus.unfocus();
                      descriptionFocus.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.addItem(
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
                        'Thêm đề tài',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: MyColor.myWhite,
                          letterSpacing: 1,
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
