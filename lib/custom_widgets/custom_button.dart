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
  final bool isLoading;

  const CustomButton(
      {this.onPress,
      this.isLoading = false,
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
      onPressed: isLoading ? null : onPress,
      child: isLoading
          ? const SizedBox(
              height: 48,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.grey)))
          : Row(
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
