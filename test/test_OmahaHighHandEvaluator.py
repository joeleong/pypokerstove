from pypokerstove import *

def test_Construct():
    oeval = OmahaHighHandEvaluator()
    assert True == oeval.usesSuits()
    assert 5 == oeval.boardSize()

def test_RankEval():
    oeval = OmahaHighHandEvaluator()
    hand = CardSet("2c3c")
    board = CardSet("2c3c4c")
    poker_eval = oeval.evaluateRanks(hand, board)
    assert TWO_PAIR == poker_eval.type()
    assert Rank("3") == poker_eval.majorRank()
    assert Rank("2") == poker_eval.minorRank()
