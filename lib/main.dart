///To God be the Glory

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/auth_flow/app/app.dart';
import 'package:newapp/core/bloc/login/login_bloc.dart';
import 'package:newapp/core/bloc/music_player/music_player_bloc.dart';
import 'package:newapp/screens/LoginScreens/CreateUsername.dart';
import 'package:newapp/screens/LoginScreens/Login.dart';
import 'package:newapp/screens/splash_screen.dart';
import 'package:newapp/services/injector.dart';
import 'package:newapp/spotify_main.dart';
import 'apple_music.dart';
import 'core/bloc/profile/profile_bloc.dart';
import 'screens/NavScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  await Injector.init(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => MusicPlayerBloc(),
        ),
        BlocProvider(
          create: (_) => AppBloc(
            authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
          ),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white)) ,
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent.shade100)),
            errorStyle: TextStyle(color: Colors.white,backgroundColor: Colors.red),


          ),
            primarySwatch: Colors.pink, secondaryHeaderColor: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
