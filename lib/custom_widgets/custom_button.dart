import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPress;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Size? size;
  final Widget? leftIcon;

  const CustomButton(
      {this.onPress,
      required this.text,
      super.key,
      this.bgColor,
      this.textStyle,
      this.textColor,
      this.leftIcon,
      this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: size ?? Size(ScreenUtil().screenWidth, 50),
        backgroundColor: bgColor ?? Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon ?? const SizedBox(),
          Text(text,
              style: textStyle ??
                  TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
