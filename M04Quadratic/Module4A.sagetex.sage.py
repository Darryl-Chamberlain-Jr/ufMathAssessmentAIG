## -*- encoding: utf-8 -*-

# This file was *autogenerated* from the file /home/archdoc/git-repos/improvedexamgeneration/M04Quadratic/Module4A.sagetex.sage
from sage.all_cmdline import *   # import sage library

_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_7 = Integer(7); _sage_const_6 = Integer(6); _sage_const_5 = Integer(5); _sage_const_4 = Integer(4); _sage_const_9 = Integer(9); _sage_const_8 = Integer(8); _sage_const_138 = Integer(138); _sage_const_121 = Integer(121); _sage_const_22 = Integer(22); _sage_const_23 = Integer(23); _sage_const_20 = Integer(20); _sage_const_21 = Integer(21); _sage_const_26 = Integer(26); _sage_const_19 = Integer(19); _sage_const_24 = Integer(24); _sage_const_25 = Integer(25); _sage_const_134 = Integer(134); _sage_const_42 = Integer(42); _sage_const_118 = Integer(118); _sage_const_47 = Integer(47); _sage_const_84 = Integer(84); _sage_const_81 = Integer(81); _sage_const_27 = Integer(27); _sage_const_153 = Integer(153); _sage_const_64 = Integer(64); _sage_const_13 = Integer(13); _sage_const_12 = Integer(12); _sage_const_11 = Integer(11); _sage_const_10 = Integer(10); _sage_const_17 = Integer(17); _sage_const_16 = Integer(16); _sage_const_15 = Integer(15); _sage_const_14 = Integer(14); _sage_const_33 = Integer(33); _sage_const_18 = Integer(18); _sage_const_36 = Integer(36); _sage_const_98 = Integer(98); _sage_const_79 = Integer(79); _sage_const_141 = Integer(141)## This file (Module4A.sagetex.sage) was *autogenerated* from Module4A.tex with sagetex.sty version 2015/08/26 v3.0-92d9f7a.
import sagetex
_st_ = sagetex.SageTeXProcessor('Module4A', version='2015/08/26 v3.0-92d9f7a', version_check=True)
_st_.current_tex_line = _sage_const_33 
_st_.blockbegin()
try:
 load("../Code/generalPurposeMethods.sage")
 load("../Code/keyGeneration.sage")
except:
 _st_.goboom(_sage_const_36 )
_st_.blockend()
_st_.current_tex_line = _sage_const_42 
_st_.blockbegin()
try:
 moduleNumber = _sage_const_4 
 version = "A"
 problemNumber = _sage_const_16 
 load("../Code/quadratic/quadraticGraphs.sage")
except:
 _st_.goboom(_sage_const_47 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_0 , latex(displayStem1))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_1 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_2 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_3 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_4 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_64 
 _st_.inline(_sage_const_5 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_64 )
try:
 _st_.current_tex_line = _sage_const_79 
 _st_.inline(_sage_const_6 , latex(functionToGraph))
except:
 _st_.goboom(_sage_const_79 )
_st_.current_tex_line = _sage_const_81 
_st_.blockbegin()
try:
 problemNumber = _sage_const_18 
 load("../Code/quadratic/factorLeadingOver1Composite.sage")
except:
 _st_.goboom(_sage_const_84 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_7 , latex(displayStem))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_8 , latex(displayProblem))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_9 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_10 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_11 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_12 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_98 )
try:
 _st_.current_tex_line = _sage_const_98 
 _st_.inline(_sage_const_13 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_98 )
_st_.current_tex_line = _sage_const_118 
_st_.blockbegin()
try:
 problemNumber = _sage_const_19 
 load("../Code/quadratic/solveQuadraticFactorComposites.sage")
except:
 _st_.goboom(_sage_const_121 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_14 , latex(displayStem))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_15 , latex(generalFormTypeTwo))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_16 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_17 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_18 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_19 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_134 )
try:
 _st_.current_tex_line = _sage_const_134 
 _st_.inline(_sage_const_20 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_134 )
_st_.current_tex_line = _sage_const_138 
_st_.blockbegin()
try:
 problemNumber = _sage_const_20 
 load("../Code/quadratic/quadraticFormula.sage")
except:
 _st_.goboom(_sage_const_141 )
_st_.blockend()
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_21 , latex(displayStem))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_22 , latex(problemQuadraticFormula))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_23 , latex(choices[_sage_const_0 ]))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_24 , latex(choices[_sage_const_1 ]))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_25 , latex(choices[_sage_const_2 ]))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_26 , latex(choices[_sage_const_3 ]))
except:
 _st_.goboom(_sage_const_153 )
try:
 _st_.current_tex_line = _sage_const_153 
 _st_.inline(_sage_const_27 , latex(choices[_sage_const_4 ]))
except:
 _st_.goboom(_sage_const_153 )
_st_.endofdoc()

