import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockspotify/api/api.dart';
import 'package:mockspotify/api/user_api.dart';
import 'package:mockspotify/pages/home_page/widgets/playlist_item.dart';
import 'package:mockspotify/pages/search_page/search_page.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  static String get path => '/home-page';
  static String get name => 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 16, 16),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 16, 16),
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: () {},
            color: Colors.grey,
          ),
          title: const Text(
            'Mixed for you',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage()));
              },
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.orange,
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: UserAPI.getFeaturePlayList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final dataList = snapshot.data ?? [];
                return dataList.isEmpty
                    ? Column(
                        children: const [
                          Center(
                            child: Text(
                              'No Featured Playlist found.',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : GridView.count(
                        childAspectRatio: 3 / 4,
                        crossAxisCount: 2,
                        children: List.generate(dataList.length, (index) {
                          return PlaylistItem(
                            playListId: dataList[index].id,
                            name: dataList[index].name,
                            image: dataList[index].images[0].url,
                            description: dataList[index].description,
                          );
                        }));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
