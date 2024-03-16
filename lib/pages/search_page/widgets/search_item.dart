import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../album_detail_page/album_detail_page.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      {required this.albumId,
      required this.image,
      required this.title,
      required this.subtitle});

  final String albumId;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AlbumDetailPage(
                  albumId: albumId,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 47,
              height: 47,
              child: Image.network(
                image,
                width: 47,
                height: 47,
                errorBuilder: (context, error, stackTrace) {
                  return const Placeholder();
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Icon(
                Icons.more_vert,
                size: 16,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}