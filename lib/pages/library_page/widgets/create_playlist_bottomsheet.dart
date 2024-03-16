import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockspotify/api/api.dart';
import 'package:mockspotify/api/user_api.dart';

class CreatePlaylistBottomSheet extends HookWidget {
  const CreatePlaylistBottomSheet({super.key, required this.onCreatePlaylist});

  final void Function(String playlistName, String description, bool isPublic)
      onCreatePlaylist;

  static Future show(
    BuildContext context, {
    required void Function(
            String playlistName, String description, bool isPublic)
        onCreatePlaylist,
  }) async {
    return showModalBottomSheet(
      context: context,
      builder: (_) => CreatePlaylistBottomSheet(
        onCreatePlaylist: onCreatePlaylist,
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
    final isPublic = useState(false);
    final playlistNameInput = useTextEditingController();
    final descriptionInput = useTextEditingController();
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            color: const Color.fromARGB(255, 18, 16, 16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 26),
                child: Container(
                  width: 62,
                  height: 5,
                  color: Colors.grey,
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: playlistNameInput,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Playlist Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: descriptionInput,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Playlist Description',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Switch(
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.grey,
                      value: isPublic.value,
                      onChanged: (value) => isPublic.value = value),
                  SizedBox(width: 20),
                  Text(
                    'public',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton(
                onPressed: () async {
                  await UserAPI.createPlaylist(
                      playlistName: playlistNameInput.text,
                      playlistDescription: descriptionInput.text,
                      isPlaylistPublic: isPublic.value);
                  onCreatePlaylist(playlistNameInput.text,
                      descriptionInput.text, isPublic.value);
                  CreatePlaylistBottomSheet.close(context);
                },
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                borderRadius: const BorderRadius.all(Radius.circular(45.0)),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(45)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Create Playlist',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
