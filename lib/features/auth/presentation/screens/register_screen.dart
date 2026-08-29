import 'package:exercise_projects/core/validatiors/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/enums/state_value.dart';
import '../../../../core/resources/colors_and_styles.dart';
import '../../../../core/widgets/flushbar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../category_screen/presentation/categories_screen.dart';
import '../../bloc/auth_cubit.dart';
import '../../bloc/auth_state.dart';
import '../widgets/outline_border.dart';
import 'forget_password.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// TextField controllers
  ///
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// for the forms
  final formKey = GlobalKey<FormState>();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: MediaQuery.of(context).size.height * 0.03,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Make An Account",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                registerBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerBody(BuildContext bContext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Name",
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20),
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                isDense: true,
                errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                prefixIcon: Icon(Icons.person, size: 30),
                border: outlineBorder(borderColor: Colors.grey[100]!),
                focusedBorder: outlineBorder(borderColor: Colors.blue),
                disabledBorder: outlineBorder(),
                errorBorder: outlineBorder(borderColor: Colors.red),
              ),

              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Enter A Name";

                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Email",
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: true,
                errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                prefixIcon: Icon(Icons.email, size: 30),
                border: outlineBorder(borderColor: Colors.grey[100]!),
                focusedBorder: outlineBorder(borderColor: Colors.blue),
                disabledBorder: outlineBorder(),
                errorBorder: outlineBorder(borderColor: Colors.red),
              ),

              validator: validateEmail,
            ),
            SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20),
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
                errorStyle: TextStyle(fontSize: 12, color: Colors.red),
                border: outlineBorder(),
                focusedBorder: outlineBorder(borderColor: Colors.blue),
                disabledBorder: outlineBorder(),
                errorBorder: outlineBorder(borderColor: Colors.red),
                prefixIcon: Icon(
                  Icons.lock,
                  size: MediaQuery.of(context).size.height * 0.03,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                    size: 30,
                  ),
                ),
              ),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return "Empty Password";
                } else if (value!.length < 8) {
                  return "Enter A Valid Pasword";
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            BlocConsumer<AuthCubit, AuthState>(
              buildWhen: (previous, current) =>
                  current.registerState != previous.registerState,
              listenWhen: (previous, current) =>
                  current.registerState != previous.registerState,
              listener: (context, state) async {
                if (state.registerState == StateValue.loaded) {
                  await showSimpleFlushBar(
                    context,
                    "welcome!!",
                    "",
                    Icons.check_circle_outline,
                    successColor,
                  );

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TopicPage()),
                    (Route<dynamic> route) => false,
                  );
                }

                if (state.registerState == StateValue.error) {
                  await showSimpleFlushBar(
                    context,
                    state.registerMessage,
                    "",
                    Icons.error_outline_outlined,
                    errorColor,
                  );
                }
              },
              builder: (context, state) {
                if (state.registerState == StateValue.loading) {
                  return MainButton(name: "", onTap: () {}, isLoading: true);
                } else {
                  return MainButton(
                    name: "Register",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).register(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          age: 20,
                        );
                      }
                    },
                  );
                }
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
