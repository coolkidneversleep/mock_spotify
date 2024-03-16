import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSearchTextField extends HookWidget {
  const CustomSearchTextField({
    super.key,
    this.decoration,
    this.onTap,
    this.inputController,
    this.onChanged,
    this.onSubmitted,
    this.style,
    this.hintText = 'Search',
    this.hintTextStyle,
    this.prefixIcon,
    this.autofocus = true,
    this.onEditingComplete,
    this.inputFormatters,
    this.keyboardType,
    this.onClear,
    this.initText,
  }) : assert((inputController != null && initText == null) ||
            (inputController == null && initText != null) ||
            (inputController == null && initText == null));

  final TextEditingController? inputController;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final bool autofocus;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final VoidCallback? onClear;
  final String? initText;

  @override
  Widget build(BuildContext context) {
    final controller =
        inputController ?? useTextEditingController(text: initText);
    final searchText = useState(controller.text);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 33,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey,
              inputFormatters: inputFormatters,
              autofocus: autofocus,
              controller: controller,
              onChanged: (value) {
                searchText.value = value;
                onChanged?.call(value);
              },
              onSubmitted: onSubmitted,
              onEditingComplete: onEditingComplete,
              style: style ??
                  const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
              decoration: decoration ??
                  InputDecoration(
                      fillColor: const Color.fromARGB(255, 57, 55, 55),
                      filled: true,
                      hintText: hintText,
                      hintStyle: hintTextStyle ??
                          const TextStyle(
                            height: 2.7,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 57, 55, 55),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 57, 55, 55),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 57, 55, 55),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedErrorBorder: InputBorder.none,
                      suffixIcon: searchText.value == ''
                          ? null
                          : CupertinoButton(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              onPressed: () {
                                searchText.value = '';
                                controller.clear();
                                onClear?.call();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 24,
                              ),
                            )),
              keyboardType: keyboardType,
              onTap: onTap,
            ),
          ),
        ),
        const SizedBox(width: 14),
        CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.zero,
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 57, 55, 55),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.keyboard_voice,
                size: 20,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
