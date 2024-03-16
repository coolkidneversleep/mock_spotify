import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mockspotify/api/user_api.dart';
import 'package:mockspotify/models/playlist_detail_model.dart';
import 'package:mockspotify/widgets/play_music_button.dart';
import 'package:mockspotify/widgets/track_item.dart';

import '../../api/api.dart';
import '../../models/playlist_track_list_model.dart';
import '../../models/track_list_model.dart';
import '../../widgets/custom_button.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage({super.key, this.playlistId});

  static String get path => '/playlist-detail-page';
  static String get name => 'playlist-detail_page';

  final String? playlistId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: FutureBuilder(
            future: UserAPI.getPlaylistDetail(playlistId ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final dataList = snapshot.data ??
                    const PlaylistDetailModel(
                      id: '',
                      name: '',
                      tracks: PlaylistTrackListModel(items: []),
                      images: [],
                      description: '',
                    );

                return dataList.id.isEmpty
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
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 0, 0, 0),
                                        Color(0xff101010),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    image: dataList.images.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              dataList.images[0].url,
                                            ),
                                            fit: BoxFit.cover)
                                        : null),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CupertinoButton(
                                            child: const Icon(
                                              Icons.arrow_back_ios,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                        CupertinoButton(
                                            child: const Icon(
                                              Icons.search,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.network(
                                          dataList.images.isNotEmpty
                                              ? dataList.images[0].url
                                              : '',
                                          height: 200,
                                          width: 200,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Placeholder(
                                              fallbackWidth: 200,
                                              fallbackHeight: 200,
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          dataList.name,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                              iconData: Icons.download,
                                              onPressed: () {},
                                            ),
                                            CustomButton(
                                              iconData: Icons.playlist_add,
                                              onPressed: () {},
                                            ),
                                            const PlayMusicButton(),
                                            CustomButton(
                                              iconData: Icons.share,
                                              onPressed: () {},
                                            ),
                                            CustomButton(
                                              iconData: Icons.more_vert,
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (dataList.tracks.items.isEmpty)
                            const Text(
                              'No track in this playlist.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: dataList.tracks.items.length,
                                itemBuilder: (context, index) {
                                  var trackList = dataList.tracks.items;
                                  return TrackItem(
                                    number: index + 1,
                                    uri: trackList[index].track.uri,
                                    name: trackList[index].track.name,
                                    artist:
                                        trackList[index].track.artists[0].name,
                                    duration: trackList[index].track.duration,
                                  );
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
            }));
  }
}
