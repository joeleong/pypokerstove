from pypokerstove import *


def test_Construct():
    heval = HoldemHandEvaluator()
    assert True == heval.usesSuits()
    assert 5 == heval.boardSize()

def test_RankEval():
    heval = HoldemHandEvaluator()
    hand = CardSet("2c3c")
    board = CardSet("2c3c4c")
    poker_eval = heval.evaluateRanks(hand, board)
    assert TWO_PAIR == poker_eval.type()
    assert Rank("3") == poker_eval.majorRank()
    assert Rank("2") == poker_eval.minorRank()
