import 'dart:math';

import 'package:cleanchess/core/clean_chess/utilities/style.dart';
import 'package:cleanchess/features/clean_chess/data/models/puzzle_model.dart';
import 'package:cleanchess/features/clean_chess/presentation/blocs/in_game/puzzle_mode_cubit.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/chessboard_interpreter.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/dialogs/pawn_promotion_dialog.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/puzzle_mode/puzzle_bottom_graph.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/puzzle_mode/puzzle_top_stats.dart';
import 'package:cleanchess/features/clean_chess/presentation/widgets/titled_app_bar.dart';
import 'package:cleanchess/injection_container.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

import '../widgets/puzzle_mode/puzzle_message_bar.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  //Colors
  final Color _bottomNavBarBgColor = Colors.grey.shade900;
  final Color _winColor = Colors.green;
  final Color _barColor = Colors.white;
  final Color _loseColor = Colors.red;

  // Sizes
  final double _bottomBarHeigth = 50;
  final double _bottomBarCompletedHeigth = 100;

  PuzzleModel? _puzzle;
  bool _puzzleCompleted(String lastMove) =>
      _puzzle!.moves.length == 1 && lastMove == _puzzle!.moves.first;
  final PuzzleController _controller = PuzzleController();
  int _retries = 0;
  int _hintCount = 0;
  _HintMove _hintMove = _HintMove.highlight;

  List<_PuzzleStreakData> _streak = [];

  @override
  void initState() {
    sl<PuzzleModelCubit>().getRandomPuzzle();
    super.initState();
  }

  // Times
  final Duration _bottomBarAnimation = const Duration(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: _body(),
      title: 'LichessPuzzle',
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        BlocConsumer<PuzzleModelCubit, PuzzleModeState>(
          listener: _topBarListener,
          builder: _topBarBuilder,
        ),
        PuzzleTopStats(
          onGetPuzzle: () => _puzzle!,
          isPuzzleCompleted: (uci) => _puzzleCompleted(uci),
        ),
        Expanded(
          child: Center(
            child: BlocConsumer<PuzzleModelCubit, PuzzleModeState>(
              listener: _chessboardListener,
              builder: _chessboardBuilder,
            ),
          ),
        ),
        BlocBuilder<PuzzleModelCubit, PuzzleModeState>(
          builder: (context, state) {
            return state.maybeWhen(
              pieceMoved: (move) => _bottomBar(_puzzleCompleted(move.uci)),
              orElse: () => _bottomBar(false),
            );
          },
        ),
      ],
    );
  }

  Widget _chessInterpreter() {
    return ChessboardInterpreter(
      controller: _controller,
      onPromotion: (turn) => showPromotionDialog(context, turn),
    );
  }

  Widget _bottomBar(bool puzzleCompleted) {
    return AnimatedContainer(
      duration: _bottomBarAnimation,
      curve: Curves.easeInOut,
      height: puzzleCompleted ? _bottomBarCompletedHeigth : _bottomBarHeigth,
      color: _bottomNavBarBgColor,
      child: Center(
        child: AnimatedCrossFade(
          duration: _bottomBarAnimation,
          crossFadeState: puzzleCompleted
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: _bottomBarShowNextMove(),
          secondChild: _bottomBarGraph(),
        ),
      ),
    );
  }

  Widget _bottomBarShowNextMove() {
    return StatefulBuilder(builder: (context, localSetState) {
      return MaterialButton(
        onPressed: () {
          _hintCount++;
          if (_hintMove == _HintMove.highlight) {
            _controller.highLightHintCell(_puzzle!.moves.first);
            localSetState(() {
              _hintMove = _HintMove.reveal;
            });
          } else {
            final move = _puzzle!.moves.first;
            _controller.forceUserMove(move);
            localSetState(() {
              _hintMove = _HintMove.highlight;
            });
          }
        },
        splashColor: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.tips_and_updates_rounded,
            ),
            width10,
            Text(_hintMove.message),
          ],
        ),
      );
    });
  }

  Widget _bottomBarGraph() {
    return SizedBox(
      height: _bottomBarCompletedHeigth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _bottomBarGraphSolvedText(),
            heigth5,
            Expanded(
              child: _bottomBarChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomBarGraphSolvedText() {
    return SizedBox(
      height: Theme.of(context).textTheme.titleLarge!.fontSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text('Solved ${_streak.length} puzzles in a Row'),
          Align(
            alignment: Alignment.topRight,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${_streak.where((element) => element.win).length}w',
                    style: TextStyle(
                      color: _winColor,
                    ),
                  ),
                  TextSpan(
                    text: ' / ',
                    style: TextStyle(
                      color: _barColor,
                    ),
                  ),
                  TextSpan(
                    text: '${_streak.where((element) => !element.win).length}l',
                    style: TextStyle(
                      color: _loseColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBarChart() {
    final sorted = _streak.toList();
    sorted.sort((a, b) => a.elo < b.elo ? 1 : -1);
    double minElo = sorted.isEmpty ? 0 : sorted.last.elo;
    double maxElo = sorted.isEmpty ? 0 : sorted.first.elo;
    final List<int> puzzlePlayed =
        List.generate(_streak.length, (index) => _streak[index].elo.toInt());
    return PuzzleBottomGraph(
      minElo: minElo,
      maxElo: maxElo,
      ratings: puzzlePlayed,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: _bottomNavBarBgColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shuffle),
          label: 'Shuffle',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          label: 'Share',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_back_ios_new),
          label: 'Back',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward_ios),
          label: 'Forward',
        ),
      ],
      onTap: (value) {
        if (value == 0) {
          setState(() {
            _retries = 0;
            sl<PuzzleModelCubit>().getRandomPuzzle();
          });
        } else if (value == 2) {
          _controller.previousMove();
        } else if (value == 3) {
          _controller.nextMove();
        }
      },
    );
  }

  //#region Builders
  Widget _topBarBuilder(BuildContext context, PuzzleModeState state) {
    return state.maybeMap(
      turnOf: (value) => PuzzleMessageBar(
        // invert the output because the first move is the bot one
        barType: value.side == Side.black ? TopBarType.white : TopBarType.black,
      ),
      pieceMoved: (value) {
        if (_puzzleCompleted(value.move.uci)) {
          return PuzzleMessageBar(
            barType: _hintCount > 0
                ? TopBarType.solvedWithHints
                : _retries == 0
                    ? TopBarType.solvedWithoutHints
                    : TopBarType.solvedInMultipleTries,
          );
        }

        // Validate move and show the right message
        if (value.move.uci == _puzzle!.moves.first) {
          _puzzle!.moves.removeAt(0);
          return const PuzzleMessageBar(barType: TopBarType.rightMove);
        } else {
          return const PuzzleMessageBar(barType: TopBarType.wrongMove);
        }
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _chessboardBuilder(BuildContext context, PuzzleModeState state) {
    return state.maybeMap(
      initial: (_) => SkeletonItem(
        child: Container(),
      ),
      loading: (_) => SkeletonItem(
        child: Container(),
      ),
      orElse: () => _chessInterpreter(),
    );
  }
  //#endregion Builders

  //#region Listeners
  void _topBarListener(BuildContext context, PuzzleModeState state) {
    state.maybeWhen(
      // Callback for a puzzle just loaded
      turnOf: (_) async {
        await Future.delayed(const Duration(seconds: 1));
        final botMove = _puzzle!.moves.removeAt(0);
        _controller.autoPlayMove(botMove);
      },
      // Callback for the user move
      pieceMoved: (move) async {
        if (_puzzleCompleted(move.uci)) return;
        // validate the move
        if (move.uci == _puzzle!.moves.first) {
          // Right move: bot will peroform the next move
          await Future.delayed(const Duration(seconds: 1));
          String botMove = _puzzle!.moves.removeAt(0);
          _controller.autoPlayMove(botMove);
        } else {
          // Wrong move, undo the move and retry
          _retries++;
          await Future.delayed(const Duration(seconds: 1));
          _controller.undoMove();
        }
      },
      orElse: () {},
    );
  }

  void _chessboardListener(BuildContext context, PuzzleModeState state) {
    state.maybeWhen(
      // Callback for a puzzle just loaded
      puzzleLoaded: (puzzle) {
        _puzzle = puzzle;
        _controller.loadFen(puzzle.fen);
      },
      pieceMoved: (move) {
        if (_puzzleCompleted(move.uci)) {
          _controller.setInteractable(false);
          _streak.add(
            _PuzzleStreakData(
                _puzzle!.rating.toDouble(), _retries == 0 && _hintCount < 2),
          );
        }
      },
      orElse: () {},
    );
  }
  //#endregion
}

enum _HintMove {
  highlight('Show next move'),
  reveal('Reveal move');

  const _HintMove(this.message);

  final String message;
}

class _PuzzleStreakData {
  final double elo;
  final bool win;

  _PuzzleStreakData(this.elo, this.win);
}
