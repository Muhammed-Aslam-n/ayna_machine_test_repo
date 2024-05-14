import 'package:ayna_machine_test/core/component/widgets/fade_in_slide.dart';
import 'package:ayna_machine_test/screens/auth/components/auth_widgets.dart';
import 'package:ayna_machine_test/screens/home/home_screen.dart';
import 'package:ayna_machine_test/theme/text_theme_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../widgets/overlay_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool mobileScreen;

  const SignInScreen({super.key, required this.mobileScreen});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController =
      TextEditingController(text: !kDebugMode ? null : 'Aslam123');
  final emailController = TextEditingController(
      text: !kDebugMode ? null : 'aslamnputhanpurayil@gmail.com');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: BlocConsumer<SignInBloc,SignInState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
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
                      text: 'Sign In',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    FadeInSlide(
                      duration: 0.35,
                      direction: FadeSlideDirection.ltr,
                      child: Text(
                        'Email',
                        style: context.tm?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.22,
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
                        style: context.tm?.copyWith(fontWeight: FontWeight.w600),
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
                          actionString: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoadingScreen.instance().show(
                                  context: context, text: 'Signing you up!');

                              context.read<SignInBloc>().add(SignInRequired(
                                  emailController.text, passwordController.text));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is SignInFailure) {
            LoadingScreen.instance().hide();
            showToast(context, state.message ?? 'Something unexpected occurred',
                failure: true);
          }
          if(state is SignInSuccess){
            LoadingScreen.instance().hide();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
