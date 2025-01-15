import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/cust_color.dart';

// class CustTextField extends StatelessWidget{
//   final String? hintText;
//   final bool obscureText;
//   final TextEditingController? controller;
//   CustTextField({this.hintText,this.obscureText = false,this.controller});
//   @override
//   Widget build(BuildContext context) {
//     return
//
//       TextField(
//       controller: controller,
//       obscureText: obscureText,
//       obscuringCharacter: '*',
//       decoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: IconButton(onPressed: (){},padding: EdgeInsets.only(right: 12),icon: Icon(obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 15,
//           horizontal: 15,
//         ),
//       ),
//     );
//   }
//
// }


class CustTextField extends  StatelessWidget{
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final String? labelText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLength;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool enableSuffix;
  final Function(String)? onChanged;

  CustTextField({
    this.onChanged,
    this.controller,
    this.prefixIcon,
    this.enableSuffix = false,
    this.labelText,
    this.obscureText = false,
    this.textInputAction,
    this.textInputType,
    this.textInputFormatter,
    this.maxLength,
    this.focusNode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: const TextSelectionThemeData(
        selectionHandleColor: CustColor.Green,
        cursorColor: CustColor.Green,
        selectionColor: CustColor.Light_Green
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        keyboardType: textInputType,
        inputFormatters: textInputFormatter,
        obscureText: obscureText,
        maxLength: maxLength,
        textInputAction: textInputAction,
        controller: controller,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            counterText: '',
            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),),
            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),),
            prefixIcon: prefixIcon,
            suffixIcon: enableSuffix ? IconButton(onPressed: onTap,icon: Icon(obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye)) : null,
            labelText: labelText,
          labelStyle: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          )
        ),
      ),
    );

  }
}