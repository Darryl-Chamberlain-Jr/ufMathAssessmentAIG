import random
from sympy.abc import x
from sympy import solve
from sympy import Symbol
import math

#load("../Code/generalPurposeMethods.sage")

# OBJECTIVE 3 - Solve Compound Inequalities
# Types: "or" and "and" Inequalities

# Type 2 - "and" Inequalities
# andBlocks[0] + andBlocks[1] * x leq (andBlocks[2]*x - andBlocks[3])/andBlocks[4] < andBlocks[5] + andBlocks[6] * x
# Some conditions to make it nicer
    # andBlocks[1]*andBlocks[4] - andBlocks[2] < 0
        # andBlocks[1] * andBlocks[4] < andBlocks[2]
    # andBlocks[2] - andBlocks[4]*andBlocks[6] > 0
        # andBlocks[6] * andBlocks[4]  < andBlocks[2]
# To make these two conditions true:
    # Randomize 1, 4, and 6,
    # take the max(andBlocks[1] * andBlocks[4], andBlocks[6] * andBlocks[4]),
    # then randomly add to the max to make 2.

def createAllCoefficientsAndEndpoints():
    coefficients = [0, 0, 0, 0, 0, 0, 0]
    coefficients[0] = float(maybeMakeNegative(random.randint(3, 9)))
    coefficients[1] = float(maybeMakeNegative(random.randint(3, 9)))
    coefficients[3] = float(maybeMakeNegative(random.randint(3, 9)))
    coefficients[4] = float(random.randint(3, 9))
    coefficients[5] = float(maybeMakeNegative(random.randint(3, 9)))
    coefficients[6] = float(maybeMakeNegative(random.randint(3, 9)))
    # Need 1, 4, and 6 set before 2
    coefficients[2] = float((max(coefficients[1], coefficients[6])*coefficients[4]) + random.randint(2, 5))
    # This flips the inequalities

    smallerEndpoint = float((-coefficients[0]*coefficients[4] - coefficients[3]) / (coefficients[1]*coefficients[4] - coefficients[2]))
    largerEndpoint = float((coefficients[4]*coefficients[5] + coefficients[3]) / (coefficients[2] - coefficients[4] * coefficients[6]))

    # Makes sure we get a solution interval
    while  (largerEndpoint <= smallerEndpoint):
        coefficients[0] = float(maybeMakeNegative(random.randint(3, 9)))
        coefficients[1] = float(maybeMakeNegative(random.randint(3, 9)))
        coefficients[3] = float(maybeMakeNegative(random.randint(3, 9)))
        coefficients[4] = float(random.randint(3, 9))
        coefficients[5] = float(maybeMakeNegative(random.randint(3, 9)))
        coefficients[6] = float(maybeMakeNegative(random.randint(3, 9)))
        # Need 1, 4, and 6 set before 2
        coefficients[2] = float((max(coefficients[1], coefficients[6])*coefficients[4]) + random.randint(2, 5))
        # This flips the inequalities

        smallerEndpoint = float((-coefficients[0]*coefficients[4] - coefficients[3]) / (coefficients[1]*coefficients[4] - coefficients[2]))
        largerEndpoint = float((coefficients[4]*coefficients[5] + coefficients[3]) / (coefficients[2] - coefficients[4] * coefficients[6]))

    a, b, c, d, e, f, g = coefficients

    return [a, b, c, d, e, f, g, smallerEndpoint, largerEndpoint]

def distractorNegateAndInverseDomain(solution):
    a, b = solution
    return [-b, -a]

def intervalUnbalancedInclusiveExclusive(solutionInterval):
    a, b = solutionInterval
    return "[a, b)"

def intervalUnbalancedExclusiveInclusive(solutionInterval):
    a, b = solutionInterval
    return "(a, b]"

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

intervalRange = 4
allCoefficientsAndEndpoints = createAllCoefficientsAndEndpoints()
coefficients = [allCoefficientsAndEndpoints[0], allCoefficientsAndEndpoints[1], allCoefficientsAndEndpoints[2], allCoefficientsAndEndpoints[3], allCoefficientsAndEndpoints[4], allCoefficientsAndEndpoints[5], allCoefficientsAndEndpoints[6]]
solution = [allCoefficientsAndEndpoints[7], allCoefficientsAndEndpoints[8]]

while (abs(solution[0])==abs(solution[1]) or abs(solution[0])<1 or abs(solution[1])<1 or abs(abs(solution[0])-abs(solution[1])) < 1 ):
    allCoefficientsAndEndpoints = createAllCoefficientsAndEndpoints()
    coefficients = [allCoefficientsAndEndpoints[0], allCoefficientsAndEndpoints[1], allCoefficientsAndEndpoints[2], allCoefficientsAndEndpoints[3], allCoefficientsAndEndpoints[4], allCoefficientsAndEndpoints[5], allCoefficientsAndEndpoints[6]]
    solution = [float(allCoefficientsAndEndpoints[7]), float(allCoefficientsAndEndpoints[8])]

#solutionInterval = [intervalUnbalancedExclusiveInclusive(solution), generateSolutionInterval(solution, intervalRange)]

# Display for LaTeX
c0 = Integer(coefficients[0])
c1 = Integer(coefficients[1])
c2 = Integer(coefficients[2])
c3 = Integer(coefficients[3])
c4 = Integer(coefficients[4])
c5 = Integer(coefficients[5])
c6 = Integer(coefficients[6])

if c1 < 0:
    AndInequalityLeft = "%s - %s x" %(c0, -c1)
else:
    AndInequalityLeft = "%s + %s x" %(c0, c1)

if c3 < 0:
    AndInequalityMiddle = "\\frac{%s x + %s}{%s}" %(c2, -c3, c4)
else:
    AndInequalityMiddle = "\\frac{%s x - %s}{%s}" %(c2, c3, c4)

if c6 < 0:
    AndInequalityRight = "%s - %s x" %(c5, -c6)
else:
    AndInequalityRight = "%s + %s x" %(c5, c6)

distractor1 = distractorNegateAndInverseDomain(solution)
#distractor1Interval = [intervalUnbalancedExclusiveInclusive(solution), createFeasibleIntervals(distractor1, solution, intervalRange)]
distractor2 = solution
#distractor2Interval = [intervalUnbalancedInclusiveExclusive(solution), generateSolutionInterval(distractor2, intervalRange)]
distractor3 = distractorNegateAndInverseDomain(solution)
#distractor3Interval = [intervalUnbalancedInclusiveExclusive(solution), createFeasibleIntervals(distractor1, distractor2, intervalRange)]
#distractor4Interval = ['\\text{There is no solution to the inequality.}', ' ', ' ']

solutionListA = [solution, distractor1]
solutionListB = [distractor2, distractor3]
precision = 1
intervalOptionsA = createIntervalOptions(solutionListA, intervalRange, precision)
intervalOptionsB = createIntervalOptions(solutionListB, intervalRange, precision)

solutionInterval = [intervalUnbalancedExclusiveInclusive(solution), intervalOptionsA[0]]
distractor1Interval = [intervalUnbalancedExclusiveInclusive(solution), intervalOptionsA[1]]
distractor2Interval = [intervalUnbalancedInclusiveExclusive(solution), intervalOptionsB[0]]
distractor3Interval = [intervalUnbalancedInclusiveExclusive(solution), intervalOptionsB[1]]
#distractor4Interval = \\text{There is no solution to the inequality.}

displayStem = 'Solve the linear inequality below. Then, choose the constant and interval combination that describes the solution set.'
displayProblem = '%s < %s \\leq %s' %(AndInequalityLeft, AndInequalityMiddle, AndInequalityRight)

forDisplaySolution = intervalUnbalancedExclusiveInclusive(solution)

display0 = round(float(solution[0]), 3)
display1 = round(float(solution[1]), 3)
displaySolution = "(%s, %s]" %(display0, display1)
comments = "To solve, you will need to break up the compound inequality into two inequalities. Be sure to keep track of the inequality! It may be best to draw a number line and graph your solution."

solutionInterval.append(' * This is the correct solution.')
distractor1Interval.append("Corresponds to negating and inverting the inequality.")
distractor2Interval.append("Corresponds to including the endpoints.")
distractor3Interval.append("Corresponds to including the endpoints AND inverting the inequality.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
toAppendAnswer = '\\text{There is no solution to the inequality.}'
toAppendComment = "Corresponds to the variable canceling, which does not happen in this instance."
answerList.append([toAppendAnswer, toAppendComment])

c0 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[0][0], answerList[0][1][0][0], answerList[0][1][0][1], answerList[0][1][1][0], answerList[0][1][1][1])
c1 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[1][0], answerList[1][1][0][0], answerList[1][1][0][1], answerList[1][1][1][0], answerList[1][1][1][1])
c2 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[2][0], answerList[2][1][0][0], answerList[2][1][0][1], answerList[2][1][1][0], answerList[2][1][1][1])
c3 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[3][0], answerList[3][1][0][0], answerList[3][1][0][1], answerList[3][1][1][0], answerList[3][1][1][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I finished Module 4, Objective 3, Type 2, Master"
