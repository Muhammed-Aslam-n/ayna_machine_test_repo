import 'package:ayna_machine_test/screens/home/home_screen.dart';
import 'package:ayna_machine_test/theme/text_theme_ext.dart';
import 'package:ayna_machine_test/widgets/overlay_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../core/component/widgets/fade_in_slide.dart';
import 'components/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  final bool mobileScreen;

  const SignUpScreen({super.key, required this.mobileScreen});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController =
      TextEditingController(text: !kDebugMode ? null : 'Aslam123');
  final emailController = TextEditingController(
      text: !kDebugMode ? null : 'aslamnputhanpurayil@gmail.com');
  final nameController =
      TextEditingController(text: !kDebugMode ? null : 'Muhammed Aslam N');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: context.ds,
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.ds?.copyWith(color: Colors.grey),
                text: 'Lets ',
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: context.ds?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    FadeInSlide(
                      duration: 0.35,
                      direction: FadeSlideDirection.ltr,
                      child: Text(
                        'Email',
                        style:
                            context.tm?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width - 0.1,
                      child: EmailField(
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInSlide(
                      duration: 0.35,
                      direction: FadeSlideDirection.ltr,
                      child: Text(
                        'Password',
                        style:
                            context.tm?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.22,
                      child: PasswordField(controller: passwordController),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 45,
                        child: AuthButtonWidget(
                          actionString: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUser = MyUser.empty;
                              myUser = myUser.copyWith(
                                email: emailController.text,
                                name: nameController.text,
                              );
                              LoadingScreen.instance().show(context: context,text: 'Signing you in!');

                              setState(() {
                                context.read<SignUpBloc>().add(SignUpRequired(
                                    myUser, passwordController.text));
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is SignUpFailure) {
          LoadingScreen.instance().hide();
          showToast(context, state.errorMessage,failure: true);
        }
        if(state is SignUpSuccess){
          LoadingScreen.instance().hide();
        }
      },
    );
  }
}
