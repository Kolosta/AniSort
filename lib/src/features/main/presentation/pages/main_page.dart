import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/blocs/theme/theme_bloc.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../routes/app_route_path.dart';
import '../../../../routes/routes.dart';
import '../../../anime/domain/entities/anime_list_params.dart';

class MainPage extends StatefulWidget {
  final UserEntity user;
  const MainPage({super.key, required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // default index : page search anime

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(user: widget.user),
      AnimeListPage(username: widget.user.username ?? '', type: 'ANIME', status: ['CURRENT']),
      AnilistUserPage(username: widget.user.username ?? ''),
    ]);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final isDarkMode = themeBloc.state.isDarkMode;
    final brightness = Theme.of(context).brightness;

    final List<String> _pageTitles = [
      'Home',
      'anime_list'.tr(),
      'anilist_user_info'.tr(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(
        //       Icons.menu,
        //     ),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                AppRoute.params.name,
                pathParameters: {
                  "user_id": widget.user.userId ?? "",
                  "email": widget.user.email ?? "",
                  "username": widget.user.username ?? "",
                },
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: isDarkMode ? AppColor.secondaryDark : AppColor.secondaryLight,
      //         ),
      //         child: Text(
      //           'Navigation',
      //           style: TextStyle(
      //             color: isDarkMode ? AppColor.onPrimaryDark : AppColor.onPrimaryLight,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Product Page'),
      //         onTap: () {
      //           context.goNamed(
      //             AppRoute.home.name,
      //             pathParameters: {
      //               "user_id": widget.user.userId ?? "",
      //               "email": widget.user.email ?? "",
      //               "username": widget.user.username ?? "",
      //             },
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Show Anilist User'),
      //         onTap: () {
      //           context.pushNamed(
      //             AppRoute.anilistUser.name,
      //             pathParameters: {
      //               'username': widget.user.username ?? '',
      //             },
      //             extra: context,
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.search),
      //         title: const Text('Search Anime'),
      //         onTap: () {
      //           context.pushNamed(
      //             AppRoute.animeList.name,
      //             extra: AnimeListParams(
      //               username: widget.user.username ?? '',
      //               type: 'ANIME',
      //               status: ['DROPPED', 'PAUSED'],
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}