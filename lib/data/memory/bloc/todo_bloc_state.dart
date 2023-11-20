import 'package:fast_app_base/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/data/memory/vo/todo_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_bloc_state.freezed.dart';

@freezed
class TodoBlocState with _$TodoBlocState {
  const factory TodoBlocState({
    required List<Todo> todoList,
    required BlocStatus status,
  }) = _TodoBlocState;
}
