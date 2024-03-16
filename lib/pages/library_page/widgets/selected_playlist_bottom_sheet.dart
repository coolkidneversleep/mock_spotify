import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockspotify/api/user_api.dart';
import 'package:mockspotify/pages/library_page/widgets/add_playlist_item.dart';

class SelectedPlaylistBottomSheet extends HookWidget {
  const SelectedPlaylistBottomSheet({
    super.key,
    required this.uriTrack,
  });

  final String uriTrack;

  static Future show(
    BuildContext context, {
    required String uriTrack,
  }) async {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SelectedPlaylistBottomSheet(
        uriTrack: uriTrack,
      ),
      barrierColor: Colors.grey.withOpacity(0.6),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.none,
      routeSettings: const RouteSettings(name: 'EditProfileAvatarBottomSheet'),
    );
  }

  static void close(BuildContext context) {
    return Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var selectedPlaylistId = useState('');
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        color: const Color.fromARGB(255, 18, 16, 16),
      ),
      child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 26),
              child: Container(
                width: 62,
                height: 5,
                color: Colors.grey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text(
                'Add to Playlist',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            FutureBuilder(
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
                      : Expanded(
                          child: ListView.builder(
                              itemCount: userPlaylists.length,
                              itemBuilder: (context, index) {
                                var playListImage = userPlaylists[index].images;
                                return AddPlaylistItem(
                                    isAdded: userPlaylists[index].id ==
                                        selectedPlaylistId.value,
                                    onAddPlaylist: (id) {
                                      selectedPlaylistId.value = id;
                                    },
                                    image: playListImage.isEmpty
                                        ? ''
                                        : playListImage[0].url,
                                    name: userPlaylists[index].name,
                                    id: userPlaylists[index].id);
                              }),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              },
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          left: (MediaQuery.of(context).size.width - 100) / 2,
          child: CupertinoButton(
            onPressed: () {
              var uriTrackList = <String>[];
              uriTrackList.add(uriTrack);
              UserAPI.addTrackToPlaylist(
                  selectedPlaylistId.value, uriTrackList);
              SelectedPlaylistBottomSheet.close(context);
            },
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            borderRadius: const BorderRadius.all(Radius.circular(45.0)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(45)),
              child: const Text(
                'Done',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
