// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:RioTrip/src/screens/alphabet.dart';
import 'package:RioTrip/src/screens/attarctions/map.dart';
import 'package:RioTrip/src/screens/attarctions/list.dart';
import 'package:RioTrip/src/screens/converter.dart';
import 'package:RioTrip/src/screens/phrasebook.dart';
import 'package:RioTrip/src/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth.dart';
import 'screens/scaffold.dart';
import 'widgets/fade_transition_page.dart';
import 'theme/theme.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

class Bookstore extends StatefulWidget {
  const Bookstore({super.key});

  @override
  State<Bookstore> createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {
  final BookstoreAuth auth = BookstoreAuth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme : appTheme,
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return BookstoreAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: GoRouter(
        refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/splash',
        redirect: (context, state) {
          if (state.uri.toString() == '/') {
            return '/attractions/map';
          }
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return BookstoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/attractions/map') => 0,
                  var p when p.startsWith('/alphabet') => 1,
                  var p when p.startsWith('/phrasebook') => 2,
                  var p when p.startsWith('/converter') => 3,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: child
                  );
                },
                routes: [
                  GoRoute(
                    path: '/attractions/map',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: AttractionsMapScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: '/attractions/list',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: AttractionsListScreen(),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/alphabet',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return AlphabetScreen(
                        onTap: (author) {
                          GoRouter.of(context).go('/alphabet');
                        },
                      );
                    }),
                  );
                },
              ),
              GoRoute(
                path: '/phrasebook',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return PhrasebookScreen(
                        onTap: (author) {
                          GoRouter.of(context).go('/phrasebook');
                        },
                      );
                    }),
                  );
                },
              ),
              GoRoute(
                path: '/converter',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return ConverterScreen(
                        onTap: (author) {
                          GoRouter.of(context).go('/converter');
                        },
                      );
                    }),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/splash',
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  return SplashScreen();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
