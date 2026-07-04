import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/validatiors/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/flushbar.dart';
import '../widgets/outline_border.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// TextField controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// for the forms
  final formKey = GlobalKey<FormState>();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    debugPrint('canPop: ${Navigator.of(context).canPop()}');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return loginBody(context);
                    } else {
                      return loginBodyTab(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginBody(BuildContext bContext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5.h),
              child: Text(
                "Email",
                style: TextStyle(fontSize: 18.sp, color: Colors.blueGrey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20.sp),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: true,
                errorStyle: smallTextStyle.copyWith(color: Colors.red),
                prefixIcon: Icon(Icons.email, size: 30.h),
                border: outlineBorder(borderColor: Colors.grey[100]!),
                focusedBorder: outlineBorder(borderColor: Colors.blue),
                disabledBorder: outlineBorder(),
                errorBorder: outlineBorder(borderColor: Colors.red),
              ),

              validator: validateEmail,
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 18.sp, color: Colors.blueGrey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20.sp),
              controller: passwordController,
              obscureText: isHidden,
              keyboardType: TextInputType.visiblePassword,
              onFieldSubmitted: (String value) {
                debugPrint(value);
              },
              onChanged: (String value) {
                debugPrint(value);
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(fontSize: 12.sp, color: Colors.red),
                border: outlineBorder(),
                focusedBorder: outlineBorder(borderColor: Colors.blue),
                disabledBorder: outlineBorder(),
                errorBorder: outlineBorder(borderColor: Colors.red),
                prefixIcon: Icon(Icons.lock, size: 30.h),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                    size: 30.h,
                  ),
                ),
              ),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Empty Password";
                } else if (value!.length < 8) {
                  return "Enter A Valid Password";
                }
                return null;
              },
            ),
            SizedBox(height: 30.h),

            Container(
              height: 60.h,
              width: 400.w,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showSimpleFlushBar(
                      context,
                      "You have logged in successfully",
                      "welcome back",
                      Icons.waving_hand,
                      Colors.green,
                    ).then((value) {
                      Navigator.pushNamed(context, Routes.mainLayout);
                    });
                  }
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Don't Have An Account ?",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginBodyTab(BuildContext bContext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.h),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 18.sp, color: Colors.blueGrey),
                  ),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20.sp),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    errorStyle: smallTextStyle.copyWith(color: Colors.red),
                    prefixIcon: Icon(Icons.email, size: 30.h),
                    border: outlineBorder(borderColor: Colors.grey[100]!),
                    focusedBorder: outlineBorder(borderColor: Colors.blue),
                    disabledBorder: outlineBorder(),
                    errorBorder: outlineBorder(borderColor: Colors.red),
                  ),

                  validator: validateEmail,
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 18.sp, color: Colors.blueGrey),
                  ),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20.sp),
                  controller: passwordController,
                  obscureText: isHidden,
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (String value) {
                    debugPrint(value);
                  },
                  onChanged: (String value) {
                    debugPrint(value);
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 12.sp, color: Colors.red),
                    border: outlineBorder(),
                    focusedBorder: outlineBorder(borderColor: Colors.blue),
                    disabledBorder: outlineBorder(),
                    errorBorder: outlineBorder(borderColor: Colors.red),
                    prefixIcon: Icon(Icons.lock, size: 30.h),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: Icon(
                        isHidden ? Icons.visibility : Icons.visibility_off,
                        size: 30.h,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return "Empty Password";
                    } else if (value!.length < 8) {
                      return "Enter A Valid Password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),

                Container(
                  height: 60.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showSimpleFlushBar(
                          context,
                          "You have logged in successfully",
                          "welcome back",
                          Icons.waving_hand,
                          Colors.green,
                        ).then((value) {
                          Navigator.pushNamed(context, Routes.mainLayout);
                        });
                      }
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Don't Have An Account ?",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
