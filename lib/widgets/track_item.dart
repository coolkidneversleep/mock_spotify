import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockspotify/pages/library_page/widgets/add_track_to_playlist_bottom_sheet.dart';

class TrackItem extends StatelessWidget {
  const TrackItem(
      {super.key,
      required this.number,
      required this.name,
      required this.uri,
      required this.artist,
      required this.duration});
  final int number;
  final String name;
  final String uri;
  final String artist;
  final int duration;
  @override
  Widget build(BuildContext context) {
    getDuration(int duration) {
      var durationInMinute = duration / 60000;
      return durationInMinute.toStringAsFixed(2);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  number.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        '$artist · ${getDuration(duration)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          CupertinoButton(
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                AddTrackToPlaylistBottomSheet.show(context, uriTrack: uri);
              })
        ],
      ),
    );
  }
}
