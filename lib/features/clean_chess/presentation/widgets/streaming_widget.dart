import 'package:cleanchess/core/clean_chess/utilities/style.dart';
import 'package:cleanchess/features/clean_chess/presentation/blocs/tv_game_stream_cubit.dart';
import 'package:cleanchess/features/clean_chess/presentation/blocs/user_cubit.dart';
import 'package:cleanchess/features/clean_chess/presentation/pages/profile_screen.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/chessboard_interpreter.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/padded_items.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/title_item.dart';
import 'package:cleanchess/injection_container.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichess_client_dio/lichess_client_dio.dart' as lichess;

class StreamingWidget extends StatefulWidget {
  const StreamingWidget({super.key});

  @override
  State<StreamingWidget> createState() => _StreamingWidgetState();
}

class _StreamingWidgetState extends State<StreamingWidget> {
  TvGameStreamCubit get _tvGameStreamBloc => sl<TvGameStreamCubit>();

  @override
  void initState() {
    super.initState();
    _tvGameStreamBloc.startStreaming();
  }

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          [
            PaddedItems(children: [
              BlocBuilder<TvGameStreamCubit,
                  AsyncSnapshot<lichess.LichessTvGameSummary>>(
                bloc: _tvGameStreamBloc,
                builder: (context, state) {
                  return _streamingUserItem(
                    isWhite: false,
                    title: state.data?.data?.blackPlayer?.user?.title,
                    color: Colors.amber,
                    name: state.data?.data?.blackPlayer?.user?.name ??
                        state.data?.data?.blackPlayer?.user?.id ??
                        'Loading info...',
                    userId: state.data?.data?.blackPlayer?.user?.id ?? "",
                    elo: state.data?.data?.blackPlayer?.rating?.toString() ??
                        'Loading...',
                    time: '0:20',
                  );
                },
              ),
            ]),
            heigth5,
            AspectRatio(
              aspectRatio: 1,
              child: BlocBuilder<TvGameStreamCubit,
                  AsyncSnapshot<lichess.LichessTvGameSummary>>(
                bloc: _tvGameStreamBloc,
                builder: (context, state) {
                  final fen = state.data?.data?.fen;

                  return ChessboardInterpreter(
                    setup: fen != null ? Setup.parseFen(fen) : Setup.standard,
                  );
                },
              ),
            ),
            heigth5,
            PaddedItems(
              children: [
                BlocBuilder<TvGameStreamCubit,
                    AsyncSnapshot<lichess.LichessTvGameSummary>>(
                  bloc: _tvGameStreamBloc,
                  builder: (context, state) {
                    return _streamingUserItem(
                      isWhite: true,
                      title: state.data?.data?.whitePlayer?.user?.title,
                      color: Colors.pink,
                      name: state.data?.data?.whitePlayer?.user?.name ??
                          state.data?.data?.whitePlayer?.user?.id ??
                          'Loading info...',
                      userId: state.data?.data?.whitePlayer?.user?.id ?? "",
                      elo: state.data?.data?.whitePlayer?.rating?.toString() ??
                          'Loading...',
                      time: '0:20',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Widget _streamingUserItem({
    required bool isWhite,
    required lichess.Title? title,
    required Color color,
    required String name,
    required String elo,
    required String userId,
    String? time,
  }) =>
      Row(
        children: [
          _teamColorItem(isWhite),
          const SizedBox(width: 10),
          TitleItem(title: title),
          const SizedBox(width: 5),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              state.maybeMap(
                publicData: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user: value.user,
                      ),
                    ),
                  );
                },
                orElse: () {},
              );
            },
            child: InkWell(
              onTap: () {
                sl<UserCubit>().getPublicData(userId: userId);
              },
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            elo,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          //TODO: add flag icon
          const Spacer(),
          if (time != null)
            Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      );

  Widget _teamColorItem(bool isWhite) => CircleAvatar(
        backgroundColor: Colors.white,
        radius: 14,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Image.asset(
            isWhite
                ? 'assets/pieces/flat/white_pawn.png'
                : 'assets/pieces/flat/black_pawn.png',
          ),
        ),
      );
}
