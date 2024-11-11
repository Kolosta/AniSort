import 'package:equatable/equatable.dart';

class AnilistUserEntity extends Equatable {
  final int id;
  final String? name;
  final String? about;
  final String? avatar;
  final String? scoreFormat;
  final String? rowOrder;

  const AnilistUserEntity({
    required this.id,
    required this.name,
    required this.about,
    required this.avatar,
    required this.scoreFormat,
    required this.rowOrder,
  });

  @override
  List<Object?> get props => [id, name, about, avatar, scoreFormat, rowOrder];
}
