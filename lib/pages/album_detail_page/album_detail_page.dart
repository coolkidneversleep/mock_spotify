import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockspotify/api/user_api.dart';
import 'package:mockspotify/models/album_detail_model.dart';
import 'package:mockspotify/models/track_list_model.dart';
import 'package:mockspotify/widgets/custom_button.dart';
import 'package:mockspotify/widgets/play_music_button.dart';
import 'package:mockspotify/widgets/track_item.dart';

class AlbumDetailPage extends StatelessWidget {
  const AlbumDetailPage({
    super.key,
    this.albumId,
  });
  static String get path => '/album-detail-page';
  static String get name => 'album-detail_page';

  final String? albumId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: FutureBuilder(
            future: UserAPI.getAlbumDetail(albumId ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final dataList = snapshot.data ??
                    const AlbumDetailModel(
                        id: '',
                        name: '',
                        type: '',
                        releaseDate: '',
                        tracks: TrackListModel(items: []),
                        images: [],
                        artists: []);
                return dataList.id.isEmpty
                    ? const Center(
                        child: Text(
                          'No album found.',
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
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            dataList.images[0].url),
                                        fit: BoxFit.cover)),
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
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                FutureBuilder(
                                                    future:
                                                        UserAPI.getArtistDetail(
                                                            dataList
                                                                .artists[0].id),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return CircleAvatar(
                                                            radius: 8,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    snapshot
                                                                        .data!
                                                                        .images[
                                                                            0]
                                                                        .url));
                                                      } else {
                                                        return const CircleAvatar(
                                                          radius: 8,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        );
                                                      }
                                                    }),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  dataList.artists[0].name,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${dataList.type} . ${dataList.releaseDate.split('-')[0]}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Image.network(
                                          dataList.images[0].url,
                                          height: 200,
                                          width: 200,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          dataList.name,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
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
                          Expanded(
                            child: ListView.builder(
                                itemCount: dataList.tracks.items.length,
                                itemBuilder: (context, index) {
                                  var trackList = dataList.tracks.items;
                                  return TrackItem(
                                    number: index + 1,
                                    name: trackList[index].name,
                                    uri: trackList[index].uri,
                                    artist: trackList[index].artists[0].name,
                                    duration: trackList[index].duration,
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
