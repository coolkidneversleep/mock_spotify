import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mockspotify/api/api.dart';
import 'package:mockspotify/api/user_api.dart';
import 'package:mockspotify/models/playlist_model.dart';
import 'package:mockspotify/pages/library_page/widgets/create_playlist_bottomsheet.dart';
import 'package:mockspotify/pages/library_page/widgets/user_playlist_item.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  static String get path => '/library-page';
  static String get name => 'library_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 18, 16, 16),
        leading: CupertinoButton(
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CupertinoButton(
            child: const Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              CreatePlaylistBottomSheet.show(context,
                  onCreatePlaylist: (playlistName, description, isPublic) {});
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 18, 16, 16),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: FutureBuilder(
          future: UserAPI.getUserPlayList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final userPlaylists = snapshot.data ?? [];
              return userPlaylists.isEmpty
                  ? const Center(
                      child: Text(
                        'No playlist found.',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Playlists',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: userPlaylists.length,
                              itemBuilder: (context, index) {
                                var playListImage = userPlaylists[index].images;
                                return UserPlaylistItem(
                                    image: playListImage.isEmpty
                                        ? ''
                                        : playListImage[0].url,
                                    name: userPlaylists[index].name,
                                    id: userPlaylists[index].id);
                              }),
                        )
                      ],
                    );
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
          },
        ),
      ),
    );
  }
}
