import random
import numpy
import math
from sympy.solvers import solve
from sympy.abc import x
from sympy import Symbol
x = Symbol('x')

#load("../Code/generalPurposeMethods.sage")
print "Starting Module 11 Objective 1"
#load("generalPurposeMethods.sage")

# OBJECTIVE 2 - Possible rational roots.

def generateFunctionAndImportantCoefficients():
    degree = int(random.randint(2, 5))
    print "Degree: %d" %degree
    counter = degree
    functionCoefficients = 0
    function = 0
    while (counter>=0):
        newCoeff = int( maybeMakeNegative(random.randint(2, 7)) )
        if (counter == degree):
            an = newCoeff
        elif (counter == 0):
            a0 = newCoeff
        else:
            dead = "I'm a dead variable."
        function = function + newCoeff*x**counter
        counter = counter - 1
    return [function, a0, an]

def generateFactors(num):
    factors = []
    counter = 1
    while (counter<=abs(num)):
        if (abs(num) % counter == 0):
            factors.append(counter)
        else:
            placeHolder = "I'm a dead placeholder!"
        counter = counter + 1
    return factors

def generateFactorsList(factors):
    factorsList = ""
    for i in range(len(factors) - 1):
        factorsList += "\\pm %d," %factors[i]
    factorsList += "\\pm %d" %factors[len(factors)-1]
    return [factorsList]

def generateSolutionAndDistractors(a0, an):
    # * This is the solution.
    # Distractor 1: Corresponds to the plus or minus factors of a1 only.
    # Distractor 2: Corresponds to the plus or minus of the quotient of the factors
    # Distractor 3: Corresponds to the plus or minus of the inverse quotient (an/a0) of the factors.
    # Distractor 4: Corresponds to not recognizing Integers as a subset of Rationals.

    factorsA0 = generateFactors(a0)
    factorsA0List = generateFactorsList(factorsA0)
    factorsAn = generateFactors(an)
    factorsAnList = generateFactorsList(factorsAn)

    solution = factorsA0List
    distractor1 = factorsAnList
    distractor2 = ["\\text{ All combinations of: }\\frac{%s}{%s}" %(factorsA0List[0], factorsAnList[0])]
    distractor3 = ["\\text{ All combinations of: }\\frac{%s}{%s}" %(factorsAnList[0], factorsA0List[0])]
    # distractor4 = ["There is no formula or theorem that tells us all possible Integer roots."]

    solutionList = [solution, distractor1, distractor2, distractor3]
    return solutionList

# Begin problem
info = generateFunctionAndImportantCoefficients()
while (info[1]==info[2]):
    info = generateFunctionAndImportantCoefficients()

print info
solutionList = generateSolutionAndDistractors(info[1], info[2])
displayPolynomial = info[0]

solutionInterval = solutionList[0]
distractor1Interval = solutionList[1]
distractor2Interval = solutionList[2]
distractor3Interval = solutionList[3]

solutionInterval.append("* This is the solution!")
distractor1Interval.append(" Distractor 1: Corresponds to the plus or minus factors of a1 only.")
distractor2Interval.append(" Distractor 2: Corresponds to the plus or minus of the quotient of the factors.")
distractor3Interval.append(" Distractor 3: Corresponds to the plus or minus of the inverse quotient (an/a0) of the factors. ")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)

answerList.append(["\\text{ There is no formula or theorem that tells us all possible Integer roots.}", " Distractor 4: Corresponds to not recognizing Integers as a subset of Rationals."])

displayStem = "What are the \\textit{possible} Integer roots of the polynomial below?"
displayProblem = displayPolynomial
displaySolution = solutionInterval[0]
generalComments = "General Comments: We have a way to find the possible Rational roots. The possible Integer roots are the Integers in this list."

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
c4 = answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 11 Objective 2, Master"
