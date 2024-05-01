import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  final String id;
  final String title;
  final String desc;
  final bool isCompleted;
  Todo({
    required this.title,
    String? id,
    this.desc = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  Todo copyWith({
    String? id,
    String? title,
    String? desc,
    bool? isCompleted,
  }) =>
      Todo(
        title: title ?? this.title,
        id: id ?? this.id,
        desc: desc ?? this.desc,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  //Deserializes
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);
  //Serialize
  JsonMap toJson() => _$TodoToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, desc, isCompleted];
}
