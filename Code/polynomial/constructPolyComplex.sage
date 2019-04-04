import random
from sympy import *
import numpy
from sympy import Symbol

#load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
# OBJECTIVE 3 - Construct lowest-degree polynomials given the zeros of the polynomial.
    # Complex roots!

def generateSolution(complexZero, realZero):
    a, b = complexZero
    k = realZero

    # productComplex = x**2 - 2*a*x + (a**2 + b**2)
    # fullProduct = x**3 + (-2*a-k)*x**2+(a**2+b**2+2*a*k)*x+(a**2+b**2)*(-k)
    c3 = 1
    c2 = -2*a-k
    c1 = a**2+b**2 + 2*a*k
    c0 = (a**2+b**2)*(-k)

    return [c3, c2, c1, c0]

def generateDistractors(complexZero, realZero):
    a, b = complexZero
    k = realZero
    # Distractor 1: This distractor corresponds to using (x+z) for zeros.
    a1 = 1
    b1 = 2*a+k
    c1 = a**2+b**2 + 2*a*k
    d1 = (a**2+b**2)*k

    distractor1 = [a1, b1, c1, d1]

    # Distractor 2: This distractor corresponds to using a from the complex and the other zero to make a quadratic.
    a2 = 1
    b2 = 1
    c2 = -a-k
    d2 = a*k

    distractor2 = [a2, b2, c2, d2]

    # Distractor 3: This distractor corresponds to using b from the complex and the other zero to make a quadratic.
    a3 = 1
    b3 = 1
    c3 = -b-k
    d3 = b*k

    distractor3 = [a3, b3, c3, d3]

    # Distractor 4: This distractor corresponds to negatives for each of the coefficients in the solution.
    a4 = 1
    b4 = 2*a+k
    c4 = -a**2 - b**2 - 2*a*k
    d4 = (a**2+b**2)*k

    distractor4 = [a4, b4, c4, d4]

    return [distractor1, distractor2, distractor3, distractor4]

intervalRange = 5
precision = 1

complexZero = [0, maybeMakeNegative(random.randint(2, 5))]
realZero = maybeMakeNegative(random.randint(1, 4))

while (complexZero[0] == complexZero[1]):
    complexZero = [0, maybeMakeNegative(random.randint(1, 4))]

#Display zeros
#if (complexZero[1]<0):
#    displayZero1 = "%d - %di" %(complexZero[0], -complexZero[1])
#    displayZero2 = "%d" %realZero
#else:
#    displayZero1 = "%d + %di" %(complexZero[0], complexZero[1])
#    displayZero2 = "%d" %realZero

displayZero1 = "%di" %complexZero[1]
displayZero2 = "%d" %realZero

solution = generateSolution(complexZero, realZero)
if solution[1] < 0:
    if solution[2] < 0:
        if solution[3] < 0:
            displaySolution = "x^3 - %d x^2 - %d x - %d" %(-solution[1], -solution[2], -solution[3])
        else:
            displaySolution = "x^3 - %d x^2 - %d x + %d" %(-solution[1], -solution[2], solution[3])
    else:
        if solution[3] < 0:
            displaySolution = "x^3 - %d x^2 + %d x - %d" %(-solution[1], solution[2], -solution[3])
        else:
            displaySolution = "x^3 - %d x^2 + %d x + %d" %(-solution[1], solution[2], solution[3])
else:
    if solution[2] < 0:
        if solution[3] < 0:
            displaySolution = "x^3 + %d x^2 - %d x - %d" %(solution[1], -solution[2], -solution[3])
        else:
            displaySolution = "x^3 + %d x^2 - %d x + %d" %(solution[1], -solution[2], solution[3])
    else:
        if solution[3] < 0:
            displaySolution = "x^3 + %d x^2 + %d x - %d" %(solution[1], solution[2], -solution[3])
        else:
            displaySolution = "x^3 + %d x^2 + %d x + %d" %(solution[1], solution[2], solution[3])

print "This is the solution: %s" %solution
distractors = generateDistractors(complexZero, realZero)
solutionList = [solution, distractors[0], distractors[1], distractors[2], distractors[3]]

intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* This is the correct solution")
distractor1Interval.append(" Distractor 1: This distractor corresponds to using (x+z) for zeros.")
distractor2Interval.append(" Distractor 2: This distractor corresponds to using a from the complex and the other zero to make a quadratic.")
distractor3Interval.append(" Distractor 3: This distractor corresponds to using b from the complex and the other zero to make a quadratic.")
distractor4Interval.append(" Distractor 4: This distractor corresponds to negatives for each of the coefficients in the solution.")

displayStem = 'Construct the lowest-degree polynomial given the zeros below. Then, choose the intervals that contain the coefficients of the polynomial in the form $x^3+bx^2+cx+d$.'
displayProblem = '%s \\text{ and } %s' %(displayZero1, displayZero2)
generalComments = "General Comments: Remember that the conjugate of $a+bi$ is $a-bi$. Since these zeros always come in pairs, we need to multiply out $(x-%s)(x+%s)(x-%s)$" %(displayZero1, displayZero1, displayZero2)

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "Here are the zeros: %s, %s" %(displayZero1, displayZero2)

print "I finished Module 7, Objective 3, Type 2, Master"
