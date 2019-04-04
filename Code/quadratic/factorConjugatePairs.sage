# Objective 3 - Factor a trinomial with leading coefficient greater than 1.
# Create 3 different types - print 1 of each type
from sympy.abc import x
import random
import math
print "Starting Objective 3 Type 1!"
load("../Code/generalPurposeMethods.sage")

def generateSolution(minimum, maximum):
    a = random.randint(minimum, maximum)
    b = random.randint(minimum, maximum)
    return [a, -b, a, b]
def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
def distractorPositivePairs(solution):
    a, b = solution[0], solution[1]
    return[a, b, a, b]
def distractorNegativePairs(solution):
    a, b = solution[0], solution[1]
    return[a, -b, a, -b]
def distractorNegativePairsWrongA(solution):
    b = solution[1]
    return[1, -b, 1, -b]
def distractorConjugatePairsWrongA(solution):
    a, b = solution[0], solution[1]
    return[1, -b, 1, b]

solution = generateSolution(3, 9)
distractor1 = distractorNegativePairs(solution)
distractor2 = distractorPositivePairs(solution)
distractor3 = distractorNegativePairsWrongA(solution)
distractor4 = distractorConjugatePairsWrongA(solution)
solutionList = [solution, distractor1, distractor2, distractor3, distractor4]

while (solutionList[0]==solutionList[1] or solutionList[0]==solutionList[2] or solutionList[0]==solutionList[3] or solutionList[0]==solutionList[4] or solutionList[1]==solutionList[2] or solutionList[1]==solutionList[3] or solutionList[1]==solutionList[4] or solutionList[2]==solutionList[3] or solutionList[2]==solutionList[4] or solutionList[3]==solutionList[4]):
    solution = generateSolution(3, 9)
    distractor1 = distractorNegativePairs(solution)
    distractor2 = distractorPositivePairs(solution)
    distractor3 = distractorNegativePairsWrongA(solution)
    distractor4 = distractorConjugatePairsWrongA(solution)
    solutionList = [solution, distractor1, distractor2, distractor3, distractor4]


generalFormTypeOne = solution[0]**2 * x**2 - solution[1]**2
displayStem = 'Factor the quadratic below. Then, choose the intervals that contain the constants in the form $(ax+b)(cx+d); b \\leq d.$'
displayProblem = "%s x^2 - %s" %(solution[0]**2, solution[1]**2)

solutionFactor0 = solution[0]*x + solution[1]
solutionFactor1 = solution[2]*x + solution[3]
displaySolution = '(%s x - %s)(%s + %s)' %(solution[0], -solution[1], solution[2], solution[3])

precision = 1
intervalRange = 5
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

comments = "General Comments: When the second term is missing, the factors are conjugate pairs: $(ax-b)(ax+b)$."

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Distractor 1: Corresponds to negative pair of factors.")
distractor2Interval.append(" Distractor 2: Corresponds to positive pair of factors.")
distractor3Interval.append(" Distractor 3: Corresponds to negative pairs with the wrong a.")
distractor4Interval.append(" Distractor 4: Corresponds to conjugate pairs with the wrong a.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "Finished Objective 3 Type 1!"
