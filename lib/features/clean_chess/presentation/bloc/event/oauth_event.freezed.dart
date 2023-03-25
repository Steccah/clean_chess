// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OAuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() lichessOAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? lichessOAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? lichessOAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LichessOAuthEvent value) lichessOAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LichessOAuthEvent value)? lichessOAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LichessOAuthEvent value)? lichessOAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OAuthEventCopyWith<$Res> {
  factory $OAuthEventCopyWith(
          OAuthEvent value, $Res Function(OAuthEvent) then) =
      _$OAuthEventCopyWithImpl<$Res, OAuthEvent>;
}

/// @nodoc
class _$OAuthEventCopyWithImpl<$Res, $Val extends OAuthEvent>
    implements $OAuthEventCopyWith<$Res> {
  _$OAuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LichessOAuthEventCopyWith<$Res> {
  factory _$$LichessOAuthEventCopyWith(
          _$LichessOAuthEvent value, $Res Function(_$LichessOAuthEvent) then) =
      __$$LichessOAuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LichessOAuthEventCopyWithImpl<$Res>
    extends _$OAuthEventCopyWithImpl<$Res, _$LichessOAuthEvent>
    implements _$$LichessOAuthEventCopyWith<$Res> {
  __$$LichessOAuthEventCopyWithImpl(
      _$LichessOAuthEvent _value, $Res Function(_$LichessOAuthEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LichessOAuthEvent implements LichessOAuthEvent {
  const _$LichessOAuthEvent();

  @override
  String toString() {
    return 'OAuthEvent.lichessOAuth()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LichessOAuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() lichessOAuth,
  }) {
    return lichessOAuth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? lichessOAuth,
  }) {
    return lichessOAuth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? lichessOAuth,
    required TResult orElse(),
  }) {
    if (lichessOAuth != null) {
      return lichessOAuth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LichessOAuthEvent value) lichessOAuth,
  }) {
    return lichessOAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LichessOAuthEvent value)? lichessOAuth,
  }) {
    return lichessOAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LichessOAuthEvent value)? lichessOAuth,
    required TResult orElse(),
  }) {
    if (lichessOAuth != null) {
      return lichessOAuth(this);
    }
    return orElse();
  }
}

abstract class LichessOAuthEvent implements OAuthEvent {
  const factory LichessOAuthEvent() = _$LichessOAuthEvent;
}
