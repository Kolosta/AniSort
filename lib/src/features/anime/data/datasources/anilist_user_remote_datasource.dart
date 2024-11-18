import 'package:anilist_flutter/src/core/utils/logger.dart';
import 'package:anilist_flutter/src/features/anime/data/models/models.dart';
import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exceptions.dart';

sealed class AnilistUserRemoteDataSource {
  Future<AnilistUserModel> fetchAnilistUser(String username);
}

class AnilistUserRemoteDataSourceImpl implements AnilistUserRemoteDataSource {
  final ApiHelper _helper;

  const AnilistUserRemoteDataSourceImpl(this._helper);

  @override
  Future<AnilistUserModel> fetchAnilistUser(String username) => fetchUserFromApi(username);


  Future<AnilistUserModel> fetchUserFromApi(String username) async {
    const query = '''
      query GetUserInfo(\$username: String) {
        User(search: \$username) {
          id
          name
          about
          avatar {
            medium
          }
          mediaListOptions {
            scoreFormat
            rowOrder
          }
        }
      }
    ''';

    final variables = {'username': username};

    try {
      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.anilistApiUrl,
        data: {'query': query, 'variables': variables},
      );

      return AnilistUserModel.fromJson(response['data']['User']);
    } on TypeMismatchException catch (e) {
      throw TypeMismatchException(e.message);
    } catch (e) {
      throw ServerException('A error occurred: ${e.toString()}');
    }
  }
}