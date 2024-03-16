import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockspotify/pages/album_detail_page/album_detail_page.dart';
import 'package:mockspotify/pages/home_page/home_page.dart';
import 'package:mockspotify/pages/library_page/library_page.dart';
import 'package:mockspotify/pages/main_home_page/main_home_page.dart';
import 'package:mockspotify/pages/playlist_detail_page/playlist_detail_page.dart';
import 'package:mockspotify/pages/sample_page/sample_page.dart';
import 'package:mockspotify/pages/search_page/search_page.dart';
import 'package:mockspotify/pages/sign_in_page/signin_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const SigninPage(),
      '/callback': (context) => const SigninPage(),
      MainHomePage.path: (context) => const MainHomePage(),
      HomePage.path: (context) => const HomePage(),
      SamplePage.path: (context) => const SamplePage(),
      SearchPage.path: (context) => const SearchPage(),
      AlbumDetailPage.path: (context) => const AlbumDetailPage(),
      PlaylistDetailPage.path: (context) => const PlaylistDetailPage(),
      LibraryPage.path: (context) => const LibraryPage(),
    },
  ));
}
