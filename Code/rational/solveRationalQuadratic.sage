import random
from sympy.abc import x
from sympy import solve

# Leads to 0, 1, or 2 solutions.
# Structure: (a*x)/(b*x+c) + (d*x**2)/(b*f*x**2 + (b*g+c*f)*x+c*g) = e/(f*x+g)

def generateCoefficients(numberOfSolutions):
    a = maybeMakeNegative(random.randint(2, 7))
    b = maybeMakeNegative(random.randint(2, 7))
    c = maybeMakeNegative(random.randint(2, 7))
    d = -random.randint(2, 7)
    e = maybeMakeNegative(random.randint(2, 7))
    f = maybeMakeNegative(random.randint(2, 7))
    g = maybeMakeNegative(random.randint(2, 7))
    discrim = (a*g-e*b)**2 - 4*(a*f+d)*(-e*c)
    leadingCoefficient = a*f+d

    if (numberOfSolutions == 0):
        while (leadingCoefficient==0 or discrim >= 0):
            a = maybeMakeNegative(random.randint(2, 7))
            b = maybeMakeNegative(random.randint(2, 7))
            c = maybeMakeNegative(random.randint(2, 7))
            d = -random.randint(2, 7)
            e = maybeMakeNegative(random.randint(2, 7))
            f = maybeMakeNegative(random.randint(2, 7))
            g = maybeMakeNegative(random.randint(2, 7))
            discrim = (a*g-e*b)**2 - 4*(a*f+d)*(-e*c)
            leadingCoefficient = a*f+d

    elif (numberOfSolutions ==1):
        while (leadingCoefficient==0 or discrim != 0):
            a = maybeMakeNegative(random.randint(2, 7))
            b = maybeMakeNegative(random.randint(2, 7))
            c = maybeMakeNegative(random.randint(2, 7))
            d = -random.randint(2, 7)
            e = maybeMakeNegative(random.randint(2, 7))
            f = maybeMakeNegative(random.randint(2, 7))
            g = maybeMakeNegative(random.randint(2, 7))
            discrim = (a*g-e*b)**2 - 4*(a*f+d)*(-e*c)
            leadingCoefficient = a*f+d

    else:
        while (leadingCoefficient==0 or discrim <= 0):
            a = maybeMakeNegative(random.randint(2, 7))
            b = maybeMakeNegative(random.randint(2, 7))
            c = maybeMakeNegative(random.randint(2, 7))
            d = -random.randint(2, 7)
            e = maybeMakeNegative(random.randint(2, 7))
            f = maybeMakeNegative(random.randint(2, 7))
            g = maybeMakeNegative(random.randint(2, 7))
            discrim = (a*g-e*b)**2 - 4*(a*f+d)*(-e*c)
            leadingCoefficient = a*f+d

    return [a, b, c, d, e, f, g]

def generateSolution(coefficients):
    a, b, c, d, e, f, g = coefficients
    quadraticEquation = (a*x)/(b*x+c) + (d*x**2)/(b*f*x**2 + (b*g+c*f)*x+c*g) - e/(f*x+g)
    print quadraticEquation
    solution = solve(quadraticEquation)
    print solution
    return solution

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def generateSolutionIntervals(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

def distractorDomainError1(coefficients):
    a, b, c, d, e, f, g = coefficients
    return -c/b

def distractorDomainError2(coefficients):
    a, b, c, d, e, f, g = coefficients
    return -g/f

def intervalToString(interval):
    return ['x \in [%s,%s]' %(interval[0], interval[1])]

def stringForAnswersWithTwoIntervals(leftInterval, rightInterval):
    print leftInterval
    leftL, leftR = leftInterval
    rightL, rightR = rightInterval
    return ['x_1 \in [%s, %s] \\text{ and } x_2 \in [%s,%s]' %(leftL, leftR, rightL, rightR)]

intervalRange = 6
numberOfSolutions = random.randint(0, 2)
#numberOfSolutions = 1
coefficients = generateCoefficients(numberOfSolutions)

# Display for LaTeX
#(a*x)/(b*x+c) + (d*x**2)/(b*f*x**2 + (b*g+c*f)*x+c*g) = e/(f*x+g)
# a, b, c, d, e, f, g
# 0, 1, 2, 3, 4, 5, 6

factorNumerator1 = coefficients[0]*x
factorDenominator1 = coefficients[1]*x + coefficients[2]
firstTerm = factorNumerator1/factorDenominator1

factorNumerator2 = coefficients[3]*x**2
factorDenominator2 = coefficients[1]*coefficients[5]*x**2 + (coefficients[1]*coefficients[6]+coefficients[2]*coefficients[5])*x+coefficients[2]*coefficients[6]
secondTerm = -factorNumerator2/factorDenominator2

factorNumerator3 = coefficients[4]
factorDenominator3 = coefficients[5]*x+coefficients[6]
thirdTerm = factorNumerator3/factorDenominator3
if (numberOfSolutions==0):
    solution = 'All solutions are invalid or lead to complex values in the equation.'
    solutionInterval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
    distractor1 = float(distractorDomainError1(coefficients))
    distractor2 = float(distractorDomainError2(coefficients))
    distractor3 = [float(distractorDomainError1(coefficients)), 0]
    distractor4 = [float(distractorDomainError2(coefficients)), 0]
    firstSolutionSet = [distractor1, distractor2, distractor3[0], distractor4[0]]

    precision = 1
    intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
    secondSolutionSet = [distractor3[1], distractor4[1]]
    intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)

    distractor1Interval = intervalToString(intervalOptionsFirstSet[0])
    distractor2Interval = intervalToString(intervalOptionsFirstSet[1])
    distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[2], intervalOptionsSecondSet[0])
    distractor4Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])

elif (numberOfSolutions==1):
    solution = float(generateSolution(coefficients)[0])
    #distractor1 =
    distractor2 = float(distractorDomainError1(coefficients))
    distractor3 = [float(distractorDomainError1(coefficients)), solution]
    distractor4 = [float(distractorDomainError2(coefficients)), solution]

    firstSolutionSet = [solution, distractor2, distractor3[0], distractor4[0]]
    precision = 1
    intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
    secondSolutionSet = [distractor3[1], distractor4[1]]
    intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)

    solutionInterval = intervalToString(intervalOptionsFirstSet[0])
    distractor1Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
    distractor2Interval = intervalToString(intervalOptionsFirstSet[1])
    distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[2], intervalOptionsSecondSet[0])
    distractor4Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])

else:
    solution = generateSolution(coefficients)
    print "This is the solution"
    print solution
    distractor1 = float(distractorDomainError2(coefficients))
    distractor2 = float(solution[1])
    distractor3 = [float(solution[0]), float(distractorDomainError1(coefficients))]
    #distractor4 =

    firstSolutionSet = [float(solution[0]), distractor1, distractor2, distractor3[0]]

    precision = 1
    intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
    secondSolutionSet = [float(solution[1]), distractor3[1]]
    intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)

    solutionInterval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[0], intervalOptionsSecondSet[0])
    distractor1Interval = intervalToString(intervalOptionsFirstSet[1])
    distractor2Interval = intervalToString(intervalOptionsFirstSet[2])
    distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])
    distractor4Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']

displayStem = 'Solve the rational equation below. Then, choose the interval(s) that the solution(s) belongs to.'
displayProblem = '%s - %s = %s' %(firstTerm, secondTerm, thirdTerm)
displaySolution = solution
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
