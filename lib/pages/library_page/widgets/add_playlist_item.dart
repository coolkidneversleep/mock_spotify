import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddPlaylistItem extends HookWidget {
  const AddPlaylistItem({
    super.key,
    required this.image,
    required this.name,
    required this.id,
    required this.isAdded,
    required this.onAddPlaylist,
  });
  final String image;
  final String name;
  final String id;
  final bool isAdded;
  final Function(String id) onAddPlaylist;
  @override
  Widget build(BuildContext context) {
    var isChecked = useState(isAdded);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        isChecked.value = !isChecked.value;
        onAddPlaylist(id);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.network(
                    image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Placeholder(
                        fallbackWidth: 40,
                        fallbackHeight: 40,
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
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                  side: const BorderSide(color: Colors.grey),
                  activeColor: Colors.green,
                  checkColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  value: isChecked.value,
                  onChanged: ((value) {
                    isChecked.value = value!;
                    onAddPlaylist(id);
                  })),
            )
          ],
        ),
      ),
    );
  }
}
