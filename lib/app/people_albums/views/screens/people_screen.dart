import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/people_albums/controllers/fetch_people_bloc/fetch_people_bloc.dart';
import 'package:smart_gallery/app/people_albums/controllers/rename_person_bloc/rename_person_bloc.dart';
import 'package:smart_gallery/app/people_albums/views/widgets/people_empty_widget.dart';
import 'package:smart_gallery/app/people_albums/views/widgets/people_failed_widget.dart';
import 'package:smart_gallery/app/people_albums/views/widgets/people_view.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/controllers/selection/selection_bloc.dart';
import 'package:smart_gallery/core/services/media_share_service.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';
import 'package:smart_gallery/core/widgets/share_bar_widget.dart';
import 'package:smart_gallery/core/widgets/share_options_sheet_widget.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchPeopleBloc>().add(FetchPeople());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchPeopleBloc()..add(FetchPeople()),
        ),
        BlocProvider(create: (context) => RenamePersonBloc()),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RenamePersonBloc, RenamePersonState>(
            listener: (context, state) {
              if (state is RenamePersonLoaded) {
                context.read<FetchPeopleBloc>().add(
                  PersonNameIsUpdated(
                    id: state.person.id,
                    newName: state.person.name,
                  ),
                );
              } else if (state is RenamePersonFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.primaryBackgroundColor,
          appBar: AppBarWidget(
            title: "AI Gallery",
            subtitle: "People",
            icon: Icons.filter_alt_outlined,
            onTap: () {},
          ),
          body: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                color: AppColors.primaryColor,
                backgroundColor: AppColors.accentBackgroundColor,
                child: BlocBuilder<FetchPeopleBloc, FetchPeopleState>(
                  builder: (context, state) {
                    switch (state) {
                      case FetchPeopleLoading():
                        return LoadingWidget();
                      case FetchPeopleLoaded():
                        return BlocBuilder<SelectionBloc, SelectionState>(
                          builder: (context, selectionState) {
                            return PeopleView(
                              people: state.people,
                              isSelecting: selectionState.isSelecting,
                              selectedIds: selectionState.selectedIds,
                              onStartSelecting: (id) {
                                context.read<SelectionBloc>().add(
                                  StartSelecting(id: id),
                                );
                              },
                              onToggleSelected: (id) {
                                context.read<SelectionBloc>().add(
                                  ToggleSelected(id: id),
                                );
                              },
                            );
                          },
                        );
                      case FetchPeopleLoadedEmpty():
                        return PeopleEmptyWidget(
                          image: "assets/images/similar_empty.png",
                          title: "No People Found",
                          subtitle:
                              "Capture new moments or upload your favourite images.",
                        );
                      case FetchPeopleFailed():
                        return PeopleFailedWidget(
                          image: "assets/images/similar_empty.png",
                          title: "Something Went Wrong",
                          subtitle: state.errorMessage,
                          onTryAgain: () => _onRefresh(context),
                        );
                    }
                  },
                ),
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<SelectionBloc, SelectionState>(
            builder: (context, selectionState) {
              if (!selectionState.isSelecting) {
                return const SizedBox.shrink();
              }

              return ShareBarWidget(
                selectedCount: selectionState.selectedIds.length,
                onCancel: () {
                  context.read<SelectionBloc>().add(ClearSelection());
                },
                onShare: () => _share(context, selectionState.selectedIds),
              );
            },
          ),
        ),
      ),
    );
  }

  void _share(BuildContext context, Set<int> selectedIds) {
    final state = context.read<FetchPeopleBloc>().state;
    if (state is! FetchPeopleLoaded) {
      return;
    }

    final selectedPeople = state.people
        .where((person) => selectedIds.contains(person.id))
        .toList();

    ShareOptionsSheetWidget.show(
      context,
      onPicked: () => MediaShareService.shareImages(
        selectedPeople.map((person) => person.image).toList(),
        text: selectedPeople.map((person) => person.name).join(', '),
      ),
    );
  }
}
