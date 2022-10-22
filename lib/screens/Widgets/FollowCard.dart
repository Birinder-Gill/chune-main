import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/models/profile_model.dart';

import '../../core/bloc/follow_card/follow_card_bloc.dart';

class FollowCard extends StatelessWidget {
  final ProfileModel card;

  const FollowCard(
    this.card, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowCardBloc()..add(LoadFollowCard(card)),
      child: _FollowCardContent(),
    );
  }
}

class _FollowCardContent extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = context.read<FollowCardBloc>();
    return BlocBuilder<FollowCardBloc, FollowCardState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is FollowCardLoaded) {
          final card = state.card;
          return Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12, right: 8),
            child: Container(
                width: 250,
                height: 300,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      AvatarImage(card.image, 35),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        card.username ?? "-/-",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${card.chunesShared} chunes shared',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.blue,
                            ),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(100))),
                        child: TextButton(
                            child: Text(
                                (card.isFollowing ?? false)
                                    ? 'Following'
                                    : 'Follow',
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Theme.of(context)
                                        .secondaryHeaderColor)),
                            onPressed: () {
                              bloc.add(FollowUserEvent(card));
                            }),
                      )
                    ],
                  ),
                )),
          );
        }
        return loader();
      },
    );
  }
}

class AvatarImage extends StatelessWidget {
  final String image;

  final double radius;

  const AvatarImage(this.image, this.radius, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image == null || image.isEmpty
          ? AssetImage('images/chune.jpeg')
          : NetworkImage(
              image,
            ),
      radius: radius,
      backgroundColor: Colors.transparent,
    );
  }
}
