import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockspotify/pages/library_page/widgets/selected_playlist_bottom_sheet.dart';

class AddTrackToPlaylistBottomSheet extends HookWidget {
  const AddTrackToPlaylistBottomSheet({
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
      builder: (_) => AddTrackToPlaylistBottomSheet(
        uriTrack: uriTrack,
      ),
      barrierColor: Colors.grey.withOpacity(0.6),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.none,
      routeSettings: const RouteSettings(name: 'AddTrackToPlaylistBottomSheet'),
    );
  }

  static void close(BuildContext context) {
    return Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            color: Color.fromARGB(255, 18, 16, 16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                child: Container(
                  width: 62,
                  height: 5,
                  color: Colors.grey,
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  AddTrackToPlaylistBottomSheet.close(context);
                  SelectedPlaylistBottomSheet.show(context, uriTrack: uriTrack);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.add_rounded,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Text(
                        'Add to Playlist',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
