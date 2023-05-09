// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      summaryBalance: json['summaryBalance'] as int,
      balanceHistory: (json['balanceHistory'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'summaryBalance': instance.summaryBalance,
      'balanceHistory': instance.balanceHistory,
    };
