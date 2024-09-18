import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:users_app/src/presentation/features/auth/bloc/login/login_bloc.dart';
import 'package:users_app/src/presentation/features/auth/pages/register_page.dart';
import 'package:users_app/src/presentation/features/home/pages/home_page.dart';
import 'package:users_app/src/presentation/misc/constant.dart';
import 'package:users_app/src/presentation/misc/methods.dart';
import 'package:users_app/src/presentation/misc/navigator_helper.dart';
import 'package:users_app/src/presentation/misc/style.dart';
import 'package:users_app/src/presentation/misc/validator.dart';
import 'package:users_app/src/presentation/widgets/button.dart';
import 'package:users_app/src/presentation/widgets/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isObscure = true;
bool isLoadingLogin = false;

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      // checkUser();
      setState(() {});
    });
    super.initState();
  }

/*   void checkUser() {
    String? id = AuthDataSource().getInLoggedUser();
    if (id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              setState(() {
                isLoadingLogin = true;
              });
            },
            loaded: (message) {
              setState(() {
                isLoadingLogin = false;
              });

              AnimatedSnackBar.material('Login Success',
                      type: AnimatedSnackBarType.success)
                  .show(context);

              NavigatorHelper.push(context, const HomePage());
            },
            error: (message) {},
          );
        },
        child: ListView(
          children: [
            verticalSpace(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: blackSemiBoldTextStyle.copyWith(fontSize: 20),
                  ),
                  verticalSpace(50),
                  KTextField(
                    label: 'Email',
                    maxLines: 1,
                    minLines: 1,
                    controller: emailController,
                    borderColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validator.emailValidator.call,
                    placeholder: 'Enter your email',
                  ),
                  verticalSpace(10),
                  KTextField(
                    label: 'Password',
                    maxLines: 1,
                    minLines: 1,
                    borderColor: Colors.black,
                    obscure: isObscure,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: Validator.emailValidator.call,
                    placeholder: 'Enter your password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  verticalSpace(30),
                  Button(
                    isLoading: isLoadingLogin,
                    isDisabled: isLoadingLogin,
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginEvent.login(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    child: Center(
                      child: Text(
                        'Login',
                        style: whiteMediumTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: blackMediumTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  verticalSpace(70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account yet? ",
                        style: blackMediumTextStyle.copyWith(fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorHelper.push(context, const RegisterPage());
                        },
                        child: Text(
                          "Register now",
                          style: blackMediumTextStyle.copyWith(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
