import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../models/profile_model.dart';
import '../../../repositories/home_page_repo.dart';
import '../../../repositories/profile_repository.dart';

part 'follow_card_event.dart';

part 'follow_card_state.dart';

class FollowCardBloc extends Bloc<FollowCardEvent, FollowCardState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();
  final repo = GetIt.I.get<HomePageRepository>();

  FollowCardBloc() : super(FollowCardInitial()) {
    on<LoadFollowCard>(_onLoadFollowCard);
    on<FollowUserEvent>(_onFollowUser);
    on<UndoFollowEvent>(
      (event, emit) => emit(FollowCardLoaded(
        event.card.copyWith(isFollowing: !event.card.isFollowing),
      )),
    );
  }

  FutureOr<void> _onLoadFollowCard(
      LoadFollowCard event, Emitter<FollowCardState> emit) async {
    final card = event.card.copyWith(
        isFollowing: profileRepo
            .getMyCachedProfile()
            .followings
            .contains(event.card.id));
    emit(FollowCardLoaded(card));
  }

  FutureOr<void> _onFollowUser(
      FollowUserEvent event, Emitter<FollowCardState> emit) async {
    if (state is FollowCardLoaded) {
      final cast = state as FollowCardLoaded;
      if (cast.card.isFollowing) {
        repo.unFollowUser(cast.card).catchError((e) {
          add(UndoFollowEvent(cast.card));
        });
      } else {
        repo.followUser(cast.card).catchError((e) {
          add(UndoFollowEvent(cast.card));
        });
      }
      emit(
        FollowCardLoaded(
          cast.card.copyWith(isFollowing: !cast.card.isFollowing),
        ),
      );
    }
  }

}