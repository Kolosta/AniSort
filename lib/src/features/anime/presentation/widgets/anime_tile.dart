import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
import 'package:flutter/material.dart';
import 'package:anilist_flutter/src/features/anime/data/models/anime_model.dart';

class AnimeTile extends StatelessWidget {
  final AnimeEntity anime;
  final bool isFromCache;

  const AnimeTile({
    Key? key,
    required this.anime,
    this.isFromCache = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isFromCache ? const Icon(Icons.storage) : const Icon(Icons.api),
      title: Text(anime.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status: ${anime.status}'),
          Text('Score: ${anime.score}'),
          Text('Local Score: ${anime.localScore}'),
        ],
      ),
    );
  }
}