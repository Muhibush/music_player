import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateMolecule extends StatelessWidget {
  final String message;
  final String subMessage;

  const EmptyStateMolecule(
      {Key? key, required this.message, required this.subMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFB3B3B3),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
