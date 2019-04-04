import numpy
from sympy.abc import x
from sympy import Symbol
import random
import math

print "Starting Objective 1 Type 1"
# OBJECTIVE 1 - Constructing linear functions from points and slope
# We can make a few types of this:
    # Type 1 - Two points (zero/non-zero slope)
    # Type 2 - Another line and a point
    # Type 3 - Go from graph to equation (either slope-int or standard)
    # Future Type - Ask for Standard Form A, B, C.

# Type 1 - Two points
# Since it doesn't matter if the slope is zero or not, we just need to make
    # sure the denominator is not zero. I'd also like to avoid 0 as a coordinate.
def generateProblem(minimum, maximum):
    pointOne = [maybeMakeNegative(random.randint(minimum, maximum)), maybeMakeNegative(random.randint(minimum, maximum))]
    pointTwo = [maybeMakeNegative(random.randint(minimum, minimum)), maybeMakeNegative(random.randint(minimum, maximum))]
    numerator = float(pointTwo[1]-pointOne[1])
    denominator = float(pointTwo[0]-pointOne[0])
    slope = float(numerator/denominator)
    while (pointOne[0]==pointTwo[0] or pointOne[1]==pointTwo[1] or slope==1):
        pointOne = [maybeMakeNegative(random.randint(minimum, maximum)), maybeMakeNegative(random.randint(minimum, maximum))]
        pointTwo = [maybeMakeNegative(random.randint(minimum, minimum)), maybeMakeNegative(random.randint(minimum, maximum))]
        numerator = float(pointTwo[1]-pointOne[1])
        denominator = float(pointTwo[0]-pointOne[0])
        slope = float(numerator/denominator)
    return [pointOne, pointTwo]

def generateSolution(problem):
    pointOne, pointTwo = problem
    numerator = float(pointTwo[1]-pointOne[1])
    denominator = float(pointTwo[0]-pointOne[0])
    slope = float(numerator/denominator)
    yInt = float(pointTwo[1]-slope*pointTwo[0])
    return [slope, yInt]
def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
def distractorSlopeSign(solution, problem):
    #Distractor (-slope, pointTwo[1]+slope*pointTwo[0])
    slope, yInt = solution
    pointOne, pointTwo = problem
    distractorSlope = -slope
    distractorYInt = pointTwo[1] + slope*pointTwo[0]
    return [distractorSlope, distractorYInt]
def distractorYIntSign(solution, problem):
    # (slope, -yInt)
    slope, yInt = solution
    pointOne, pointTwo = problem
    distractorSlope = slope
    distractorYInt = -yInt
    return [distractorSlope, distractorYInt]
def distractorPointSlopeMisdistribute1(solution, problem):
    #(slope, -pointOne[0]+pointOne[0])
    #This is if the student used point-slope and did not distribute correctly.
    slope, yInt = solution
    pointOne, pointTwo = problem
    distractorSlope = slope
    distractorYInt = -pointOne[0] + pointOne[1]
    return [distractorSlope, distractorYInt]
def distractorPointSlopeMisdistribute2(solution, problem):
    #(slope, -pointOne[0]+pointOne[0])
    #This is if the student used point-slope and did not distribute correctly.
    slope, yInt = solution
    pointOne, pointTwo = problem
    distractorSlope = slope
    distractorYInt = -pointTwo[0] + pointTwo[1]
    return [distractorSlope, distractorYInt]
minimum, maximum = 2, 9
intervalRange = 3
problem = generateProblem(minimum, maximum)

pointOne, pointTwo = problem

solution = generateSolution(problem)
distractor1 = distractorSlopeSign(solution, problem)
distractor2 = distractorYIntSign(solution, problem)
distractor3 = distractorPointSlopeMisdistribute1(solution, problem)
distractor4 = distractorPointSlopeMisdistribute2(solution, problem)

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

displayStem = 'First, find the equation of the line containing the two points below. Then, write the equation as $ y=mx+b $ and choose the intervals that contain $m$ and $b$.'
displayProblem = "(%s, %s) \\text{ and } (%s, %s)" %(pointOne[0], pointOne[1], pointTwo[0], pointTwo[1])

if solution[1] < 0:
    solutionFunction = "%s x - %s" %(round(solution[0], 3), -round(solution[1], 3))
else:
    solutionFunction = "%s x + %s" %(round(solution[0], 3), round(solution[1], 3))
displaySolution = "y = %s" %solutionFunction

comments = "General Comments: Remember to keep your points in order when plugging in to the slope formula."

print intervalOptions
solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
# Separately generated intervals for slopes in these to make a better display. Will be fixed in the future.
distractor2Interval = [createIntervalOptions([solutionList[2][0]], intervalRange, precision)[0], intervalOptions[2][1] ]
distractor3Interval = [createIntervalOptions([solutionList[3][0]], intervalRange, precision)[0], intervalOptions[3][1] ]
distractor4Interval = [createIntervalOptions([solutionList[4][0]], intervalRange, precision)[0], intervalOptions[4][1] ]
print
print "Is this the issue? %s" %distractor2Interval
print

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to using the negative slope and the correct equation.")
distractor2Interval.append(" Corresponds to using the correct slope and getting the negative y-intercept.")
distractor3Interval.append(" Corresponds to using the correct slope/equation but not distributing correctly using the first point.")
distractor4Interval.append(" Corresponds to using the correct slope/equation but not distributing correctly using the second point.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "m \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1])
c1 = "m \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1])
c2 = "m \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1])
c3 = "m \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1])
c4 = "m \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][2]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
