import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/colors_and_styles.dart';

class MainButton extends StatelessWidget {
  final String? name;
  final VoidCallback? onTap;
  final bool isLoading;

  const MainButton({
    super.key,
    this.name,
    this.onTap,
    this.isLoading = false,
  }) : assert(
  isLoading || (name != null && onTap != null),
  'When not loading, both name and onTap must be provided',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color:  iconColor,),)
            : Center(
          child: Text(
            name ?? '',
            style: mainWhiteTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
