## -*- encoding: utf-8 -*-

# This file was *autogenerated* from the file /media/archdoc/7636-BC29/improvedExamGeneration/M06Polynomials/Module6MU.sagetex.sage
from sage.all_cmdline import *   # import sage library

_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_7 = Integer(7); _sage_const_6 = Integer(6); _sage_const_5 = Integer(5); _sage_const_4 = Integer(4); _sage_const_117 = Integer(117); _sage_const_9 = Integer(9); _sage_const_8 = Integer(8); _sage_const_29 = Integer(29); _sage_const_22 = Integer(22); _sage_const_23 = Integer(23); _sage_const_20 = Integer(20); _sage_const_21 = Integer(21); _sage_const_26 = Integer(26); _sage_const_27 = Integer(27); _sage_const_24 = Integer(24); _sage_const_25 = Integer(25); _sage_const_42 = Integer(42); _sage_const_65 = Integer(65); _sage_const_62 = Integer(62); _sage_const_47 = Integer(47); _sage_const_112 = Integer(112); _sage_const_80 = Integer(80); _sage_const_68 = Integer(68); _sage_const_114 = Integer(114); _sage_const_13 = Integer(13); _sage_const_12 = Integer(12); _sage_const_11 = Integer(11); _sage_const_10 = Integer(10); _sage_const_17 = Integer(17); _sage_const_16 = Integer(16); _sage_const_15 = Integer(15); _sage_const_14 = Integer(14); _sage_const_30 = Integer(30); _sage_const_19 = Integer(19); _sage_const_18 = Integer(18); _sage_const_34 = Integer(34); _sage_const_37 = Integer(37); _sage_const_98 = Integer(98); _sage_const_101 = Integer(101); _sage_const_128 = Integer(128); _sage_const_95 = Integer(95)## This file (Module6MU.sagetex.sage) was *autogenerated* from Module6MU.tex with sagetex.sty version 2015/08/26 v3.0-92d9f7a.
import sagetex
_st_ = sagetex.SageTeXProcessor('Module6MU', version='2015/08/26 v3.0-92d9f7a', version_check=True)
_st_.current_tex_line = _sage_const_34 
_st_.blockbegin()
try:
 load("../Code/generalPurposeMethods.sage")
 load("../Code/keyGeneration.sage")
except:
 _st_.goboom(_sage_const_37 )
_st_.blockend()
_st_.current_tex_line = _sage_const_42 
_st_.blockbegin()
try:
 version = "MU"
 moduleNumber = _sage_const_6 
 problemNumber = _sage_const_26 
 load("../Code/polynomial/polyGraphToFunction.sage")
except:
 _st_.goboom(_sage_const_47 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_0 , latex(displayStem))
except:
 _st_.goboom(_sage_const_62 )
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_1 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_62 )
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_2 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_62 )
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_3 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_62 )
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_4 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_62 )
try:
 _st_.current_tex_line = _sage_const_62 
 _st_.inline(_sage_const_5 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_62 )
_st_.current_tex_line = _sage_const_65 
_st_.blockbegin()
try:
 problemNumber = _sage_const_27 
 load("../Code/polynomial/polyEndAndZeroBehavior.sage")
except:
 _st_.goboom(_sage_const_68 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_80 
 _st_.inline(_sage_const_6 , latex(displayStem1))
except:
 _st_.goboom(_sage_const_80 )
try:
 _st_.current_tex_line = _sage_const_80 
 _st_.inline(_sage_const_7 , latex(displayPolynomial))
except:
 _st_.goboom(_sage_const_80 )
try:
 _st_.current_tex_line = _sage_const_95 
 _st_.inline(_sage_const_8 , latex(zeroOnDisplay))
except:
 _st_.goboom(_sage_const_95 )
try:
 _st_.current_tex_line = _sage_const_95 
 _st_.inline(_sage_const_9 , latex(displayPolynomial))
except:
 _st_.goboom(_sage_const_95 )
_st_.current_tex_line = _sage_const_98 
_st_.blockbegin()
try:
 problemNumber = _sage_const_29 
 load("../Code/polynomial/constructPolyRationals.sage")
except:
 _st_.goboom(_sage_const_101 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_10 , latex(displayStem))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_11 , latex(displayZero1))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_12 , latex(displayZero2))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_13 , latex(displayZero3))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_14 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_15 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_16 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_17 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_112 )
try:
 _st_.current_tex_line = _sage_const_112 
 _st_.inline(_sage_const_18 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_112 )
_st_.current_tex_line = _sage_const_114 
_st_.blockbegin()
try:
 problemNumber = _sage_const_30 
 load("../Code/polynomial/constructPolyComplex.sage")
except:
 _st_.goboom(_sage_const_117 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_19 , latex(displayStem))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_20 , latex(displayZero1))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_21 , latex(displayZero2))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_22 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_23 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_24 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_25 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_128 )
try:
 _st_.current_tex_line = _sage_const_128 
 _st_.inline(_sage_const_26 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_128 )
_st_.endofdoc()
