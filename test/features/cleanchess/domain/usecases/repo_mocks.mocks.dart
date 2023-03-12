// Mocks generated by Mockito 5.3.2 from annotations
// in cleanchess/test/features/cleanchess/domain/usecases/repo_mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cleanchess/chess/error/failures.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:lichess_client_dio/lichess_client_dio.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:oauth2/oauth2.dart' as _i6;

import 'repo_mocks.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MLichessRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMLichessRepository extends _i1.Mock
    implements _i3.MLichessRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> authenticate({
    required _i6.AuthorizationCodeGrant? grant,
    required String? stateVerifier,
    required String? redirectUri,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticate,
          [],
          {
            #grant: grant,
            #stateVerifier: stateVerifier,
            #redirectUri: redirectUri,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #authenticate,
            [],
            {
              #grant: grant,
              #stateVerifier: stateVerifier,
              #redirectUri: redirectUri,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #authenticate,
            [],
            {
              #grant: grant,
              #stateVerifier: stateVerifier,
              #redirectUri: redirectUri,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> gainAccessToken({
    required _i6.AuthorizationCodeGrant? grant,
    required Map<String, String>? params,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #gainAccessToken,
          [],
          {
            #grant: grant,
            #params: params,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #gainAccessToken,
            [],
            {
              #grant: grant,
              #params: params,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #gainAccessToken,
            [],
            {
              #grant: grant,
              #params: params,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.User>> getUserProfile() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserProfile,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.User>>.value(
            _FakeEither_0<_i5.Failure, _i7.User>(
          this,
          Invocation.method(
            #getUserProfile,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.User>>.value(
                _FakeEither_0<_i5.Failure, _i7.User>(
          this,
          Invocation.method(
            #getUserProfile,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.User>>);
}