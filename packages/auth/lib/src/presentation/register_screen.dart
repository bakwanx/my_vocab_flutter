import 'package:auth/src/domain/usecase/register_usecase.dart';
import 'package:auth/src/presentation/cubit/register_cubit.dart';
import 'package:auth/src/presentation/cubit/register_state.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';

class BaseRegisterScreen extends StatelessWidget {
  const BaseRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(registerUseCase: di<RegisterUseCase>()),
      child: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  Future<void> registerHandler() async {
    await context.read<RegisterCubit>().register(
      emailController.text,
      passwordController.text,
      fullNameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: InkWell(
          onTap: () {
            CustomDialog.chooseCameraGallery(
                context, context
                .read<RegisterCubit>()
                .choosePhotoProfile);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state.photoProfile != null) {
                      return Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(state.photoProfile!),
                          ),
                        ),
                      );
                    }
                    return Image.asset(
                      icDefaultProfile,
                      height: 150,
                      width: 150,
                    );
                  },
                ),
              ),
              Text(
                'Pilih foto profile',
                style: Typo.small.copyWith(
                  fontWeight: Typo.regular,
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget body() {
      Widget email() {
        return Container(
          margin: const EdgeInsets.only(
            top: 18,
          ),
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: Typo.small.copyWith(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        );
      }

      Widget password() {
        return Container(
          margin: const EdgeInsets.only(
            top: 18,
          ),
          child: Column(
            children: [
              TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: Typo.small.copyWith(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(defaultRadius),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: confirmationPasswordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  labelStyle: Typo.small.copyWith(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(defaultRadius),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
            ],
          ),
        );
      }

      Widget firstName() {
        return Container(
          margin: const EdgeInsets.only(
            top: 18,
          ),
          child: TextFormField(
            controller: fullNameController,
            keyboardType: TextInputType.text,
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: "Nama Lengkap",
              labelStyle: Typo.small.copyWith(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            email(),
            password(),
            firstName(),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(
          top: 70,
          bottom: 20,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            CustomButton(
              height: 50,
              width: maxWidth(context),
              onPressed: registerHandler,
              textButton: "Daftar",
            )
          ],
        ),
      );
    }

    return MyVocabScreen<RegisterCubit, RegisterState>(child: BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.statusRegister) {
          CustomDialog.snackbar(
            context,
            "Register Success",
            Colors.black,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BaseLoginScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            header(),
            body(),
            footer(),
          ],
        ),
      ),
    ));
  }
}

