import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zakwamfyp/utils/colors.dart';

class CustomeTextfield extends StatelessWidget {
  var hinttext;
  var suficIcons;
  var prefixIcon;
  var controller;
  var valid;
  //final obscTextTrue;
  CustomeTextfield({this.hinttext,this.suficIcons,this.prefixIcon,this.controller,
    this.valid,
    // this.obscTextTrue
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        // decoration: BoxDecoration(
        //   color: AppColor.primary,
        //   borderRadius: BorderRadius.circular(30),
        // ),

        child: TextFormField(
          validator: valid,
          controller: controller,
          //obscureText: obscTextTrue,
          style: TextStyle(
              color: AppColor.blackColor
          ),
          decoration: InputDecoration(
            hintText: hinttext,
            suffixIcon: suficIcons,
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(
                color: AppColor.blackColor
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: AppColor.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: AppColor.primary)),
          ),
        ),
      );
  }
}


class CustomPasswordTextfield extends StatelessWidget {
  var hinttext;
  var suficIcons;
  var prefixIcon;
  final obscTextTrue;
  var controller;
  var valid;
  CustomPasswordTextfield({this.hinttext,this.suficIcons,this.prefixIcon,
    this.valid,
    this.obscTextTrue,this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppColor.primary,
      //   borderRadius: BorderRadius.circular(30),
      // ),
      child: TextFormField(
        validator: valid,
        controller: controller,
        obscureText: obscTextTrue,
        style: TextStyle(
            color: AppColor.blackColor
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          suffixIcon: suficIcons,
          prefixIcon: prefixIcon,

          hintStyle: TextStyle(
              color: AppColor.blackColor
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: AppColor.primary)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: AppColor.primary)),
        ),
      ),
    );
  }
}

// class kCustomeTextField extends StatefulWidget {
//   String? hintText;
//   TextEditingController? controller;
//   Widget? icon;
//   bool isPassword;
//   final validate;
//   bool check;
//   final TextInputAction? inputAction;
//   final FocusNode? focusNode;
//   kCustomeTextField({
//     this.hintText,
//     this.controller,
//     this.validate,
//     this.isPassword=false,
//     this.icon,
//     this.check=false,
//     this.inputAction,
//     this.focusNode,
//   });
//   @override
//   State<kCustomeTextField> createState() => _kCustomeTextFieldState();
// }
// class _kCustomeTextFieldState extends State<kCustomeTextField> {
//   bool visible=false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: TextFormField(
//           controller: widget.controller,
//           validator: widget.validate,
//           style: TextStyle(
//               color: AppColor.blackColor
//           ),
//           cursorColor: Colors.white,
//           focusNode: widget.focusNode,
//           textInputAction: widget.inputAction,
//           obscureText: widget.isPassword==false?false:widget.isPassword,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintStyle: GoogleFonts.poppins(
//               color: Colors.grey,
//               fontSize: 14,
//               fontWeight: FontWeight.w300,
//             ),
//             fillColor: Colors.white10,
//             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//             hintText: widget.hintText??"hint Text",
//             suffixIcon: widget.icon,
//             // border: InputBorder.none,
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//                 borderSide: BorderSide(color: Colors.grey)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//                 borderSide: BorderSide(color: Colors.grey)),
//           ),
//         )
//     );
//   }
// }
