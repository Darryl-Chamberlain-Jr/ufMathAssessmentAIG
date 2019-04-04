# OBJECTIVE 3 - Solve quadratic equations using the Quadratic Formula

from sympy.abc import x
from sympy.solvers import solve
import random
import math

#load("../Code/generalPurposeMethods.sage")
print "I have begun running Objective 3"

def generateProblemDisplay(a, b, c):
    if b < 0:
        if c < 0:
            display = "%s x^2 - %s x - %s" %(a, -b, -c)
        else:
            display = "%s x^2 - %s x + %s" %(a, -b, c)
    else:
        if c < 0:
            display = "%s x^2 + %s x - %s" %(a, b, -c)
        else:
            display = "%s x^2 + %s x + %s" %(a, b, c)
    return display

def generateSolution(coefficients):
    a, b, c = coefficients
    solveThisQuadratic = a*x**2+b*x+c
    solution = solve(solveThisQuadratic, x)

    if (solution[0] < solution[1]):
        return solution
    else:
        dummyTransition = [solution[1], solution[0]]
        solution = [dummyTransition[0], dummyTransition[1]]
        return solution

def findDiscriminant(coefficients):
    a, b, c = coefficients
    return b**2 - 4*a*c

def is_square(integer):
    root = math.sqrt(integer)
    if int(root + 0.5) ** 2 == integer:
        return True
    else:
        return False

def generateSolutionSetInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

def distractorForgotA(coefficients):
    a, b, c = coefficients
    distractor = generateSolution([1, b, a*c])
    return distractor

def distractorPositiveB(coefficients):
    a, b, c = coefficients
    distractor = generateSolution([a, -b, c])
    return distractor

def distractorForgotAandPositiveB(coefficients):
    a, b, c = coefficients
    distractor = generateSolution([1, -b, a*c])
    return distractor

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

def generateAnswerChoiceFromIntervalList(intervalList):
    outputString = "x_1 \\in [%d, %d]" %(intervalList[0][0], intervalList[0][1])
    outputString += "\\text{ and } x_2 \\in [%d, %d]" %(intervalList[1][0], intervalList[1][1])
    return [outputString]

def cleanUpSolution(solutionList):
    for i in xrange(len(solutionList)):
        solutionList[i] = float(solutionList[i])
    return solutionList
intervalRange = 3

coefficients = [maybeMakeNegative(random.randint(2, 9)), maybeMakeNegative(random.randint(2, 9)), maybeMakeNegative(random.randint(2, 9))]
discrim = findDiscriminant(coefficients)
while (discrim <= 0 or is_square(discrim)==true):
    coefficients = [maybeMakeNegative(random.randint(2, 9)), maybeMakeNegative(random.randint(2, 9)), maybeMakeNegative(random.randint(2, 9))]
    discrim = findDiscriminant(coefficients)

solution = generateSolution(coefficients)
solutionIntervalTemp = generateSolutionInterval(solution, intervalRange)

problemQuadraticFormula = coefficients[0]*x**2 + coefficients[1]*x + coefficients[2]
#problemQuadraticFormula = coefficients[0]*x**2 + coefficients[1]*x+ coefficients[2]

distractor1 = cleanUpSolution(distractorForgotA(coefficients))
distractor2 = cleanUpSolution(distractorPositiveB(coefficients))
distractor3 = cleanUpSolution(distractorForgotAandPositiveB(coefficients))
# last distractor is "There are no Real solutions"

#distractor1Solved = cleanUpSolution(generateSolution(distractor1))
#distractor2Solved = cleanUpSolution(generateSolution(distractor2))
#distractor3Solved = cleanUpSolution(generateSolution(distractor3))
solution = cleanUpSolution(solution)

solutionList = [solution, distractor1, distractor2, distractor3]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
#distractor4Interval = ["\\text{There are no Real solutions}"]

displayStem = 'Solve the quadratic equation below. Then, choose the intervals that the solutions belong to, with $x_1 \\leq x_2$ (if they exist).'
displayProblem = "%s = 0" %generateProblemDisplay(coefficients[0], coefficients[1],  coefficients[2])
displaySolution = "x_1 = %s \\text{ and } x_2 = %s" %(round(solution[0], 3),  round(solution[1], 3))
comments = "General Comments: This requires Quadratic Formula. Just be sure to use the correct formula and watch your signs."

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Distractor: Corresponds to using $a=1$.")
distractor2Interval.append(" Distractor: Corresponds to mis-writing the Quadratic Formula as b plus or minus...")
distractor3Interval.append(" Distractor: Corresponds to using $a=1$ AND mis-writing the Quadratic Formula as b plus or minus...")
#distractor4Interval.append(" Distractor: Corresponds to believing that if you cannot factor, there is no solution.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
answerList.append("\\text{There are no Real solutions}")

c0 = "x_1 \\in [%s, %s] \\text{ and } x_2 \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1])
c1 = "x_1 \\in [%s, %s] \\text{ and } x_2 \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1])
c2 = "x_1 \\in [%s, %s] \\text{ and } x_2 \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1])
c3 = "x_1 \\in [%s, %s] \\text{ and } x_2 \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1])
c4 = "\\text{There are no Real solutions.}"
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], "Distractor: Corresponds to believing that if you cannot factor, there is no solution."]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I have finished running Objective 3"
