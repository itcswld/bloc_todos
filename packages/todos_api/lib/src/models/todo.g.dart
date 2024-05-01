// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Todo',
      json,
      ($checkedConvert) {
        final val = Todo(
          title: $checkedConvert('title', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String?),
          desc: $checkedConvert('desc', (v) => v as String? ?? ''),
          isCompleted:
              $checkedConvert('is_completed', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'isCompleted': 'is_completed'},
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'is_completed': instance.isCompleted,
    };
