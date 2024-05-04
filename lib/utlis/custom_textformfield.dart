import 'package:flutter/material.dart';
import 'package:wfm/utlis/globalVariables.dart';

class CustomTextFormField extends StatefulWidget {
  bool isObsecure;
  String labelText;
  IconData fieldIcon;

  dynamic val;
  dynamic fieldController;

  CustomTextFormField({
    Key? key,
    required this.isObsecure,
    required this.labelText,
    required this.fieldIcon,
    required this.val,
    required this.fieldController,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        cursorColor: Colors.grey.shade500,
        obscureText: widget.isObsecure,
        controller: widget.fieldController,
        validator: widget.val,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.fieldIcon,
            color: Colors.black,
          ),
          errorStyle: const TextStyle(color: Colors.black),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: widget.labelText,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class CustomTextFormFieldPassword extends StatefulWidget {
  bool isObsecure;
  String labelText;
  IconData fieldIcon;
  IconButton visibility;
  dynamic val;
  dynamic fieldController;

  CustomTextFormFieldPassword({
    Key? key,
    required this.isObsecure,
    required this.labelText,
    required this.fieldIcon,
    required this.val,
    required this.fieldController,
    required this.visibility,
  }) : super(key: key);

  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        cursorColor: Colors.grey.shade500,
        obscureText: widget.isObsecure,
        controller: widget.fieldController,
        validator: widget.val,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.fieldIcon,
            color: Colors.black,
          ),
          suffixIcon: widget.visibility,
          errorStyle: const TextStyle(color: Colors.black),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: widget.labelText,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class CustomLargeTextFormField extends StatelessWidget {
  dynamic largeTextFieldController;
  dynamic businessList;

  CustomLargeTextFormField({
    required this.largeTextFieldController,
    Key? key,
    required businessList,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: largeTextFieldController,
      maxLines: 5,
      maxLength: 250,
      cursorColor: Colors.grey.shade500,
      /* onSaved: (val) => val,*/
      decoration: const InputDecoration(
        focusColor: Colors.white,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: 'Max 250 Characters',
      ),
    );
  }
}

class CustomPhoneNumberTextFormField extends StatelessWidget {
 final phoneNumberController;
  const CustomPhoneNumberTextFormField({
    Key? key, required this.phoneNumberController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneNumberController,
      maxLines: 1,
      maxLength: 11,
      cursorColor: Colors.grey.shade500,
      decoration: const InputDecoration(
        focusColor: Colors.white,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
