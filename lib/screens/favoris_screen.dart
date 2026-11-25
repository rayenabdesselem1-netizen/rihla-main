import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/providers/favoris_model.dart';

import '../widgets/destination_card.dart';

class FavorisScreen extends StatelessWidget {
	const FavorisScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final model = context.watch<FavorisModel>();
		final favoris = model.liste;

		if (favoris.isEmpty) {
			return Badge(
				
				child: const Center(
					child: Text('Aucun favori pour le moment'),
				),
			);
		}

		return SafeArea(
				child: ListView(
				  padding: const EdgeInsets.all(8.0),
					children:[
            for (final d in favoris) DestinationCard(key: ValueKey(d.id),destination: d),
          ]
				),
			)
		;
	}
}
