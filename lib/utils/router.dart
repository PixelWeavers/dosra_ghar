import 'package:dosra_ghar/views/announcement.dart';
import 'package:dosra_ghar/views/home.dart';
import 'package:dosra_ghar/views/menu.dart';
import 'package:dosra_ghar/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/announcements',
    routes: [
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return const HomePage();
          },
          routes: [
            GoRoute(
                path: '/announcements',
                builder: (context, state) {
                  return HomeScreen();
                },
                parentNavigatorKey: _rootNavigatorKey),
            GoRoute(
                path: '/event',
                builder: (context, state) {
                  return Placeholder();
                },
                parentNavigatorKey: _rootNavigatorKey),
            GoRoute(
                path: '/mess',
                builder: (context, state) {
                  return MenuScreen();
                },
                parentNavigatorKey: _rootNavigatorKey),
            GoRoute(
                path: '/weride',
                builder: (context, state) => const Placeholder(),
                parentNavigatorKey: _rootNavigatorKey),
            GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
                parentNavigatorKey: _rootNavigatorKey)
          ])
    ]);
