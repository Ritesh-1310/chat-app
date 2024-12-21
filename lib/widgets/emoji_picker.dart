import 'package:flutter/material.dart';

class EmojiPickerWidget extends StatelessWidget {
  final Function(String) onEmojiSelected;

  const EmojiPickerWidget({Key? key, required this.onEmojiSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emojis = ["😀", "😂", "😍", "😢", "👍", "🙏", "🔥", "😎", "🤔", "🙌"]; // Example emojis

    return Container(
      color: Colors.white,
      height: 250, // Set height for the picker
      child: GridView.builder(
        itemCount: emojis.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onEmojiSelected(emojis[index]),
            child: Center(
              child: Text(
                emojis[index],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}
