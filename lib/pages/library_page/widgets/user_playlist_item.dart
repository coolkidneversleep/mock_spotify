import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockspotify/pages/playlist_detail_page/playlist_detail_page.dart';

class UserPlaylistItem extends StatelessWidget {
  const UserPlaylistItem({
    super.key,
    required this.image,
    required this.name,
    required this.id,
  });
  final String image;
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaylistDetailPage(
                  playlistId: id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          children: [
            Image.network(
              image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Placeholder(
                  fallbackWidth: 50,
                  fallbackHeight: 50,
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
