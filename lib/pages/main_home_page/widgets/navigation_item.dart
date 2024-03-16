import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem(
      {super.key,
      required this.onpressed,
      required this.icon,
      required this.selectedIcon,
      required this.isSelected,
      required this.name});
  final void Function() onpressed;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final String name;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.onpressed,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Icon(
            widget.isSelected ? widget.selectedIcon : widget.icon,
            size: 20,
            color: widget.isSelected ? Colors.white : Colors.grey,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget.name,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
