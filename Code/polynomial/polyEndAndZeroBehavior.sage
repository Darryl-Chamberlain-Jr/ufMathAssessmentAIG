import random
from sympy import *
import numpy

#load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
# OBJECTIVE 2 - Identify the end behavior and zero behavior of a polynomial equation

# behaviorOfPolynomial = a*(factor1[0]*x+factor1[1])**factor1[2] *(factor1[0]*x-factor1[1])**(factor1[2]+1) *(factor2[0]*x+factor2[1])**factor2[2]*(factor2[0]*x+factor2[1])**(factor2[2]+1)
# This allows us to see if they know which factor is correct.

def generateFactor():
    a = 1
    b = maybeMakeNegative(random.randint(2, 9))
    c = random.randint(2, 5)
    return [a, b, c]

def listZeros(factor1, factor2):
    z1 = factor1[1]
    z2 = - factor1[1]
    z3 =  factor2[1]
    z4 = - factor2[1]
    return [z1, z2, z3, z4]

def displayFactor(a):
    if a == 0:
        factor = "x"
    elif a < 0:
        factor = "x + %d" %-a
    else:
        factor = "x - %d" %a
    return factor

def checkValue(a, zeros, exponents, check):
    a0, b0, c0, d0 = zeros
    ae, be, ce, de = exponents
    value = float(a * (check - a0)**ae * (check - b0)**be * (check - c0)**ce * (check -d0)**de)
    return value

#def displayFactor(a, b):
#    if b < 0:
#        factor = "%d x - %d" %(a, -b)
#    else:
#        factor = "%d x + %d" %(a, b)
#    return factor

leadingCoefficient = Integer(maybeMakeNegative(random.randint(2, 9)))
factor1 = generateFactor()
factor2 = generateFactor()

while (abs(factor1[1]) == abs(factor2[1])):
    factor1 = generateFactor()
    factor2 = generateFactor()

chooseZero = random.randint(0, 1)

if (chooseZero==0):
    zeroOnDisplay = -factor1[1]
else:
    zeroOnDisplay = -factor2[1]

# Makes sure the conjugate of the zero on display has opposite multiplicity of the zero on display.
if (chooseZero == 0):
    e0 = factor1[2]
    e1 = factor1[2] + 2*random.randint(1, 3)-1
    e2 = factor2[2]
    e3 = factor2[2] + random.randint(0, 2)
    expoenentOnDisplay = e0
else:
    e0 = factor1[2]
    e1 = factor1[2] + random.randint(0, 2)
    e2 = factor2[2]
    e3 = factor2[2] + 2*random.randint(1, 3)-1
    expoenentOnDisplay = e2

firstTerm = (x+factor1[1])**e0
secondTerm = (x-factor1[1])**e1
thirdTerm = (x+factor2[1])**e2
fourthTerm = (x-factor2[1])**e3

behaviorOfPolynomial = leadingCoefficient*( firstTerm * secondTerm * thirdTerm * fourthTerm )

displayPolynomial = leadingCoefficient * (x+factor1[1])**e0 *(x-factor1[1])**e1 *(x+factor2[1])**e2 *(x-factor2[1])**e3
displayPolyForKey = "f(x) = %s(%s)^{%d}(%s)^{%d}(%s)^{%d}(%s)^{%d}" %(leadingCoefficient, displayFactor(-factor1[1]), e0, displayFactor(factor1[1]), e1, displayFactor(-factor2[1]), e2, displayFactor(factor2[1]), e3)

displayStem1 = 'Choose the end behavior of the polynomial below.'
displayProblem1 = behaviorOfPolynomial

if ((e0 + e1 + e2 + e3) % 2 == 0):
    if leadingCoefficient > 0:
        answerFigureName = "endBehaviorPositiveEven"
    else:
        answerFigureName = "endBehaviorNegativeEven"
else:
    if leadingCoefficient > 0:
        answerFigureName = "endBehaviorPositiveOdd"
    else:
        answerFigureName = "endBehaviorNegativeOdd"

figureNames = ["endBehaviorNegativeOdd", "endBehaviorNegativeEven", "endBehaviorPositiveEven", "endBehaviorPositiveOdd"]

print 'Stem 1: %s' %displayStem1
print 'Problem 1: %s' %displayProblem1
#print 'Solution 1: %s' %displaySolution1
generalComments = "General Comments: Remember that end behavior is determined by the leading coefficient AND the sum of the multiplicities."
choiceComments = ["Negative leading coefficient, sum of degrees is odd.", "Negative leading coefficient, sum of degrees is even.", "Positive leading coefficient, sum of degrees is even.", "Positive leading coefficient, sum of degrees is odd."]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem1, displayPolyForKey)
writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, answerFigureName, figureNames, choiceComments)
#writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution1, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

problemNumber = problemNumber + 1

zeros = [-factor1[1], factor1[1], -factor2[1], factor2[1]]
exponents = [e0, e1, e2, e3]
check = float(zeroOnDisplay - 1)
value = checkValue(leadingCoefficient, zeros, exponents, check)

if value < 0 and expoenentOnDisplay % 2 == 0:
    answerFigureName = "zeroBehaviorNegativeEven"
elif value > 0 and expoenentOnDisplay % 2 == 0:
    answerFigureName = "zeroBehaviorPositiveEven"
elif value <  0 and expoenentOnDisplay % 2 == 1:
    answerFigureName = "zeroBehaviorPositiveOdd"
else:
    answerFigureName = "zeroBehaviorNegativeOdd"

figureNames = ["zeroBehaviorNegativeOdd", "zeroBehaviorNegativeEven", "zeroBehaviorPositiveEven", "zeroBehaviorPositiveOdd"]
choiceComments = ["The function is above the $x$-axis, then passes through.", "The function is below the $x$-axis, then touches.", "The function is above the $x$-axis, then touches.", "The function is below the $x$-axis, then passes through."]

displayStem2 = 'Describe the zero behavior of the zero $x = %s$ of the polynomial below.' %zeroOnDisplay
displayProblem2 = behaviorOfPolynomial
generalComments = "General Comments: You will need to sketch the entire graph, then zoom in on the zero the question asks about."

print
print 'Stem 2: %s' %displayStem2
print 'Problem 2: %s' %displayProblem2

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem2, displayPolyForKey)
#writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, answerFigureName, figureNames, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I finished Module 7, Objective 2, Master"
