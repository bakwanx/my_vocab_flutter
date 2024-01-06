import 'dart:ui';
import 'dart:math' as math show sin, pi;
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:master_data/presentation/base/my_vocab_listener.dart';
import 'package:master_data/presentation/base/my_vocab_state.dart';
import 'package:master_data/presentation/error/error_screen.dart';

class MyVocabScreen<BLOC extends BlocBase<STATE>, STATE extends MyVocabState>
    extends StatelessWidget {
  final Widget child;
  final Widget? loading;
  final Function? onError;
  final Function? actionError;
  final List<String>? exceptionErrors;
  final bool isAutoClearErrorState;
  final bool hardReset;

  const MyVocabScreen({
    super.key,
    required this.child,
    this.loading,
    this.actionError,
    this.onError,
    this.exceptionErrors,
    this.isAutoClearErrorState = true,
    this.hardReset = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<BLOC, STATE>(
      listenWhen: (previous, current) {
        return previous != current && notShowErrorSame(previous, current);
      },
      listener: (_, state) {
        if (state.errorState != null) {
          if (onError != null) {
            onError!();
            return;
          }

          final failure = state.errorState;
          if (exceptionErrors == null) {
            if (failure != null) {
              final bloc = BlocProvider.of<BLOC>(context);
              if (bloc is MyVocabListener) {
                (bloc as MyVocabListener).clearErrorState();
              }
              if (failure is DioException) {
                if(failure.response != null){
                  showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return AlertDialog(
                        title: const Text('Error dialog'),
                        content: Text(
                          failure.response!.data["message"],
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Ok'),
                            onPressed: () {
                              if (isAutoClearErrorState) {
                                final bloc = BlocProvider.of<BLOC>(context);
                                if (bloc is MyVocabListener) {
                                  (bloc as MyVocabListener).clearErrorState();
                                }
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              else if (failure is ServerException) {
                showDialog(
                  context: context,
                  builder: (BuildContext buildContext) {
                    return AlertDialog(
                      title: const Text('Error dialog'),
                      content: Text(
                        failure.message.toString(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Ok'),
                          onPressed: () {
                            if (isAutoClearErrorState) {
                              final bloc = BlocProvider.of<BLOC>(context);
                              if (bloc is MyVocabListener) {
                                (bloc as MyVocabListener).clearErrorState();
                              }
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext buildContext) {
                  return AlertDialog(
                    title: const Text('Error dialog'),
                    content: Text(
                      failure.toString(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Ok'),
                        onPressed: () {
                          if (isAutoClearErrorState) {
                            final bloc = BlocProvider.of<BLOC>(context);
                            if (bloc is MyVocabListener) {
                              (bloc as MyVocabListener).clearErrorState();
                            }
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        }
      },
      child: BlocBuilder<BLOC, STATE>(
        buildWhen: (previous, current) {
          return previous != current && notShowErrorSame(previous, current);
        },
        builder: (ctx, state) {
          return MyVocabLoadingScreen(
            dismissible: false,
            isLoading: state.isLoading ?? false,
            progressIndicator: const AnimationCircle(),
            child: child,
          );
        },
      ),
    );
  }

  String buildErrMsg(String errMsg) {
    return errMsg;
  }

  bool notShowErrorSame(STATE previous, STATE current) {
    return (current.errorState != null
        ? previous.errorState != current.errorState
        : current.errorState == null);
  }
}

class MyVocabLoadingScreen extends StatelessWidget {

  final bool isLoading;
  final double opacity;
  final Color? color;
  final double blurEffectIntensity;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  MyVocabLoadingScreen({
    Key? key,
    required this.isLoading,
    this.opacity = 0.8,
    this.color,
    this.blurEffectIntensity = 0,
    required this.progressIndicator,
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [child];
    if (isLoading) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = Center(child: progressIndicator);
      } else {
        layOutProgressIndicator = Positioned(
          left: offset!.dx,
          top: offset!.dy,
          child: progressIndicator,
        );
      }
      final modal = [
        BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: blurEffectIntensity, sigmaY: blurEffectIntensity),
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(
                dismissible: dismissible,
                color: color ?? Color(0xff163141)),
          ),
        ),
        layOutProgressIndicator,
      ];
      widgetList += modal;
    }
    return Stack(
      alignment: Alignment
          .bottomCenter, //causing slight problems **can restore anytime
      children: widgetList,
    );
  }

}

class AnimationCircle extends StatefulWidget {
  const AnimationCircle({
    Key? key,
    this.color,
    this.size = 65,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<AnimationCircle> createState() => _AnimationCircle();
}

class _AnimationCircle extends State<AnimationCircle>
    with SingleTickerProviderStateMixin {
  static const _itemCount = 12;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(_itemCount, (index) {
            final position = widget.size * .5;
            return Positioned.fill(
              left: position,
              top: position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * index * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: DelayTween(
                        begin: 0.0, end: 1.0, delay: index / _itemCount)
                        .animate(_controller),
                    child: SizedBox.fromSize(
                        size: Size.square(widget.size * 0.15),
                        child: _itemBuilder(index)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
    decoration: BoxDecoration(
        color: widget.color ?? Colors.white, shape: BoxShape.circle),
  );
}

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

