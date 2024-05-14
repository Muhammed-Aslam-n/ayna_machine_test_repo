import 'package:ayna_machine_test/app_assets.dart';
import 'package:ayna_machine_test/core/component/widgets/fade_in_slide.dart';
import 'package:ayna_machine_test/core/component/widgets/responsive_screen.dart';
import 'package:ayna_machine_test/screens/auth/sign_in_screen.dart';
import 'package:ayna_machine_test/screens/auth/sign_up_screen.dart';
import 'package:ayna_machine_test/widgets/two_part_rich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../home/home_screen.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: ResponsiveScreen(
        mobile: WelcomeScreenDesktopLayout(mobileScreen: true),
        tablet: WelcomeScreenDesktopLayout(
          mobileScreen: false,
        ),
        dekstop: WelcomeScreenDesktopLayout(
          mobileScreen: false,
        ),
      ),
    );
  }
}

class WelcomeScreenMobileLayout extends StatelessWidget {
  const WelcomeScreenMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SignInScreen(
                mobileScreen: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreenDesktopLayout extends StatefulWidget {
  const WelcomeScreenDesktopLayout({super.key, required this.mobileScreen});

  final bool mobileScreen;

  @override
  State<WelcomeScreenDesktopLayout> createState() =>
      _WelcomeScreenDesktopLayoutState();
}

class _WelcomeScreenDesktopLayoutState
    extends State<WelcomeScreenDesktopLayout> {
  bool showSignIn = true;

  changeMainView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: [
          !widget.mobileScreen
              ? Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.blue,
                  child: Center(
                    child: Image.asset(AppAssets.aynaLogoAsset),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: widget.mobileScreen
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showSignIn)
                      SizedBox(
                        width: widget.mobileScreen
                            ? null
                            : MediaQuery.of(context).size.width * 0.25,
                        child: FadeInSlide(
                          duration: 0.4,
                          direction: FadeSlideDirection.ltr,
                          child: BlocProvider<SignInBloc>(
                            create: (context) => SignInBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: const SignInScreen(
                              mobileScreen: false,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (showSignIn)
                      SizedBox(
                        width: widget.mobileScreen
                            ? null
                            : MediaQuery.of(context).size.width * 0.25,
                        child: Center(
                          child: RichTwoPartsText(
                              text1: "Don't have an account? ",
                              text2: 'Sign Up',
                              onTap: changeMainView),
                        ),
                      ),
                    if (!showSignIn)
                      SizedBox(
                        width: widget.mobileScreen
                            ? null
                            : MediaQuery.of(context).size.width * 0.25,
                        child: FadeInSlide(
                          duration: 0.4,
                          direction: FadeSlideDirection.ltr,
                          child: BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: const SignUpScreen(
                              mobileScreen: false,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (!showSignIn)
                      SizedBox(
                        width: widget.mobileScreen
                            ? null
                            : MediaQuery.of(context).size.width * 0.25,
                        child: Center(
                          child: RichTwoPartsText(
                              text1: "Already have an account? ",
                              text2: 'Sign In',
                              onTap: changeMainView),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with TickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     tabController = TabController(initialIndex: 0, length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Align(
//                 alignment: const AlignmentDirectional(20, -1.2),
//                 child: Container(
//                   height: MediaQuery.of(context).size.width,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Theme.of(context).colorScheme.tertiary),
//                 ),
//               ),
//               Align(
//                 alignment: const AlignmentDirectional(-2.7, -1.2),
//                 child: Container(
//                   height: MediaQuery.of(context).size.width / 1.3,
//                   width: MediaQuery.of(context).size.width / 1.3,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Theme.of(context).colorScheme.secondary),
//                 ),
//               ),
//               Align(
//                 alignment: const AlignmentDirectional(2.7, -1.2),
//                 child: Container(
//                   height: MediaQuery.of(context).size.width / 1.3,
//                   width: MediaQuery.of(context).size.width / 1.3,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Theme.of(context).colorScheme.primary),
//                 ),
//               ),
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
//                 child: Container(),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.8,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                         child: TabBar(
//                           controller: tabController,
//                           unselectedLabelColor: Theme.of(context)
//                               .colorScheme
//                               .onBackground
//                               .withOpacity(0.5),
//                           labelColor:
//                               Theme.of(context).colorScheme.onBackground,
//                           tabs: const [
//                             Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: TabBarView(
//                         controller: tabController,
//                         children: [
//                           BlocProvider<SignInBloc>(
//                             create: (context) => SignInBloc(
//                                 userRepository: context
//                                     .read<AuthenticationBloc>()
//                                     .userRepository),
//                             child: const SignInScreen(),
//                           ),
//                           BlocProvider<SignUpBloc>(
//                             create: (context) => SignUpBloc(
//                                 userRepository: context
//                                     .read<AuthenticationBloc>()
//                                     .userRepository),
//                             child: const SignUpScreen(),
//                           ),
//                         ],
//                       ))
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
