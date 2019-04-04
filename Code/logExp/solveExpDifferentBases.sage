import random
import numpy
import math
from sympy.solvers import solve
from sympy.abc import x
from sympy import Symbol
x = Symbol('x')

#load("../Code/generalPurposeMethods.sage")
print "Starting Module 9 Objective 2 Type 2"
#load("generalPurposeMethods.sage")

# Ideas for forms of this question [gcd(b0, b1)=1]:
    # b0**(a0*x+a1) = b1**(c0*x+c1)
    # b0**(a0*x+a1) = (b1**(\frac{1}{power}))**(c0*x+c1)
    # FUTURE: b0**(a0*x+a1) = - (b1**power)**(c0*x+c1)


# OBJECTIVE 1 - Solving Exponential Equations (with different bases)
intervalRange = 3
precision = 1

problemNumber1 = 44
problemNumber2 = 45

def createCoefficients(type):
    b0 = random.randint(2, 5)
    b1 = random.randint(3, 7)
    a0 = float(maybeMakeNegative(random.randint(2, 5)))
    a1 = float(maybeMakeNegative(random.randint(2, 5)))
    c0 = float(maybeMakeNegative(random.randint(2, 5)))
    c1 = float(maybeMakeNegative(random.randint(2, 5)))
    exponent1 = float(-a1/a0)
    exponent2 = float(-c1/c0)

    while ((c1==a1) or (c0==a0) or gcd(b0, b1)>1 or exponent1 == exponent2):
        b0 = random.randint(2, 5)
        b1 = random.randint(3, 7)
        a0 = float(maybeMakeNegative(random.randint(2, 5)))
        a1 = float(maybeMakeNegative(random.randint(2, 5)))
        c0 = float(maybeMakeNegative(random.randint(2, 5)))
        c1 = float(maybeMakeNegative(random.randint(2, 5)))
        exponent1 = float(-a1/a0)
        exponent2 = float(-c1/c0)

    if (type=="Natural"):
        power = random.randint(2, 3)
    else:
        power = -random.randint(2, 3)

    return [b0, a0, a1, b1, power, c0, c1]

def displayEquation(coefficients):
    b0, a0, a1, b1, power, c0, c1 = coefficients
    if (power>0):
        b1ToThePower = b1**power
        if (a1<0):
            if (c1<0):
                equation = "%d^{%dx-%d} = %d^{%dx-%d}" %(b0, a0, -a1, b1ToThePower, c0, -c1)
            else:
                equation = "%d^{%dx-%d} = %d^{%dx+%d}" %(b0, a0, -a1, b1ToThePower, c0, c1)
        else:
            if (c1<0):
                equation = "%d^{%dx+%d} = %d^{%dx-%d}" %(b0, a0, a1, b1ToThePower, c0, -c1)
            else:
                equation = "%d^{%dx+%d} = %d^{%dx+%d}" %(b0, a0, a1, b1ToThePower, c0, c1)

    else:
        b1ToThePower = b1**abs(power)
        if (a1<0):
            if (c1<0):
                equation = "%d^{%dx-%d} = \\left(\\frac{1}{%d}\\right)^{%dx-%d}" %(b0, a0, -a1, b1ToThePower, c0, -c1)
            else:
                equation = "%d^{%dx-%d} = \\left(\\frac{1}{%d}\\right)^{%dx+%d}" %(b0, a0, -a1, b1ToThePower, c0, c1)
        else:
            if (c1<0):
                equation = "%d^{%dx+%d} = \\left(\\frac{1}{%d}\\right)^{%dx-%d}" %(b0, a0, a1, b1ToThePower, c0, -c1)
            else:
                equation = "%d^{%dx+%d} = \\left(\\frac{1}{%d}\\right)^{%dx+%d}" %(b0, a0, a1, b1ToThePower, c0, c1)

    return equation

def solveEquation(coefficients):
    #b**(a0*x+a1) = (b**power)**(c0*x+c1)
    b0, a0, a1, b1, power, c0, c1 = coefficients
    b0f = float(b0)
    a0f = float(a0)
    a1f = float(a1)
    b1f = float(b1)
    powerf = float(power)
    c0f = float(c0)
    c1f = float(c1)
    L0 = float(math.log(b0f))
    L1 = float( math.log(b1f**powerf) )
    numerator = float(L1*c1f - a1f*L0)
    denominator = float(a0f*L0 - c0f*L1)
    solution = float(numerator/denominator)
    print "Check this: %s**(%s*x+%s) = (%s**%s)**(%s*x+%s)" %(b0, a0, a1, b1, power, c0, c1)
    print "Solution: %s" %solution
    return solution

def createSolutionAndDistractors(coefficients):
    b0, a0, a1, b1, power, c0, c1 = coefficients

    solution = solveEquation(coefficients)
    distractor1 = solveEquation([b0, a0, c1, b1, power, c0, a1])
    distractor2 = solveEquation([b0, a0, a1, b1, 1, c0, c1])
    distractor3 = solveEquation([b0, a0, c1, b1, 1, c0, a1])
    #distractor4 will be that there is no Real solution to the equation.
    solutionList = [solution, distractor1, distractor2, distractor3]

    return solutionList

def createAnswerList(solutionList):
    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)
    solutionInterval = intervalOptions[0]
    distractor1Interval = intervalOptions[1]
    distractor2Interval = intervalOptions[2]
    distractor3Interval = intervalOptions[3]
    distractor4Interval = ["\\text{There is no Real solution to the equation.}"]

    solutionInterval.append("* This is the solution!")
    distractor1Interval.append(" Corresponds to getting the negative of the actual solution.")
    distractor2Interval.append(" Correponds to ignoring that the bases are different.")
    distractor3Interval.append(" Corresponds to ignoring that the basses are different and reversing that solution.")
    distractor4Interval.append(" Corresponds to believing there is no solution since the bases are not powers of each other.")

    answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
    random.shuffle(answerList)
    answerList.append(distractor4Interval)

    return answerList

# One question for each type
typesOfPower = ["Natural", "Integer"]
power = typesOfPower[random.randint(0, 1)]

coefficients = createCoefficients(power)
equation = displayEquation(coefficients)
solutionAndAnswers = createSolutionAndDistractors(coefficients)
solutionList = solutionAndAnswers

while (abs(solutionList[0]-solutionList[1]) < 1 or abs(solutionList[0]-solutionList[2]) < 1) or abs(solutionList[0]-solutionList[3]) < 1 or abs(solutionList[1]-solutionList[2]) < 1 or abs(solutionList[1]-solutionList[3]) < 1 or abs(solutionList[2]-solutionList[3]) < 1:
    coefficients = createCoefficients(power)
    equation = displayEquation(coefficients)
    solutionAndAnswers = createSolutionAndDistractors(coefficients)
    solutionList = solutionAndAnswers
answerList = createAnswerList(solutionList)

displayStem = 'Solve the equation for $x$ and choose the interval that contains the solution (if it exists).'
displayProblem = equation
displaySolution = "x = %s" %(round(solutionList[0], 3))
generalComments = "\\textbf{General Comments:} This question was written so that the bases could not be written the same. You will need to take the log of both sides."

c0 = "x \\in [%s, %s]" %(answerList[0][0], answerList[0][1])
c1 = "x \\in [%s, %s]" %(answerList[1][0], answerList[1][1])
c2 = "x \\in [%s, %s]" %(answerList[2][0], answerList[2][1])
c3 = "x \\in [%s, %s]" %(answerList[3][0], answerList[3][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "solveExpDifferentBases.sage has finished running."
