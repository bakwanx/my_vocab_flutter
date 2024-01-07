import 'package:auth/src/domain/usecase/login_usecase.dart';
import 'package:auth/src/presentation/cubit/login_cubit.dart';

import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class BaseLoginScreen extends StatelessWidget {
  const BaseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(loginUseCase: di<LoginUseCase>()),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginHandle() async {
    await context.read<LoginCubit>().login(
        emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MyVocabScreen<LoginCubit, LoginState>(

      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state.statusLogin){
            Navigator.push(context, MaterialPageRoute(builder: (_) => BaseHomeScreen()));
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: maxHeight(context) * 0.3, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    icLogo,
                    height: maxHeight(context) * 0.3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          'My Vocabulary App',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus di isi';
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password harus di isi';
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: maxWidth(context),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text(
                        'Login',
                        style: Typo.body.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: loginHandle,
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(alignment: Alignment.center, child: Text('v.2.0.3'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
