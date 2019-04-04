# OBJECTIVE 3 - Utilize the properties of logaritmic functions to simplify expressions
# a = \sqrt{\frac{\sage{numerator}}{e^x}}
import math
load("../Code/generalPurposeMethods.sage")
def generateSolution(numerator, a):
    solution = float(log(numerator) - 2*a)
    return solution

def distractorSolutionNegation(numerator, a):
    solution = float(-log(numerator)+2*a)
    return solution

def distractorSolutionHalf(numerator, a):
    solution = float(log(numerator)/2 - a)
    print solution
    return solution

def distractorSolutionNegationAndHalf(numerator, a):
    solution = float(-log(numerator)/2 + a)
    print solution
    return solution

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def intervalToString(interval):
    return ['x \in [%s,%s]' %(interval[0], interval[1])]

# 0 = \ln \sqrt{\frac{\sage{numerator}}{e^x}
intervalRange = 4
numerator = random.randint(20, 30)
a = random.randint(5, 25)
solution = generateSolution(numerator, a)
solutionInterval = intervalToString(generateSolutionInterval(float(solution), intervalRange))

distractor1 = distractorSolutionNegation(numerator, a)
distractor2 = distractorSolutionHalf(numerator, a)
distractor3 = distractorSolutionNegationAndHalf(numerator, a)
#distractor4

solutionList = [solution, distractor1, distractor2, distractor3]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalToString(intervalOptions[0])
distractor1Interval = intervalToString(intervalOptions[1])
distractor2Interval = intervalToString(intervalOptions[2])
distractor3Interval = intervalToString(intervalOptions[3])
#distractor4Interval = ['\\text{There is no solution to the equation.}']

solutionInterval.append('* This is the real solution')
distractor1Interval.append(' Distractor 1: This corresponds to getting the negative of the solution.')
distractor2Interval.append(' Distractor 2: This corresponds to leaving 1/2 in front of the log.')
distractor3Interval.append(' Distractor 3: This corresponds to leaving 1/2 in front of the log AND getting the negative of the solution.')
#distractor4Interval.append(' This is a distractor')
answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
answerList.append('\\text{There is no Real solution to the equation.}')

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
c4 = "\\text{There is no solution to the equation.}"
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], "This corresponds to believing the exponential functional cannot be solved."]

displayStem = ' Solve the equation for $x$ and choose the interval that contains $x$ (if it exists).'
displayProblem = ' %s = \\ln{\\sqrt{\\frac{%d}{e^x}}}' %(a, numerator)
displaySolution = "x = %f" %round(solution, 3)

generalComments = "General comments: After using the properties of logarithmic functions to break up the right-hand side, use $\\ln(e) = 1$ to reduce the question to a linear function to solve. You can put $\\ln(%d)$ into a calculator if you are having trouble." %numerator

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I finished Module 8, Objective 3 Master"
