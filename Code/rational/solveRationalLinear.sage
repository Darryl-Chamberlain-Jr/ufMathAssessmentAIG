import random
from sympy.abc import x
from sympy import solve
import fractions

def generateCoefficients(numberOfSolutions):
    # structure: (a/bx+c) - d = e/f(bx+c)
    if (numberOfSolutions==0):
        mask = random.randint(5, 14)
        a = maybeMakeNegative(random.randint(2, 9)) * mask
        d = -1
        f = 1
        e = a
        b = maybeMakeNegative(random.randint(2, 9)) * mask
        c = maybeMakeNegative(random.randint(2, 9)) * mask
        return [a, b, c, d, e, f]
    else:
        a = float(maybeMakeNegative(random.randint(2, 9)))
        b = float(maybeMakeNegative(random.randint(2, 9)))
        c = float(maybeMakeNegative(random.randint(2, 9)))
        d = float(maybeMakeNegative(random.randint(2, 9)))
        e = float(maybeMakeNegative(random.randint(2, 9)))
        f = float(maybeMakeNegative(random.randint(2, 9)))
        makeSolutionExist = float((-f*a +e + d*c*f)/(-d*f*b) + c/b)
        while (makeSolutionExist==0):
            a = float(maybeMakeNegative(random.randint(2, 9)))
            b = float(maybeMakeNegative(random.randint(2, 9)))
            c = float(maybeMakeNegative(random.randint(2, 9)))
            d = float(maybeMakeNegative(random.randint(2, 9)))
            e = float(maybeMakeNegative(random.randint(2, 9)))
            f = float(maybeMakeNegative(random.randint(2, 9)))
            makeSolutionExist = float((-f*a + e + d*c*f)/(-d*f*b) + c/b)
    return [a, b, c, d, e, f]

def generateSolution(coefficients, numberOfSolutions):
    a = float(coefficients[0])
    b = float(coefficients[1])
    c = float(coefficients[2])
    d = float(coefficients[3])
    e = float(coefficients[4])
    f = float(coefficients[5])

    if (numberOfSolutions == 0):
        return float(-c/b)
    else:
        return float((-f*a +e +d*c*f)/(-d*f*b))

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

# Distractors
# No solution when there is a solution / Solution when there is no solution
# Single and doubles
def distractorMisDistributeC(coefficients):
    a, b, c, d, e, f = coefficients
    return [a, b, -c, d, e, f]

def distractorForgetF(coefficients):
    a, b, c, d, e, f = coefficients
    return [a, b, c, d, e, int(1)]

def distractorForgetA(coefficients):
    a, b, c, d, e, f = coefficients
    return [int(1), b, c, d, e, f]

def intervalToString(interval):
    return ['x \in [%s,%s]' %(interval[0], interval[1])]

def stringForAnswersWithTwoIntervals(leftInterval, rightInterval):
    print leftInterval
    leftL, leftR = leftInterval
    rightL, rightR = rightInterval
    return ['x_1 \in [%s, %s] \\text{ and } x_2 \in [%s,%s]' %(leftL, leftR, rightL, rightR)]

# Two types of questions:
    # Rational -> Linear with no solutions
    # Rational -> Linear with one soltion

intervalRange = 2

#numberOfSolutions = random.randint(0, 1)
numberOfSolutions = 1
coefficients = generateCoefficients(numberOfSolutions)
solution = generateSolution(coefficients, numberOfSolutions)

#Display the functions correctly in SageTeX
x = Symbol('x')
factorNumerator1 = Integer(coefficients[0])
factorDenominator1 = Integer(coefficients[1])*x+Integer(coefficients[2])
factorNumerator2 = Integer(coefficients[3])
leftSide = factorNumerator1/factorDenominator1 - factorNumerator2
    #factorDenominator2 = 1
factorNumerator3 = Integer(coefficients[4])
factorDenominator3 = Integer(coefficients[1])*Integer(coefficients[5])*x + Integer(coefficients[5]*coefficients[2])

if (numberOfSolutions==0):
    solutionInterval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
    solutionLength = 0
    distractor1 = solution
    distractor1Length = 1
    distractor1Interval = intervalToString(generateSolutionInterval(float(solution), intervalRange))
else:
    solutionInterval = intervalToString(generateSolutionInterval(float(solution), intervalRange))
    solutionLength = 1
    distractor1 = 'All solutions are invalid or lead to complex values in the equation.'
    distractor1Length = 0
    distractor1Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']

distractor2 = generateSolution(distractorMisDistributeC(coefficients), 1)
distractor2Length = 1
if (distractor1 == distractor2):
    distractor2 = distractor2 + 1
else:
    distractor2 = distractor2
displayStem = 'Solve the rational equation below. Then, choose the interval(s) that the solution(s) belongs to.'
displayProblem = '\\frac{%s}{%s} - %s = \\frac{%s}{%s}' %(factorNumerator1, factorDenominator1, factorNumerator2, factorNumerator3, factorDenominator3)
if (numberOfSolutions==0):
    displaySolution = 'All solutions are invalid or lead to complex values in the equation.'
else:
    displaySolution = solution

distractor3 = [generateSolution(distractorMisDistributeC(coefficients), 1), solution]
distractor4 = [generateSolution(distractorForgetF(coefficients), 1), solution]

if(solutionLength == 0):
    firstSolutionSet = [distractor1, distractor2, distractor3[0], distractor4[0]]
else:
    firstSolutionSet = [solution, distractor2, distractor3[0], distractor4[0]]
    print "This is the Solution with distractors when there is a single solution. %s" %firstSolutionSet
precision = 1
intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
secondSolutionSet = [distractor3[1], distractor4[1]]
intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)
print intervalOptionsFirstSet
if(solutionLength == 0):
    distractor1Interval = intervalToString(intervalOptionsFirstSet[0])
else:
    solutionInterval = intervalToString(intervalOptionsFirstSet[0])
distractor2Interval = intervalToString(intervalOptionsFirstSet[1])
distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[2], intervalOptionsSecondSet[0])
distractor4Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])

generalComments = "General Comments: Distractors are different based on the number of solutions. Remember that after solving, we need to make sure our solution does not make the original equation divide by zero!"

solutionInterval.append('* This is the real solution')
distractor1Interval.append(' Distractor 1')
distractor2Interval.append(' Distractor 2')
distractor3Interval.append(' Distractor 3')
distractor4Interval.append(' Distractor 4')
answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
c4 = answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = ["", "", "", "", ""]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)
