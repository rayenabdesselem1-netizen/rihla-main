import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/models/destination.dart';
import 'package:tp3/providers/favoris_model.dart';


class FavoriteButton extends StatelessWidget {
  
  final Destination destination;
  const FavoriteButton({super.key, required this.destination});
  @override
  Widget build(BuildContext context) {
    final favorisModel = context.watch<FavorisModel>();
    final isFavorite = favorisModel.estFavori(destination);

    return IconButton(
      onPressed: () {
        context.read<FavorisModel>().basculer(destination);
      },
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
    );
  }
  
}
