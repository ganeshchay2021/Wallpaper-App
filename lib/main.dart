import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaperapp/bloc/wapppaper_bloc.dart';
import 'package:wallpaperapp/repository/repository.dart';
import 'package:wallpaperapp/screens/bottom%20navigation%20bar/ui/botton_navbar.dart'; 
 
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(
  //   DevicePreview( 
  //     enabled: !kReleaseMode,
  //     builder: (context) => MultiRepositoryProvider(
  //       providers: [
  //         RepositoryProvider(
  //           create: (context) => Repository(),
  //         ),
  //       ],
  //       child: const MyApp(),
  //     ), // Wrap your app
  //   ),
  // );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Repository(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WallpaperBloc(repository: Repository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Typography.blackCupertino),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomNavBar(),
      ),
    );
  }
}
