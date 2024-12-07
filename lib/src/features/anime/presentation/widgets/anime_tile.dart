import 'package:flutter/material.dart';
import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
import 'package:anilist_flutter/src/core/utils/logger.dart';

class AnimeTile extends StatelessWidget {
  final AnimeEntity anime;
  final bool isFromCache;

  const AnimeTile({
    super.key,
    required this.anime,
    this.isFromCache = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Local Score (colonne à gauche)
            SizedBox(
              width: 50,
              child: Center(
                child: Text(
                  (anime.localScore + 1).toString(),
                ),
              ),
            ),
            // Image de couverture avec couleur de fond et bords arrondis
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 50,
                minHeight: 50,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Stack(
                  children: [
                    LimitedBox(
                      maxWidth: 50,
                      child: Container(
                        color: anime.getCoverImageColor(),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.network(
                        anime.coverImageMedium,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     Container(
            //       width: 50,
            //       color: anime.getCoverImageColor(),
            //     ),
            //   ],
            // ),


            const SizedBox(width: 16),
            // Informations principales
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${anime.status} | Progress: ${anime.progress}',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}