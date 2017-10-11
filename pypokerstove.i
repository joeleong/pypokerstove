%module pypokerstove

%{
#define SWIG_FILE_WITH_INIT
#include "Rank.h"
#include "Card.h"
#include "CardSet.h"
#include "PokerEvaluation.h"
#include "PokerHandEvaluator.h"
#include "OmahaHighHandEvaluator.h"
#include "HoldemHandEvaluator.h"
using namespace std;
using namespace pokerstove;
%}

%include <std_string.i>
%include "Rank.h"
%include "Card.h"
%include "CardSet.h"
%include "PokerEvaluation.h"
%include "PokerHandEvaluator.h"
%feature("notabstract") OmahaHighHandEvaluator;
%include "OmahaHighHandEvaluator.h"
%feature("notabstract") HoldemHandEvaluator;
%include "HoldemHandEvaluator.h"
