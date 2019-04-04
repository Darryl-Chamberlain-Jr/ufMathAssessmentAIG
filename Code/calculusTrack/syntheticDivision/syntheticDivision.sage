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

# OBJECTIVE 1 - Divide two polynomials using Synthetic Division.

def generateDisplayAndSolution():
    #Goal: (a0*x+b0)*(a1*x+b1)*(x-z)+r
    a0 = random.randint(2, 5)
    b0 = maybeMakeNegative(random.randint(2, 5))
    a1 = random.randint(2, 5)
    b1 = maybeMakeNegative(random.randint(2, 5))
    z = maybeMakeNegative(random.randint(2, 5))
    r = maybeMakeNegative(random.randint(2, 5))

    numeratorPoly = (a0*a1)*x**3 + (-a0*a1*z + a0*b1 + a1*b0)*x**2+ (-a0*b1*z - a1*b0*z + b0*b1)*x + (-b0*b1*z + r)
    numCo1 = a0*a1
    numCo2 = -a0*a1*z + a0*b1 + a1*b0
    numCo3 = -a0*b1*z - a1*b0*z + b0*b1
    numCo4 = -b0*b1*z + r

    denominator = x - z
    quotient = (a0*a1)*x**2 + (a0*b1+a1*b0)*x + b0*b1
    term1 = a0*a1
    term2 = a0*b1+a1*b0
    term3 = b0*b1
    remainder = r

    while (numCo1==0 or numCo2==0 or numCo3==0 or numCo4==0):
        a0 = random.randint(2, 5)
        b0 = maybeMakeNegative(random.randint(2, 5))
        a1 = random.randint(2, 5)
        b1 = maybeMakeNegative(random.randint(2, 5))
        z = maybeMakeNegative(random.randint(2, 5))
        r = maybeMakeNegative(random.randint(2, 5))

        numeratorPoly = (a0*a1)*x**3 + (-a0*a1*z + a0*b1 + a1*b0)*x**2+ (-a0*b1*z - a1*b0*z + b0*b1)*x + (-b0*b1*z + r)
        numCo1 = a0*a1
        numCo2 = -a0*a1*z + a0*b1 + a1*b0
        numCo3 = -a0*b1*z - a1*b0*z + b0*b1
        numCo4 = -b0*b1*z + r
        denominator = x - z
        quotient = (a0*a1)*x**2 + (a0*b1+a1*b0)*x + b0*b1
        term1 = a0*a1
        term2 = a0*b1+a1*b0
        term3 = b0*b1
        remainder = r

    solutionValues = [term1, term2, term3, remainder]
    coefficients = [a0, b0, a1, b1, z, r]

    return [numeratorPoly, denominator, quotient, solutionValues, coefficients]

def syntheticDivision(polyCoefficients, syntheticNumber):
    a, b, c, d = polyCoefficients
    n = syntheticNumber

    term1 = a
    term2 = term1*n + b
    term3 = term2*n + c
    remainder = term3*n + d
    return [term1, term2, term3, remainder]

def subtractSyntheticDivision(polyCoefficients, syntheticNumber):
    a, b, c, d = polyCoefficients
    n = syntheticNumber
    term1 = a
    term2 = b - term1*n
    term3 = c - term2*n
    remainder = d - term3*n
    return [term1, term2, term3, remainder]

# There aren't great distractors. Will need to see students' work to make better ones.
def generateDistractors(coefficients):
    a0, b0, a1, b1, z, r = coefficients
    # Synthetically divided by the negative of the zero
    polyCoefficients = [a0*a1, -a0*a1*z + a0*b1 + a1*b0, -a0*b1*z - a1*b0*z + b0*b1, -b0*b1*z + r]
    distractor1 = syntheticDivision(polyCoefficients, -z)

    # Multiplies the first term rather than bringing it down.
    badPolyCoefficients = [z*a0*a1, -a0*a1*z + a0*b1 + a1*b0, -a0*b1*z - a1*b0*z + b0*b1, -b0*b1*z + r]

    distractor2 = syntheticDivision(badPolyCoefficients, z)
    distractor3 = syntheticDivision(badPolyCoefficients, -z)
    distractor4 = syntheticDivision(polyCoefficients, z-1)
    return [distractor1, distractor2, distractor3, distractor4]

# Begin problem
intervalRange = 5
precision = 1

displayAndSolution = generateDisplayAndSolution()
print displayAndSolution

displayNumerator = displayAndSolution[0]
displayDenominator = displayAndSolution[1]
displayQuotient = displayAndSolution[2]

coefficients = displayAndSolution[4]

# Solution is coefficents of quotient and remainder
solution = [displayAndSolution[3][0], displayAndSolution[3][1], displayAndSolution[3][2], displayAndSolution[3][3]]
print coefficients
distractors = generateDistractors(coefficients)

solutionList = [solution, distractors[0], distractors[1], distractors[2], distractors[3]]
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* This is the solution!")
distractor1Interval.append(" You divided by the opposite of the factor.")
distractor2Interval.append(" You multiplied by the synthetic number rather than bringing the first factor down.")
distractor3Interval.append(" You divided by the opposite of the factor AND multiplied the first factor rather than just bringing it down.")
distractor4Interval.append(" You multiplied by the synthetic number and subtracted rather than adding during synthetic division.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

print "Check that these are unique: %s" %solutionList

displayStem = "Perform the division below. Then, find the intervals that correspond to the quotient in the form $ax^2+bx+c$ and remainder $r$."
displayProblem = "\\frac{%s}{%s}" %(displayNumerator, displayDenominator)
displaySolution = "%s x^2 + %s x + %s + \\frac{%s}{%s}" %(solution[0], solution[1], solution[2], solution[3], displayDenominator)
generalComments = "General Comments: Be sure to synthetically divide by the zero of the denominator!"

c0 = "a \in [%s, %s], \\text{   } b \in [%s, %s], \\text{   } c \in [%s, %s], \\text{   and   } r \in [%s, %s]." %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "a \in [%s, %s], \\text{   } b \in [%s, %s], \\text{   } c \in [%s, %s], \\text{   and   } r \in [%s, %s]." %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "a \in [%s, %s], \\text{   } b \in [%s, %s], \\text{   } c \in [%s, %s], \\text{   and   } r \in [%s, %s]." %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "a \in [%s, %s], \\text{   } b \in [%s, %s], \\text{   } c \in [%s, %s], \\text{   and   } r \in [%s, %s]." %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "a \in [%s, %s], \\text{   } b \in [%s, %s], \\text{   } c \in [%s, %s], \\text{   and   } r \in [%s, %s]." %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 11 Objective 1 Type 1, Master"
