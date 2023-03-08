import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/AuthController.dart';
import 'package:vnatpro2/app/views/constantWidget/ConstantWidget.dart';
import 'package:vnatpro2/app/views/navbar/navbarscreen.dart';
import 'package:vnatpro2/main/utils/AppWidget.dart';
import 'package:vnatpro2/app/views/auth/constant/authConstant.dart';
import 'package:vnatpro2/app/views/auth/widget/authWidget.dart';

class LoginScreen extends StatefulWidget {
  static const url = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  String? username;
  String? password;
  bool autoValidate = false;
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SpinKitDancingSquare(
                      color: Colors.blueAccent,
                    ),
                    Text('Logging You In...'),
                  ],
                )
              : SingleChildScrollView(
                  child: Container(
                    decoration: boxDecoration(
                        radius: spacing_standard,
                        showShadow: true,
                        bgColor: context.scaffoldBackgroundColor),
                    margin: const EdgeInsets.all(spacing_standard_new),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        themeLogo().paddingOnly(
                          left: spacing_standard_new,
                          right: spacing_standard_new,
                          bottom: spacing_standard_new,
                          top: spacing_standard_new,
                        ),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              formField(context, "Username",
                                  controller: usernameController,
                                  prefixIcon: Icons.people,
                                  focusNode: usernameFocus,
                                  textInputAction: TextInputAction.next,
                                  nextFocus: passwordFocus, validator: (value) {
                                return value!.isEmpty
                                    ? "Username Required"
                                    : '';
                              }, onChanged: (val) {
                                username = val;
                              }, onSaved: (String? value) {
                                username = value;
                                setState(() {});
                              }).paddingBottom(spacing_standard_new),
                              formField(
                                context,
                                "Password",
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                isPasswordVisible: passwordVisible,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Password Required"
                                      : '';
                                },
                                focusNode: passwordFocus,
                                onChanged: (val) {
                                  password = val;
                                },
                                onSaved: (String? value) {
                                  password = value;
                                },
                                textInputAction: TextInputAction.done,
                                suffixIconSelector: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                suffixIcon: passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ],
                          ),
                        ).paddingOnly(
                            left: spacing_standard_new,
                            right: spacing_standard_new,
                            top: spacing_standard_new),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            text("Forgot password",
                                    fontFamily: fontMedium,
                                    fontSize: textSizeMedium,
                                    textColor: t12_primary_color)
                                .paddingAll(spacing_standard_new)
                                .onTap(() {}),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            padding: const EdgeInsets.only(
                                top: spacing_standard_new,
                                bottom: spacing_standard_new),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    spacing_standard)),
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              if (username == null || password == null) {
                                displaySnack(
                                  context: context,
                                  label: 'Please Enter All Information',
                                  func: () {},
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                var login = await Provider.of<AuthController>(
                                        context,
                                        listen: false)
                                    .login(username, password);

                                if (login) {
                                  NavbarScreen()
                                      .launch(context, isNewTask: true);
                                } else {
                                  displaySnack(
                                    context: context,
                                    label: 'Something Went Wrong. Please Try Again',
                                    func: () {},
                                  );
                                }
                              }
                            },
                            child: text("Login",
                                textColor: Colors.white,
                                fontFamily: fontMedium),
                          ),
                        ).paddingAll(spacing_standard_new),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
