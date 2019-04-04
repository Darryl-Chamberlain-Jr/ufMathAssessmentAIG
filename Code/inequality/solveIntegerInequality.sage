import numpy
import random
import sympy
from sympy import Symbol
from sympy.abc import x

#load("../Code/generalPurposeMethods.sage")


# OBJECTIVE 2 - Solve single linear inequalities
# Types: Basic (no fractions, no division by negative) and Advanced


# TYPE 1 - Basic (no fractions)
# For now, these can just use "leq"
# block[0] + block[1] * x leq block[2] * x + block[3]
    # If we make block[1] < block[2], we can get students to divide by a negative

def createCoefficients():
    coefficients = [0, 0, 0, 0]
    while (coefficients[1] >= coefficients[2] or coefficients[0] == coefficients[3]):
        coefficients[0] = maybeMakeNegative(random.randint(3, 10))
        coefficients[1] = maybeMakeNegative(random.randint(3, 10))
        coefficients[2] = maybeMakeNegative(random.randint(3, 10))
        coefficients[3] = maybeMakeNegative(random.randint(3, 10))
    return coefficients

def createIntervalDisplay(coefficients):
    a, b, c, d = coefficients
    left = a+b*x
    right = c*x+d
    endpoint = solve(left-right)
    if (b-c > 0):
        return [0, endpoint[0]]
    else:
        return [endpoint[0], 0]

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def distractorInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [b, a]

def distractorNegateSolution(intervalPresentation):
    a, b = intervalPresentation
    return [-a, -b]

def distractorNegateAndInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [b, a]

def intervalWithInfinityToStringInclusive(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return "(-\infty, a]"
    else:
        return "[a, \infty)"
def intervalWithInfinityToStringExclusive(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return "(-\infty, a)"
    else:
        return "(a, \infty)"
def extractValue(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return b
    else:
        return a

intervalRange = 5
coefficients = createCoefficients()
intervalDisplay = createIntervalDisplay(coefficients)

# Display for LaTeX
x = Symbol('x')
displayLeftFactor = coefficients[0] + coefficients[1] * x
displayRightFactor = coefficients[2] * x + coefficients[3]

intervalPresentation = intervalDisplay
solution = [extractValue(intervalPresentation)]
distractor1 = [extractValue(distractorInverseDomain(intervalPresentation))]
distractor2 = [extractValue(distractorNegateSolution(intervalPresentation))]
distractor3 = [extractValue(distractorNegateSolution(intervalPresentation))]

solutionList1 = [solution[0], distractor3[0]]
solutionList2 = [distractor1[0], distractor2[0]]

#solutionList = [solution, distractor1, distractor2, distractor3]
precision = 1

intervalOptions1 = createIntervalOptions(solutionList1, intervalRange, precision)
intervalOptions2 = createIntervalOptions(solutionList2, intervalRange, precision)

solutionInterval = [intervalWithInfinityToStringInclusive(intervalPresentation), intervalOptions1[0]]
distractor1Interval = [intervalWithInfinityToStringInclusive(distractorInverseDomain(intervalPresentation)), intervalOptions1[1]]
distractor2Interval = [intervalWithInfinityToStringInclusive(distractorInverseDomain(intervalPresentation)), intervalOptions2[0]]
distractor3Interval = [intervalWithInfinityToStringInclusive(intervalPresentation), intervalOptions2[1]]

displayStem = 'Solve the linear inequality below. Then, choose the constant and interval combination that describes the solution set.'

if coefficients[1] < 0 and coefficients[3] < 0:
    displayProblem = "%s - %s x \\leq %s x - %s"     %(coefficients[0], -coefficients[1], coefficients[2], -coefficients[3])
elif coefficients[1] < 0 and coefficients[3] > 0:
    displayProblem = "%s - %s x \\leq %s x + %s"    %(coefficients[0], -coefficients[1], coefficients[2], coefficients[3])
elif coefficients[1] > 0 and coefficients[3] < 0:
    displayProblem = "%s + %s x \\leq %s x - %s"    %(coefficients[0], coefficients[1], coefficients[2], -coefficients[3])
else:
    displayProblem = "%s + %s x \\leq %s x + %s"    %(coefficients[0], coefficients[1], coefficients[2], coefficients[3])

display0 = round(float(intervalDisplay[0]), 3)
display1 = round(float(intervalDisplay[1]), 3)

if intervalDisplay[0] == 0:
    displaySolution = "(-\\infty, %s]" %display1
else:
    displaySolution = "[%s, \\infty)" %display0

comments = "General Comments: Remember that less than or equal to includes the endpoint!"

solutionInterval.append(' * Correct option.')
distractor1Interval.append("Corresponds to inverting the inequality (wrong direction).")
distractor2Interval.append("Corresponds to inverting the inequality AND the negative of the actual solution.")
distractor3Interval.append("Corresponds to the negative of the actual solution.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
toAppendAnswer = "(-\\infty, \\infty)"
toAppendComment = "Corresponds to the variable canceling, which does not happen in this instance."
answerList.append([toAppendAnswer, toAppendComment])

c0 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[0][0], answerList[0][1][0], answerList[0][1][1])
c1 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[1][0], answerList[1][1][0], answerList[1][1][1])
c2 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[2][0], answerList[2][1][0], answerList[2][1][1])
c3 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[3][0], answerList[3][1][0], answerList[3][1][1])
c4 = "%s" %answerList[4][0]

print
print displayProblem
print displaySolution
print

choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I finished Module 4, Objective 2, Type 1, Master"
