import random
import numpy
from sympy.solvers import solve
from sympy.abc import x

#load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
print "Starting Objective 2 Type 1"
# OBJECTIVE 2 - Solve linear equations.
# Types of questions:
    # Type 1 - Linear equations with Integers only
    # Type 2 - Linear equations with Rationals

# Type 1 - Solving Basic linear equations (no fractions)
# Since Sage wants to simply for us, we will need to write the equation as a
    # group of blocks. In the future, we can add different structures.

# Create an array of 6 distinct naturals, then make some integers
def generateBlocks():
    listNaturals = range(2, 16)
    blocks = random.sample(listNaturals, 6)
    blocks[0] = -blocks[0]
    blocks[1] = maybeMakeNegative(blocks[1])
    blocks[2] = maybeMakeNegative(blocks[2])
    blocks[3] = -blocks[3]
    blocks[4] = maybeMakeNegative(blocks[4])
    blocks[5] = maybeMakeNegative(blocks[5])

    OneSolutionCheck = blocks[0]*blocks[2] - blocks[3]*blocks[4]
    # Makes sure there is exactly one solution
    while (OneSolutionCheck == 0):
        blocks[0] = -blocks[0]
        blocks[1] = maybeMakeNegative(blocks[1])
        blocks[2] = maybeMakeNegative(blocks[2])
        blocks[3] = -blocks[3]
        blocks[4] = maybeMakeNegative(blocks[4])
        blocks[5] = maybeMakeNegative(blocks[5])
        OneSolutionCheck = blocks[0]*blocks[2] - blocks[3]*blocks[4]
    return blocks

#-block[0] * (block[1] + block[2] * x) = - block[3] ( x * block[4] - block[5])
def generateSolution(blocks):
    a, b, c, d, e, f = blocks
    basicLinearEquation = a * (b + c * x) - d * ( x * e - f)
    solution = solve(basicLinearEquation, x)
    return solution

def distractorDistributionC(blocks):
    a, b, c, d, e, f = blocks
    return [a, b, -c, d, e, f]
def distractorDistributionF(blocks):
    a, b, c, d, e, f = blocks
    return [a, b, c, d, e, -f]
def distractorDistributionCandF(blocks):
    a, b, c, d, e, f = blocks
    return [a, b, -c, d, e, -f]
def distractorNegativeSolution(blocks):
    a, b, c, d, e, f = blocks
    return [-a, b, c, d, e, f]

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
def intervalToString(interval):
    return ['x_1 \in [%d,%d]' %(interval[0], interval[1])]
intervalRange = 3

blocks = generateBlocks()

solution = generateSolution(blocks)
distractor1 = generateSolution(distractorDistributionC(blocks))
distractor2 = generateSolution(distractorDistributionF(blocks))
#DEAD distractor3 = distractorDistributionCandF(blocks)
distractor3 = generateSolution(distractorNegativeSolution(blocks))

solutionList = [solution, distractor1, distractor2, distractor3]
print solutionList
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = [intervalOptions[0][0]]
distractor1Interval = [intervalOptions[1][0]]
distractor2Interval = [intervalOptions[2][0]]
distractor3Interval = [intervalOptions[3][0]]

displayStem = 'Solve the equation below. Then, choose the interval that contains the solution.'
#displayProblem = '\\sage{blocks[0]}(\\sage{blocks[1]+blocks[2]*x}) = \\sage{blocks[3]}(\\sage{blocks[4]*x-blocks[5]})'

if blocks[2] < 0 and blocks[5] < 0:
    displayProblem = "%d(%d-%d x) = %d(%d x+%d)" %(blocks[0], blocks[1], -blocks[2], blocks[3], blocks[4], -blocks[5])
elif blocks[2] < 0 and blocks[5] > 0:
    displayProblem = "%d(%d-%d x) = %d(%d x-%d)" %(blocks[0], blocks[1], -blocks[2], blocks[3], blocks[4], blocks[5])
elif blocks[2] > 0 and blocks[5] < 0:
    displayProblem = "%d(%d+%d x) = %d(%d x+%d)" %(blocks[0], blocks[1], blocks[2], blocks[3], blocks[4], -blocks[5])
else:
    displayProblem = "%d(%d+%d x) = %d(%d x-%d)" %(blocks[0], blocks[1], blocks[2], blocks[3], blocks[4], blocks[5])

displaySolution = round(float(solution[0]), 3)
comments = "General Comments: The most common mistake on this question is to not distribute correctly."

#solutionInterval = intervalToString(generateSolutionInterval(solution, intervalRange)[0])
#distractor1Interval = intervalToString(createFeasibleIntervals(distractor1, solution, intervalRange)[0])
#distractor2Interval = intervalToString(createFeasibleIntervals(distractor2, solution, intervalRange)[0])
#DEAD distractor3Interval = intervalToString(createFeasibleIntervals(distractor3, solution, intervalRange)[0])
#DEAD distractor3Interval = ["\\text{There are no real solutions.}"]
#distractor4Interval = intervalToString(createFeasibleIntervals(distractor4, solution, intervalRange)[0])

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to not distributing the negative in front of the first parentheses correctly.")
distractor2Interval.append(" Corresponds to not distributing the negative in front of the second parentheses correctly.")
distractor3Interval.append(" Corresponds to getting the negative of the actual solution.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
toAppendAnswer = '\\text{There are no real solutions.}'
toAppendComment = "Corresponds to students thinking a fraction means there is no solution to the equation."
answerList.append([toAppendAnswer, toAppendComment])

c0 = "x \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1])
c1 = "x \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1])
c2 = "x \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1])
c3 = "x \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1])
c4 = "\\text{There are no Real solutions. }"
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
