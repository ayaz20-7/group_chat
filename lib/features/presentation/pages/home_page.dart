import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:group_chat/features/presentation/cubit/group/group_cubit.dart';
import 'package:group_chat/features/presentation/cubit/user/user_cubit.dart';
import 'package:group_chat/features/presentation/pages/all_users_page.dart';
import 'package:group_chat/features/presentation/pages/groups_page.dart';
import 'package:group_chat/features/presentation/pages/profile_page.dart';
import 'package:group_chat/features/presentation/widgets/customTabBar.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';
import '../../../app_const.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final TextEditingController _searchTextController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);




  List<Widget> get pages =>
      [
        GroupsPage(uid: widget.uid,query: _searchTextController.text,),
        AllUsersPage(
          uid: widget.uid,
          query: _searchTextController.text,
        ),
        ProfilePage(
          uid: widget.uid,
        )
      ];



  int _currentPageIndex = 0;

  bool _isSearch = false;


  @override
  void dispose() {
    _searchTextController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers();
    BlocProvider.of<GroupCubit>(context).getGroups();
    _searchTextController.addListener(() {
      setState(() {

      });
    });
  }




  _buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 40,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: const Offset(0, 0.50))
      ]),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
          prefixIcon: InkWell(
              onTap: () {
                setState(() {
                  _isSearch = false;
                });
              },
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: primaryColor,
              )),
          hintStyle: const TextStyle(),
        ),
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _isSearch == false ? primaryColor : Colors.transparent,
        title: _isSearch == false
            ? const Text(AppConst.appName)
            : const SizedBox(
          height: 0.0,
          width: 0.0,
        ),
        flexibleSpace: _isSearch == true
            ? _buildSearchField()
            : const SizedBox(
          height: 0.0,
          width: 0.0,
        ),
        actions: _isSearch == false
        ? [
        InkWell(
            onTap: () {
              setState(() {
                _isSearch = true;
              });
            },
            child: const Icon(Icons.search)),
        const SizedBox(
          width: 5,
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                enabled: true,
                child: InkWell(onTap: () {
                  Navigator.pop(context);
                  BlocProvider.of<AuthCubit>(context).loggedOut();

                }, child: const Text("logout")),
              ),
            ];
          },
        ),
        ]
        : [
        ],
      ),
      body: Column(
        children: [
          _isSearch == false
              ? CustomTabBar(
            index: _currentPageIndex,
            tabClickListener: (index) {
              print(index);
              _currentPageIndex = index;
              _pageController.jumpToPage(index);
            },
          )
              : const SizedBox(
            width: 0.0,
            height: 0.0,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (_, index) {
                return pages[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
