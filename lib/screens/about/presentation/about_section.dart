import 'package:ayna_machine_test/core/component/widgets/responsive_screen.dart';
import 'package:ayna_machine_test/theme/text_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveScreen(
        mobile: MobileAboutScreen(),
        tablet: DesktopAboutScreen(),
        dekstop: DesktopAboutScreen(),
      ),
    );
  }
}

class MobileAboutScreen extends StatelessWidget {
  const MobileAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About',style: context.tl,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                  'Ayna.AI is a top-tier management consulting firm specializing in driving performance improvement and value creation for industrial companies. Led by seasoned professionals from prominent backgrounds in consulting, finance, and industrial leadership, Ayna.AI offers a unique blend of advisory services and on-the-ground execution capabilities.'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  "Ayna.AI's commitment to transparency, data-driven insights, and execution makes them a valuable partner for industrial companies seeking to navigate the complexities of today's market and achieve sustainable growth."),
              const SizedBox(height: 20,),
               Text('Technical specifications',style: context.tm,),
              const SizedBox(height: 20,),
              specificationWidget(
                context,
                section: 'Name',
                specification: 'AynaChat',
              ),
              specificationWidget(
                context,
                section: 'Version',
                specification: '1.0.0',
              ),
              specificationWidget(
                context,
                section: 'Developed by',
                specification: 'Ayna.ai',
              ),
              specificationWidget(
                context,
                section: 'Framework',
                specification: 'Flutter',
              ),specificationWidget(
                context,
                section: 'Our Website',
                specification: 'https://www.ayna.ai/contact-us',
              ),
              specificationWidget(
                context,
                section: 'Support',
                specification: 'supportEmail',
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget specificationWidget(
      BuildContext context, {
        required String section,
        required String specification,
      }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: context.bs?.copyWith(color: Colors.black87),
          ),
          Text(
            specification,
            style: context.bm
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class DesktopAboutScreen extends StatelessWidget {
  const DesktopAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Container(
            height: size.height / 1.2,
            width: size.width / 1.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'About',
                            style: context.dl,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                'Ayna.AI is a top-tier management consulting firm specializing in driving performance improvement and value creation for industrial companies. Led by seasoned professionals from prominent backgrounds in consulting, finance, and industrial leadership, Ayna.AI offers a unique blend of advisory services and on-the-ground execution capabilities.'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                "Ayna.AI's commitment to transparency, data-driven insights, and execution makes them a valuable partner for industrial companies seeking to navigate the complexities of today's market and achieve sustainable growth."),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.035, horizontal: 15),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            specificationWidget(
                              context,
                              section: 'Name',
                              specification: 'AynaChat',
                            ),
                            specificationWidget(
                              context,
                              section: 'Version',
                              specification: '1.0.0',
                            ),
                            specificationWidget(
                              context,
                              section: 'Developed by',
                              specification: 'Ayna.ai',
                            ),
                            specificationWidget(
                              context,
                              section: 'Framework',
                              specification: 'Flutter',
                            ),specificationWidget(
                              context,
                              section: 'Our Website',
                              specification: 'https://www.ayna.ai/contact-us',
                            ),
                            specificationWidget(
                              context,
                              section: 'Support',
                              specification: 'supportEmail',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget specificationWidget(
    BuildContext context, {
    required String section,
    required String specification,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: context.bs?.copyWith(color: Colors.white),
          ),
          Text(
            specification,
            style: context.bm
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
