import 'package:anilist_flutter/src/core/api/api_helper.dart';
import 'package:anilist_flutter/src/core/api/api_url.dart';
import 'package:anilist_flutter/src/core/errors/exceptions.dart';
import 'package:anilist_flutter/src/features/anime/data/models/anime_model.dart';

import '../../../../core/utils/logger.dart';
import 'anime_local_datasource.dart';

abstract class AnimeRemoteDataSource {
  Future<List<AnimeModel>> fetchAnimeList(String username, String type, List<String> status);
}

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final ApiHelper _helper;
  final AnimeLocalDataSource _localDataSource;

  // const AnimeRemoteDataSourceImpl(this._helper);
  const AnimeRemoteDataSourceImpl(this._helper, this._localDataSource);

  @override
  Future<List<AnimeModel>> fetchAnimeList(String username, String type, List<String> status) async {
    const query = '''
      query GetUserMediaListWithAnimeInfo(\$userName: String, \$type: MediaType, \$status: [MediaListStatus]) {
        MediaListCollection(userName: \$userName, type: \$type, status_in: \$status) { 
          lists {
            entries {
              media {
                id
                title {
                  romaji
                  english
                  native
                }
                type
                format
                status
                episodes
                duration
                source
                studios {
                  nodes {
                    name
                  }
                }
                genres
                popularity
                synonyms
                bannerImage
                coverImage {
                  extraLarge
                  large
                  medium
                  color
                }
                season
                seasonYear
              }
              score
              status
              progress
              repeat
              notes
              startedAt {
                year
                month
                day
              }
              completedAt {
                year
                month
                day
              }
              updatedAt
            }
            name
            status
          }
        }
      }
    ''';

    final variables = {
      'userName': username,
      'type': type,
      'status': status,
    };

    try {
      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.anilistApiUrl,
        data: {'query': query, 'variables': variables},
      );

      // TODO : Remove this log
      // response['data']['MediaListCollection']['lists']
      //     .expand((list) => list['entries'] as Iterable)
      //     .forEach((entry) {
      //   final media = entry['media'];
      //   logger.i('Title: ${media['title']['romaji']}, Score: ${entry['score']}');
      // });
      final data = response['data']['MediaListCollection']['lists']
          .expand((list) => list['entries'] as Iterable)
          .map<AnimeModel>((entry) => AnimeModel.fromJson(entry))
          .toList();

      // Save to local storage
      // await _localDataSource.saveAnimeList(data);

      return data;
    } catch (e) {
      logger.e(e);
      throw ServerException('A error occurred: ${e.toString()}');
    }
  }
}