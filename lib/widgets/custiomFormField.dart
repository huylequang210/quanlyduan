import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    required TextInputAction inputAction,
    required String label,
    required String hint,
    required Function(String value) validator,
    this.maxLines = 1,
    this.isLabelEnabled = true,
  })  : _thisController = controller,
        _thisFocusNode = focusNode,
        _keyboardtype = keyboardType,
        _inputAction = inputAction,
        _label = label,
        _hint = hint,
        _validator = validator,
        super(key: key);

  final TextEditingController _thisController;
  final FocusNode _thisFocusNode;
  final TextInputType _keyboardtype;
  final TextInputAction _inputAction;
  final String _label;
  final String _hint;
  final int maxLines;
  final bool isLabelEnabled;
  final Function(String) _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: _thisController,
      focusNode: _thisFocusNode,
      keyboardType: _keyboardtype,
      textInputAction: _inputAction,
      cursorColor: MyColor.myEmber,
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        labelText: isLabelEnabled ? _label : null,
        labelStyle: TextStyle(color: MyColor.myEmber),
        hintText: _hint,
        hintStyle: TextStyle(
          color: MyColor.myWhite.withOpacity(0.5),
        ),
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: MyColor.myRed,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: MyColor.myWhite.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
