import random
from sympy import *
import numpy
from sympy import Symbol

#load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
# OBJECTIVE 3 - Construct lowest-degree polynomials given the zeros of the polynomial.

def generateFactor():
    a = random.randint(1, 5)
    b = maybeMakeNegative(random.randint(1, 7))
    while gcd(abs(a), abs(b)) > 1:
        a = random.randint(1, 5)
        b = maybeMakeNegative(random.randint(1, 7))
    return [a, b]

def listZeros(factor1, factor2):
    z1 = factor1[1]/factor1[0]
    z2 = - factor1[1]/factor1[0]
    z3 =  factor2[1]/factor2[0]
    z4 = - factor2[1]/factor2[0]
    return [z1, z2, z3, z4]

def generateSolution(factor1, factor2, factor3):
    f10, f11 = factor1
    f20, f21 = factor2
    f30, f31 = factor3

    a = f10*f20*f30
    b = -f11*f20*f30 - f10*f21*f30 - f10*f20*f31
    c = f11*f20*f31 + f10*f21*f31 + f11*f21*f30
    d = -f11*f21*f31

    return [a, b, c, d]

def distractorConjugateAllZeros(factor1, factor2, factor3):
    f10, f11 = factor1
    f20, f21 = factor2
    f30, f31 = factor3

    f11 = -f11
    f21 = -f21
    f31 = -f31

    a = f10*f20*f30
    b = -f11*f20*f30 - f10*f21*f30 - f10*f20*f31
    c = f11*f20*f31 + f10*f21*f31 + f11*f21*f30
    d = -f11*f21*f31

    return [a, b, c, d]

def distractorOppositeD(factor1, factor2, factor3):
    f10, f11 = factor1
    f20, f21 = factor2
    f30, f31 = factor3

    a = f10*f20*f30
    b = -f11*f20*f30 - f10*f21*f30 - f10*f20*f31
    c = f11*f20*f31 + f10*f21*f31 + f11*f21*f30
    d = f11*f21*f31

    return [a, b, c, d]

def distractorConjugateOneZero(factor1, factor2, factor3):
    f10, f11 = factor1
    f20, f21 = factor2
    f30, f31 = factor3

    f11 = -f11

    a = f10*f20*f30
    b = -f11*f20*f30 - f10*f21*f30 - f10*f20*f31
    c = f11*f20*f31 + f10*f21*f31 + f11*f21*f30
    d = -f11*f21*f31

    return [a, b, c, d]

def distractorConjugateTwoZeros(factor1, factor2, factor3):
    f10, f11 = factor1
    f20, f21 = factor2
    f30, f31 = factor3

    f11 = -f11
    f21 = -f21

    a = f10*f20*f30
    b = -f11*f20*f30 - f10*f21*f30 - f10*f20*f31
    c = f11*f20*f31 + f10*f21*f31 + f11*f21*f30
    d = -f11*f21*f31

    return [a, b, c, d]

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

intervalRange = 5

factor1 = generateFactor()
factor2 = generateFactor()
factor3 = generateFactor()
zero1 = float(factor1[1])/float(factor1[0])
zero2 = float(factor2[1])/float(factor2[0])
zero3 = float(factor3[1])/float(factor3[0])

while (abs(zero1) == abs(zero2) or abs(zero1) == abs(zero3) or abs(zero2) == abs(zero3)):
    factor1 = generateFactor()
    factor2 = generateFactor()
    factor3 = generateFactor()
    zero1 = float(factor1[1])/float(factor1[0])
    zero2 = float(factor2[1])/float(factor2[0])
    zero3 = float(factor3[1])/float(factor3[0])

#polynomial = (factor1[0]*x-factor1[1])*(factor2[0]*x-factor2[1])*(factor3[0]*x-factor3[1])

solution = generateSolution(factor1, factor2, factor3)
if solution[1] < 0:
    if solution[2] < 0:
        if solution[3] < 0:
            displaySolution = "%d x^3 - %d x^2 - %d x - %d" %(solution[0], -solution[1], -solution[2], -solution[3])
        else:
            displaySolution = "%d x^3 - %d x^2 - %d x + %d" %(solution[0], -solution[1], -solution[2], solution[3])
    else:
        if solution[3] < 0:
            displaySolution = "%d x^3 - %d x^2 + %d x - %d" %(solution[0], -solution[1], solution[2], -solution[3])
        else:
            displaySolution = "%d x^3 - %d x^2 + %d x + %d" %(solution[0], -solution[1], solution[2], solution[3])
else:
    if solution[2] < 0:
        if solution[3] < 0:
            displaySolution = "%d x^3 + %d x^2 - %d x - %d" %(solution[0], solution[1], -solution[2], -solution[3])
        else:
            displaySolution = "%d x^3 + %d x^2 - %d x + %d" %(solution[0], solution[1], -solution[2], solution[3])
    else:
        if solution[3] < 0:
            displaySolution = "%d x^3 + %d x^2 + %d x - %d" %(solution[0], solution[1], solution[2], -solution[3])
        else:
            displaySolution = "%d x^3 + %d x^2 + %d x + %d" %(solution[0], solution[1], solution[2], solution[3])

distractor1 = distractorConjugateAllZeros(factor1, factor2, factor3)
distractor2 = distractorOppositeD(factor1, factor2, factor3)
distractor3 = distractorConjugateOneZero(factor1, factor2, factor3)
distractor4 = distractorConjugateTwoZeros(factor1, factor2, factor3)

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
print solutionList
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

print intervalOptions
displayStem = 'Construct the lowest-degree polynomial given the zeros below. Then, choose the intervals that contain the coefficients of the polynomial in the form $ax^3+bx^2+cx+d$.'

if factor1[0] == 1:
    displayZero1 = factor1[1]
else:
    displayZero1 = "\\frac{%s}{%s}" %(factor1[1], factor1[0])
#
if factor2[0] == 1:
    displayZero2 = factor2[1]
else:
    displayZero2 = "\\frac{%s}{%s}" %(factor2[1], factor2[0])
#
if factor3[0] == 1:
    displayZero3 = factor3[1]
else:
    displayZero3 = "\\frac{%s}{%s}" %(factor3[1], factor3[0])
#
displayProblem = "%s, %s, \\text{ and } %s" %(displayZero1, displayZero2, displayZero3)



print displayProblem

solutionInterval.append("* This is the correct solution")
distractor1Interval.append(" Distractor 1: This corresponds to multiplying $(x+z_1)(x+z_2)(x+z_3)$")
distractor2Interval.append(" Distractor 2: This corresponds to having everything correct except the sign of the last term.")
distractor3Interval.append(" Distractor 3: This corresponds to using $(x+z_1)$ for the first term.")
distractor4Interval.append(" Distractor 4: This corresponds to using $(x+z_1)(x+z_2)$ for the first two terms.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

generalComments = "General Comments: To construct the lowest-degree polynomial, you want to multiply out $(%sx-%s)(%sx-%s)(%sx-%s)$" %(factor1[0], factor1[1], factor2[0], factor2[1], factor3[0], factor3[1])

c0 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I finished Module 7, Objective 3, Type 1, Master"
