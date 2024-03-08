import 'package:flutter/material.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({super.key});

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        size: 15,
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
    );
  }
}
