import 'package:flutter/material.dart';
import 'package:group_chat/features/domain/entities/user_entity.dart';
import 'package:group_chat/features/presentation/widgets/profile_widget.dart';

class SingleItemStoriesStatusWidget extends StatelessWidget {
  final UserEntity user;

  const SingleItemStoriesStatusWidget({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: profileWidget(imageUrl: user.profileUrl),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        user.status==""?"Hi! I'm using this app":user.status,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60,right: 10),
            child: Divider(thickness: 1.50,),
          ),
        ],
      ),
    );
  }}