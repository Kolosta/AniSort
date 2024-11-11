import 'package:easy_localization/easy_localization.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/anilist_user_entity.dart';

class AnilistUserModel extends AnilistUserEntity {
  const AnilistUserModel({
    required super.id,
    required String super.name,
    required String super.about,
    required String super.avatar,
    required String super.scoreFormat,
    required String super.rowOrder,
  });

  factory AnilistUserModel.fromJson(Map<String, dynamic> json) {
    try {
      return AnilistUserModel(
        id: json['id'],
        name: json['name'],
        about: json['about'],
        avatar: json['avatar']['medium'],
        scoreFormat: json['mediaListOptions']['scoreFormat'],
        rowOrder: json['mediaListOptions']['rowOrder'],
      );
    } catch (e) {
      throw TypeMismatchException('Type mismatch in AnilistUserModel: ${e.toString()}');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "about": about,
      "avatar": avatar,
      "scoreFormat": scoreFormat,
      "rowOrder": rowOrder,
    };
  }

  AnilistUserModel copyWith({
    int? id,
    String? name,
    String? about,
    String? avatar,
    String? scoreFormat,
    String? rowOrder,
  }) {
    return AnilistUserModel(
      id: id ?? this.id,
      name: name ?? (this.name ?? "undefined".tr()),
      about: about ?? (this.about ?? "undefined".tr()),
      avatar: avatar ?? (this.avatar ?? "undefined".tr()),
      scoreFormat: scoreFormat ?? (this.scoreFormat ?? "undefined".tr()),
      rowOrder: rowOrder ?? (this.rowOrder ?? "undefined".tr()),
    );
  }

  String getScoreFormatText() {
    switch (scoreFormat) {
      case 'POINT_100':
        return '100 Point (55/100)';
      case 'POINT_10_DECIMAL':
        return '10 Point Decimal (5.5/10)';
      case 'POINT_10':
        return '10 Point';
      case 'POINT_5':
        return '5 Star (3/5)';
      case 'POINT_3':
        return '3 Point Smiley :)';
      default:
        return 'Unknown';
    }
  }
}