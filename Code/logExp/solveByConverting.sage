import random
import numpy
import math
from sympy.solvers import solve
from sympy.abc import x
from sympy import Symbol
x = Symbol('x')

#load("../Code/generalPurposeMethods.sage")
print "Starting Module 9 Objective 1"
#load("generalPurposeMethods.sage")

# Ideas for forms of this question:
    # math.log(x, b) = \frac{a0}{a1}, solve for x
    # math.log(a0*x+a1, b)+k = num, solve for x

# OBJECTIVE 1 - Solving Logarithmic Equations
intervalRange = 5
precision = 1

# STRUCTURE FOR NOW
    # math.log(a0*x+a1, b)+k = N

def createEquation():
    a0 = maybeMakeNegative(random.randint(2, 4))
    a1 = (random.randint(5, 8))
    b = random.randint(2, 5)
    k = maybeMakeNegative(random.randint(4, 6))
    N = random.randint(2, 3)

    while (k==N or N-k>5 or b == N-k):
        a0 = maybeMakeNegative(random.randint(2, 4))
        a1 = (random.randint(5, 8))
        b = random.randint(4, 5)
        k = maybeMakeNegative(random.randint(4, 6))
        N = random.randint(2, 3)

    if (a1<0):
        if (k<0):
            equation = "\\log_{%d}{(%dx-%d)}-%d = %d" %(b, a0, -a1, -k, N)
        else:
            equation = "\\log_{%d}{(%dx-%d)}+%d = %d" %(b, a0, -a1, k, N)
    else:
        if (k<0):
            equation = "\\log_{%d}{(%dx+%d)}-%d = %d" %(b, a0, a1, -k, N)
        else:
            equation = "\\log_{%d}{(%dx+%d)}+%d = %d" %(b, a0, a1, k, N)

    return [equation, b, a0, a1, k, N]

def solveEquation(coefficients):
    b, a0, a1, k, N = coefficients
    bf = float(b)
    a0f = float(a0)
    a1f = float(a1)
    solution = float( (bf**(N-k) - a1)/a0 )
    return solution

def createSolutionAndDistractors(coefficients):
    b, a0, a1, k, N = coefficients

    solution = solveEquation(coefficients)
    distractor1 = solveEquation([b, a0, a1, 0, N])
    distractor2 = solveEquation([N-k, a0, a1, 0, b])
    distractor3 = solveEquation([N-k, a0, -a1, 0, b])
    #distractor4 will be that there is no Real solution to the equation.
    solutionList = [solution, distractor1, distractor2, distractor3]
    print solutionList

    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

    solutionInterval = intervalOptions[0]
    distractor1Interval = intervalOptions[1]
    distractor2Interval = intervalOptions[2]
    distractor3Interval = intervalOptions[3]
    distractor4Interval = ["\\text{There is no Real solution to the equation.}"]

    solutionInterval.append("* This is the solution!")
    distractor1Interval.append(" Corresponds to ignoring the vertical shift when converting to exponential form.")
    distractor2Interval.append(" Corresponds to reversing the base and exponent when converting.")
    distractor3Interval.append(" Corresponds to reversing the base and exponent when converting and reversing the value with $x$.")
    distractor4Interval.append(" Corresponds to believing a negative coefficient within the log equation means there is no Real solution.")

    answerList= [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
    random.shuffle(answerList)
    answerList.append(distractor4Interval)

    return [solutionList, answerList, solution]

###################

equationAndCoefficients = createEquation()
coefficients = [equationAndCoefficients[1], equationAndCoefficients[2], equationAndCoefficients[3], equationAndCoefficients[4], equationAndCoefficients[5]]
solutionAndAnswers = createSolutionAndDistractors(coefficients)
print solutionAndAnswers
counter = 0

displayEquation = equationAndCoefficients[0]
answerList = solutionAndAnswers[1]

displayStem = 'Solve the equation for $x$ and choose the interval that contains the solution (if it exists).'
displayProblem = displayEquation
displaySolution = "x = %s" %round(solutionAndAnswers[2], 3)

generalComments = "\\textbf{General Comments:} First, get the equation in the form $\\log_b{(cx+d)} = a$. Then, convert to $b^a = cx+d$ and solve."

print answerList

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

print "I have finished Module 9 Objective 1, Master"
