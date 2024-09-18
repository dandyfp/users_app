import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_app/src/presentation/features/auth/bloc/register/register_bloc.dart';
import 'package:users_app/src/presentation/misc/constant.dart';
import 'package:users_app/src/presentation/misc/methods.dart';
import 'package:users_app/src/presentation/misc/style.dart';
import 'package:users_app/src/presentation/misc/validator.dart';
import 'package:users_app/src/presentation/widgets/button.dart';
import 'package:users_app/src/presentation/widgets/textfield.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool isObscure = true;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
      ),
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                verticalSpace(100),
                Text(
                  'Register',
                  style: blackSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
                verticalSpace(30),
                KTextField(
                  label: 'Name',
                  maxLines: 1,
                  minLines: 1,
                  controller: nameController,
                  borderColor: Colors.black,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: Validator.emailValidator.call,
                  placeholder: 'Enter your name',
                ),
                verticalSpace(10),
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
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return state.when(
                      loaded: (message) {
                        AnimatedSnackBar.material("Success Register",
                                type: AnimatedSnackBarType.success)
                            .show(context);

                        return Button(
                          onPressed: () {
                            context.read<RegisterBloc>().add(
                                  RegisterEvent.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    username: nameController.text,
                                  ),
                                );
                          },
                          child: Center(
                            child: Text(
                              'Register',
                              style:
                                  whiteMediumTextStyle.copyWith(fontSize: 14),
                            ),
                          ),
                        );
                      },
                      loading: () => Button(
                        isLoading: true,
                        isDisabled: true,
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            'Register',
                            style: whiteMediumTextStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      error: (message) => Button(
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            'Register',
                            style: whiteMediumTextStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      initial: () => Button(
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                                RegisterEvent.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: nameController.text,
                                ),
                              );
                        },
                        child: Center(
                          child: Text(
                            'Register',
                            style: whiteMediumTextStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}
