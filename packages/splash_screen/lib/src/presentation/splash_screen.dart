import 'dart:async';
import 'package:auth/auth.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:home/home.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen/src/presentation/cubit/splash_cubit.dart';
import 'package:splash_screen/src/presentation/cubit/splash_state.dart';

class BaseSplashScreen extends StatelessWidget {
  const BaseSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit(masterSharedPreferences: di<MasterSharedPreferences>()),
      child: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initData() {
    context.read<SplashCubit>().checkStatusLogin();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state.isLogin){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BaseHomeScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BaseLoginScreen()));
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  icLogo,
                  width: 300,
                ),
              ),
              CircularProgressIndicator(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
