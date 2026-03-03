import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apods_error.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_content.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_cubit.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';

class ApodsListScreen extends StatelessWidget {
  const ApodsListScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ApodsListCubit>(
    create: (context) => context.resolve(),
    child: _Consumer(cacheManager: context.resolve()),
  );
}

class _Consumer extends StatelessWidget {
  const _Consumer({required this.cacheManager});

  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Hello Universe')),
    body: SafeArea(
      child: BlocBuilder<ApodsListCubit, ApodsListState>(
        builder: (context, state) => ApodsListContent(
          apodPages: state.data?.apodPages,
          apodPageKeys: state.data?.apodPageKeys,
          hasNextPage: state.data?.hasNextPage ?? true,
          isLoading: state is PersistentLoadingCubitState,
          error: state.apodsError?.error,
          onFetchNextPage: () => context.apodsCubit.fetchApods(),
          onRetry: () => context.apodsCubit.refresh(),
          onApodTap: (apod) =>
              context.pushNamed(Routes.apodDetailsScreen, extra: apod),
          cacheManager: cacheManager,
        ),
      ),
    ),
  );
}

extension on BuildContext {
  ApodsListCubit get apodsCubit => read();
}

extension on ApodsListState {
  ApodsError? get apodsError => switch (this) {
    PersistentLoadingCubitState() => null,
    PersistentLoadedCubitState() => null,
    PersistentErrorCubitState(error: final error) => error,
  };
}
