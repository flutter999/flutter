import 'package:auto_route/auto_route.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_watch_this/application/auth/auth_bloc.dart';
import 'package:go_watch_this/injection.dart';
import 'package:go_watch_this/presentation/routes/router.gr.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        title: 'My Project',
        debugShowCheckedModeBanner: false,
        builder: router.ExtendedNavigator(router: Router()),
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.black,
          accentColor: Colors.deepOrangeAccent,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
