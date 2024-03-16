import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockspotify/pages/playlist_detail_page/playlist_detail_page.dart';

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({
    required this.playListId,
    required this.image,
    required this.description,
    required this.name,
  });

  final String playListId;
  final String image;
  final String description;
  final String name;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaylistDetailPage(
                  playlistId: playListId,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
