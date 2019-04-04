import random
from sympy.abc import x
from sympy import solve
from sympy import Symbol
import math

#load("../Code/generalPurposeMethods.sage")

# OBJECTIVE 3 - Solve Compound Inequalities
# Types: "or" and "and" Inequalities

# Type 1 - "or"
# block[0] + block[1]*x > block[2]*x "or" block[3] + block[4]*x < block[5]*x
# For a non (-infty, infty) solution, we want:
    # orBlocks[1] - orBlocks[2] < 0
    # orBlocks[4] - orBlocks[5] < 0
    # - orBlocks[3]/(orBlocks[4]-orBlocks[5]) > -orBlocks[0]/(orBlocks[1]-orBlocks[2])

def createAllCoefficients():
    coefficients = [0, 0, 0, 0, 0, 0]
    coefficients[0] = maybeMakeNegative(random.randint(3, 9))
    coefficients[1] = maybeMakeNegative(random.randint(3, 9))
    coefficients[2] = abs(coefficients[1]) + random.randint(1, 3)
    coefficients[3] = maybeMakeNegative(random.randint(3, 9))
    coefficients[4] = maybeMakeNegative(random.randint(3, 9))
    coefficients[5] = abs(coefficients[4]) + random.randint(1, 3)
    print coefficients

    smallerEndpoint = float(-coefficients[0]/(coefficients[1]-coefficients[2]))
    largerEndpoint = float(-coefficients[3]/(coefficients[4]-coefficients[5]))

    while (largerEndpoint <= smallerEndpoint):
        coefficients[0] = maybeMakeNegative(random.randint(3, 9))
        coefficients[1] = maybeMakeNegative(random.randint(3, 9))
        coefficients[2] = abs(coefficients[1]) + random.randint(1, 3)
        coefficients[3] = maybeMakeNegative(random.randint(3, 9))
        coefficients[4] = maybeMakeNegative(random.randint(3, 9))
        coefficients[5] = abs(coefficients[4]) + random.randint(1, 3)

        smallerEndpoint = float(-coefficients[0]/(coefficients[1]-coefficients[2]))
        largerEndpoint = float(-coefficients[3]/(coefficients[4]-coefficients[5]))

    return coefficients

def createIntervalFromGreaterThanInequality(coefficients):
    a, b, c = coefficients

    left = a+b*x
    right = c*x
    endpoint = solve(left-right)
    nearEndpoint = floor(endpoint[0]) + 1
    return [0, endpoint[0]]


def createIntervalFromLessThanInequality(coefficients):
    a, b, c = coefficients

    left = a+b*x
    right = c*x
    endpoint = solve(left-right)
    nearEndpoint = floor(endpoint[0]) - 1

    return [endpoint[0], 0]

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def distractorNegateAndInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [-b, -a]

def intervalCupInclusive(solutionInterval):
    a, b = solutionInterval
    return "(-\infty, a] \cup [b, \infty)"

def intervalCupExclusive(solutionInterval):
    a, b = solutionInterval
    return "(-\infty, a) \cup (b, \infty)"

def extractValue(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return b
    else:
        return a

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

# Type 1 - "or"
# block[0] + block[1]*x > block[2]*x "or" block[3] + block[4]*x < block[5]*x

intervalRange = 4
allCoefficients = createAllCoefficients()

factor1Coefficients = [allCoefficients[0], allCoefficients[1], allCoefficients[2]]
factor2Coefficients = [allCoefficients[3], allCoefficients[4], allCoefficients[5]]

intervalLeft = createIntervalFromGreaterThanInequality(factor1Coefficients)
intervalRight = createIntervalFromLessThanInequality(factor2Coefficients)

endpointLeft = extractValue(intervalLeft)
endpointRight = extractValue(intervalRight)
solution = [float(endpointLeft), float(endpointRight)]

while (abs(solution[0])==abs(solution[1]) or abs(solution[0])<1 or abs(solution[1])<1 or abs(abs(solution[0])-abs(solution[1])) < 1 ):
    allCoefficients = createAllCoefficients()

    factor1Coefficients = [allCoefficients[0], allCoefficients[1], allCoefficients[2]]
    factor2Coefficients = [allCoefficients[3], allCoefficients[4], allCoefficients[5]]

    intervalLeft = createIntervalFromGreaterThanInequality(factor1Coefficients)
    intervalRight = createIntervalFromLessThanInequality(factor2Coefficients)

    endpointLeft = extractValue(intervalLeft)
    endpointRight = extractValue(intervalRight)
    solution = [float(endpointLeft), float(endpointRight)]

print "Solution this time %s" %solution

if factor1Coefficients[1] < 0:
    displayLeftFactor = "%s - %s x > %s x" %(factor1Coefficients[0], -factor1Coefficients[1], factor1Coefficients[2])
else:
    displayLeftFactor = "%s + %s x > %s x" %(factor1Coefficients[0], factor1Coefficients[1], factor1Coefficients[2])

if factor2Coefficients[1] < 0:
    displayRightFactor = "%s - %s x < %s x" %(factor2Coefficients[0], -factor2Coefficients[1], factor2Coefficients[2])
else:
    displayRightFactor = "%s + %s x < %s x" %(factor2Coefficients[0], factor2Coefficients[1], factor2Coefficients[2])

distractor1 = distractorNegateAndInverseDomain(solution)
#distractor1Interval = [intervalCupExclusive(solution), createFeasibleIntervals(distractor1, solution, intervalRange)]
distractor2 = solution
#distractor2Interval = [intervalCupInclusive(solution), generateSolutionInterval(distractor2, intervalRange)]
distractor3 = distractorNegateAndInverseDomain(solution)
#distractor3Interval = [intervalCupInclusive(solution), createFeasibleIntervals(distractor1, distractor2, intervalRange)]
#distractor4Interval = ["(-\infty, \infty)", [[], []] ]

solutionListA = [solution, distractor1]
solutionListB = [distractor2, distractor3]
precision = 1
intervalOptionsA = createIntervalOptions(solutionListA, intervalRange, precision)
intervalOptionsB = createIntervalOptions(solutionListB, intervalRange, precision)

solutionInterval = [intervalCupExclusive(solution), intervalOptionsA[0]]
distractor1Interval = [intervalCupExclusive(solution), intervalOptionsA[1]]
distractor2Interval = [intervalCupInclusive(solution), intervalOptionsB[0]]
distractor3Interval = [intervalCupInclusive(solution), intervalOptionsB[1]]
# Distractor4Interval is all real numbers. "(-\infty, \infty)"

displayStem = 'Solve the linear inequality below. Then, choose the constant and interval combination that describes the solution set.'
displayProblem = '%s \\text{ or } %s' %(displayLeftFactor, displayRightFactor)

display0 = round(solution[0], 3)
display1 = round(solution[1], 3)
displaySolution = "(-\\infty, %s) \\text{ or } (%s, \\infty)" %(display0, display1)

comments = "General Comments: When multiplying or dividing by a negative, flip the sign."

solutionInterval.append(' * Correct option.')
distractor1Interval.append("Corresponds to inverting the inequality and negating the solution.")
distractor2Interval.append("Corresponds to including the endpoints (when they should be excluded).")
distractor3Interval.append("Corresponds to including the endpoints AND negating.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
toAppendAnswer = "(-\\infty, \\infty)"
toAppendComment = "Corresponds to the variable canceling, which does not happen in this instance."
answerList.append([toAppendAnswer, toAppendComment])

c0 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[0][0], answerList[0][1][0][0], answerList[0][1][0][1], answerList[0][1][1][0], answerList[0][1][1][1])
c1 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[1][0], answerList[1][1][0][0], answerList[1][1][0][1], answerList[1][1][1][0], answerList[1][1][1][1])
c2 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[2][0], answerList[2][1][0][0], answerList[2][1][0][1], answerList[2][1][1][0], answerList[2][1][1][1])
c3 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[3][0], answerList[3][1][0][0], answerList[3][1][0][1], answerList[3][1][1][0], answerList[3][1][1][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

print answerList
print


writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
print "I finished Module 4, Objective 3, Type 1, Master"
