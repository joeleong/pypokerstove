%module pypokerstove

%{
#define SWIG_PYTHON_EXTRA_NATIVE_CONTAINERS
#define SWIG_FILE_WITH_INIT
#include "Rank.h"
#include "Card.h"
#include "CardSet.h"
#include "CardDistribution.h"
#include "combinations.h"
#include "PokerEvaluation.h"
#include "PokerHandEvaluator.h"
#include "ShowdownEnumerator.h"
#include "OmahaHighHandEvaluator.h"
#include "HoldemHandEvaluator.h"
using namespace std;
using namespace pokerstove;
%}

%include <std_string.i>
%include <std_vector.i>

%template(CD) std::vector<CardDistribution>;
%template(CD2) std::vector<CardDistribution *>;

/* pop() */
%typemap(out) std::vector<CardDistribution >::value_type {
   $result = SWIG_NewPointerObj(SWIG_as_voidptr(&$1), $descriptor(CardDistribution), 0);
}

/* front(), back(), __getitem__() */
%typemap(out) std::vector<CardDistribution >::value_type & {
   $result = SWIG_NewPointerObj(SWIG_as_voidptr($1), $descriptor(CardDistribution), 0);
}

/*
%typemap(in) std::vector<CardDistribution>::value_type & (std::vector<CardDistribution>::value_type temp) {
    temp = PyLong_AsUnsignedLongLong($input);
    $1 = &temp;
}
*/

%include "Rank.h"
%include "Card.h"
%include "CardSet.h"
%ignore CardDistribution (size_t n);
%include "CardDistribution.h"
%include "combinations.h"
%include "PokerEvaluation.h"
%include "PokerHandEvaluator.h"
%include "ShowdownEnumerator.h"
%feature("notabstract") OmahaHighHandEvaluator;
%include "OmahaHighHandEvaluator.h"
%feature("notabstract") HoldemHandEvaluator;
%include "HoldemHandEvaluator.h"
