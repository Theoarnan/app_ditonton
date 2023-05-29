import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:app_ditonton/presentation/pages/about_page.dart';
import 'package:app_ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({
    super.key,
    required this.content,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggle(),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          double slide = 255.0 * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: [
              buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  Widget buildDrawer() {
    return Column(
      key: const Key('contentDrawer'),
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png',
            ),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          key: const Key('movieListTile'),
          leading: const Icon(Icons.movie_creation_outlined),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, HomeMoviePage.routeName);
            animationController.reverse();
          },
        ),
        ListTile(
          key: const Key('tvListTile'),
          leading: const Icon(Icons.tv),
          title: const Text('Tv Series'),
          onTap: () {
            Navigator.pushNamed(context, HomeTvPage.routeName);
            animationController.reverse();
          },
        ),
        ExpansionTile(
          key: const Key('watchlistListTile'),
          title: const Text('Watchlist'),
          leading: const Icon(Icons.save_alt),
          children: [
            ListTile(
              key: const Key('watchlistMovieListTile'),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
                animationController.reverse();
              },
            ),
            ListTile(
              key: const Key('watchlistTvListTile'),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.routeName);
                animationController.reverse();
              },
            ),
          ],
        ),
        ListTile(
          key: const Key(''),
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            Navigator.pushNamed(context, AboutPage.routeName);
            animationController.reverse();
          },
        ),
      ],
    );
  }
}
