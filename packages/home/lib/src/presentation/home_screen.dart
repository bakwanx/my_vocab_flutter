import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/material.dart';
import 'package:home/src/domain/usecase/home_usecase.dart';
import 'package:home/src/presentation/cubit/home_cubit.dart';
import 'package:home/src/presentation/cubit/home_state.dart';
import 'package:home/src/presentation/widgets/vocab_item.dart';

class BaseHomeScreen extends StatelessWidget {
  const BaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeUseCase: di<HomeUseCase>()),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initData() async {
    await context.read<HomeCubit>().getVocabs();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBar() {
      return AppBar(
        title: Text(
          "Welcome to your vocab app",
          style: Typo.caption,
        ),
      );
    }

    Widget body() {

      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: ListView.builder(
              itemCount: state.vocabEntities.length,
              itemBuilder: (ctx, index) {
                return VocabItem(
                  vocabEntity: state.vocabEntities[index],
                );
              },
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await initData();
      },
      child: MyVocabScreen<HomeCubit, HomeState>(
        child: Scaffold(
          appBar: appBar(),
          body: body(),
        ),
      ),
    );
  }
}
