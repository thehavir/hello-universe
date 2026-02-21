import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/presentation/apods_content.dart';
import 'package:hello_universe/src/presentation/apods_cubit.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';

class ApodsScreen extends StatelessWidget {
  const ApodsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ApodsCubit>(
    create: (context) => context.resolve(),
    child: const _Consumer(),
  );
}

class _Consumer extends StatelessWidget {
  const _Consumer();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Hello Universe!')),
    body: SafeArea(
      child: BlocBuilder<ApodsCubit, ApodsState>(
        builder: (context, state) => ApodsContent(
          apodPages: state.data?.apodPages,
          apodPageKeys: state.data?.apodPageKeys,
          hasNextPage: state.data?.hasNextPage ?? true,
          isLoading: state is PersistentLoadingCubitState,
          error: state.apodsError?.error,
          onFetchNextPage: () => context.apodsCubit.fetchApods(),
          onRetry: () => context.apodsCubit.refresh(),
          onApodTap: (apod) =>
              context.pushNamed(Routes.imageDetails, extra: apod),
        ),
      ),
    ),
  );
}

extension on BuildContext {
  ApodsCubit get apodsCubit => read();
}

extension on ApodsState {
  ApodsError? get apodsError => switch (this) {
    PersistentLoadingCubitState() => null,
    PersistentLoadedCubitState() => null,
    PersistentErrorCubitState(error: final error) => error,
  };
}
