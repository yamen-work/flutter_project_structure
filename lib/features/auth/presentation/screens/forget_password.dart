import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/enums/state_value.dart';
import '../../../../core/validatiors/email_validator.dart';
import '../../../../core/widgets/flushbar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../bloc/auth_cubit.dart';
import '../../bloc/auth_state.dart';
import '../widgets/outline_border.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final bool fromMainScreen;

  const ForgetPasswordScreen({super.key, this.fromMainScreen = true});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var formKeyForgot = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Forgot Password",style: mediumWhiteTextStyle,),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKeyForgot,
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        ///email
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
      
                        /// button
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: BlocConsumer<AuthCubit, AuthState>(
                            listenWhen: (previous, current) =>
                                current.forgotPasswordState !=
                                previous.forgotPasswordState,
                            buildWhen: (previous, current) =>
                                current.forgotPasswordState !=
                                previous.forgotPasswordState,
                            listener: (context, state) async {
                              if (state.forgotPasswordState == StateValue.error) {
                                showSimpleFlushBar(
                                  context,
                                  state.forgotPasswordMessage,
                                  "",
                                  Icons.info_outline_rounded,
                                  errorColor,
                                );
                              }
      
                              if (state.forgotPasswordState ==
                                  StateValue.loaded) {
                                await showSimpleFlushBar(
                                  context,
                                  "Check Email",
                                  "",
                                  Icons.check_circle_outline,
                                  successColor,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state.forgotPasswordState ==
                                  StateValue.loading) {
                                return Center(
                                  child: MainButton(
                                    name: "",
                                    onTap: () {},
                                    isLoading: true,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: MainButton(
                                    name: "Send",
                                    onTap: () {
                                      if (formKeyForgot.currentState!
                                          .validate()) {
                                        BlocProvider.of<AuthCubit>(
                                          context,
                                        ).forgotPassword(
                                          emailController.text,
                                        );
                                      }
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
