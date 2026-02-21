// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hello_universe/src/assets.dart';
// import 'package:hello_universe/src/data/apod.dart';
// import 'package:hello_universe/src/features/core/widgets/empty_page.dart';
// import 'package:hello_universe/src/features/image_list/apods_cubit.dart';
// import 'package:hello_universe/src/features/image_list/apods_page_key.dart';
// import 'package:hello_universe/src/features/image_list/presentation/widgets/bottom_loader.dart';
// import 'package:hello_universe/src/features/image_list/presentation/widgets/image_list_item.dart';
// import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
// import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class ApodsScreen extends StatelessWidget {
//   const ApodsScreen({super.key});

//   @override
//   Widget build(BuildContext context) => BlocProvider<ApodsCubit>(
//     create: (context) => context.resolve()..fetchApods(),
//     child: const _Consumer(),
//   );
// }

// class _Consumer extends StatelessWidget {
//   const _Consumer();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text('Hello Universe!')),
//     body: SafeArea(
//       child: BlocBuilder<ApodsCubit, ApodsState>(
//         builder: (context, state) {
//           final apods = state.data?.apodPages;
//           return PagedListView<ApodsPageKey, Apod>(
//             state: PagingState<ApodsPageKey, Apod>(
//               error: state.error,
//               hasNextPage: state.data?.hasNextPage ?? true,
//               isLoading: state is PersistentLoadingCubitState,
//               pages: apods,
//               keys: state.data?.apodPageKeys,
//             ),
//             fetchNextPage: () => context.apodsCubit.fetchApods(),
//             builderDelegate: PagedChildBuilderDelegate(
//               itemBuilder: (_, apod, __) => ImageListItem(apod),
//               firstPageErrorIndicatorBuilder: (context) => EmptyPage(
//                 title: 'Something went wrong\nFailed to load!',
//                 assetsImage: Assets.errorIcon,
//                 actionButton: TextButton(
//                   child: const Text('Try again'),
//                   onPressed: () => context.apodsCubit.refresh(),
//                 ),
//               ),
//               firstPageProgressIndicatorBuilder: (context) =>
//                   const Center(child: CircularProgressIndicator()),
//               newPageErrorIndicatorBuilder: (context) => TextButton(
//                 child: const Text('Retry'),
//                 onPressed: () => context.apodsCubit.refresh(),
//               ),
//               newPageProgressIndicatorBuilder: (context) =>
//                   const BottomLoader(),
//               noItemsFoundIndicatorBuilder: (context) => const EmptyPage(
//                 title: 'There is no Image!',
//                 assetsImage: Assets.noResultIcon,
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

// extension on BuildContext {
//   ApodsCubit get apodsCubit => read();
// }

// extension on ApodsState {
//   Object? get error => switch (this) {
//     PersistentLoadingCubitState() => null,
//     PersistentLoadedCubitState() => null,
//     PersistentErrorCubitState(error: final error) => error,
//   };
// }
