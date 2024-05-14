import 'dart:async';
import 'package:ayna_machine_test/theme/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
/// Loading overlay widget to notify of the on going task or operation


typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;
  void show({
    required BuildContext context,
    String text = 'Loading...',
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final colorScheme = Theme.of(context).colorScheme;
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withOpacity(.8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              constraints: BoxConstraints(
                maxWidth: size.width * 0.5
              ),
              margin: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SpinKitFadingCircle(color: colorScheme.primary, size: 60),
                  StreamBuilder<String>(
                    stream: textController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.requireData,
                          textAlign: TextAlign.center,
                          style:
                          context.bl?.copyWith(fontWeight: FontWeight.bold),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
