import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final String author;
  final String comment;
  final String time;

  const CommentTile({
    super.key,
    required this.author,
    required this.comment,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF033941).withOpacity(0.1),
        child: Text(
          author[0],
          style: const TextStyle(color: Color(0xFF033941)),
        ),
      ),
      title: Text(
        author,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF033941)),
      ),
    subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(comment),
    const SizedBox(height: 4),
    Text(
    time,
    style: const TextStyle(
    fontSize: 12,
    color: Colors.grey,
    ),
    ),
    ],
    ),
    );
  }
}