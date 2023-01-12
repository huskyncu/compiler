%{
#include "tag.tab.h"
%}

%%
\n        {}
[ \t]+	  {}
"<or>"	{ return START_OR_TAG; }
"<and>"	{ return START_AND_TAG; }
"<not>"	{ return START_NOT_TAG; }
"<true/>" {return T; }
"<false/>" {return F; }
"</or>" {return END_OR_TAG;}
"</and>" {return END_AND_TAG;}
"</not>" {return END_NOT_TAG;}
.		{ }
%%