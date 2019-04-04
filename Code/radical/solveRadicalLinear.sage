# Module 5 - Radical Equations
    # Objective 1 - Identify the domain on which a radical function is not defined.
    # Objective 2 - Identify the graph of a radical function.
        # Two types of questions:
            # Graph to equation
            # Equation to graph
    # Objective 3 - Solve radical equations that lead to linear equations.
    # Objective 4 - Solve radical equations that lead to quadratic equations.

import random
from sympy.abc import x
from sympy import solve

def radicalCheck(coefficients):
    a, b, c, d = coefficients
    af = float(a)
    bf = float(b)
    cf = float(c)
    df = float(d)
    solution = float((df-bf)/(af-cf))
    print "Check this solution (%s) against \\frac{%s-%s}{%s-%s}" %(solution, d, b, a, c)
    if (af*solution + bf < 0):
        r0 = 0
    else:
        r0 = 1

    if (cf*solution + df < 0):
        r1 = 0
    else:
        r1 = 1
    return [r0, r1]

def generateCoefficients(numberOfSolutions):
    a = maybeMakeNegative(random.randint(2, 9))
    c = maybeMakeNegative(random.randint(2, 9))
    while(a==c):
        a = maybeMakeNegative(random.randint(2, 9))
        c = maybeMakeNegative(random.randint(2, 9))
    b = maybeMakeNegative(random.randint(2, 9))
    d = maybeMakeNegative(random.randint(2, 9))

    check = radicalCheck([a, b, c, d])

    if (numberOfSolutions==0):
        while (check[0]*check[1] > 0):
            a = maybeMakeNegative(random.randint(2, 9))
            c = maybeMakeNegative(random.randint(2, 9))
            while(a==c):
                a = maybeMakeNegative(random.randint(2, 9))
                c = maybeMakeNegative(random.randint(2, 9))
            b = maybeMakeNegative(random.randint(2, 9))
            d = maybeMakeNegative(random.randint(2, 9))
            check = radicalCheck([a, b, c, d])
        return [a, b, c, d]
    else:
        while (check[0]*check[1] == 0):
            a = maybeMakeNegative(random.randint(2, 9))
            c = maybeMakeNegative(random.randint(2, 9))
            while(a==c):
                a = maybeMakeNegative(random.randint(2, 9))
                c = maybeMakeNegative(random.randint(2, 9))
            b = maybeMakeNegative(random.randint(2, 9))
            d = maybeMakeNegative(random.randint(2, 9))
            check = radicalCheck([a, b, c, d])
        return [a, b, c, d]

def generateSolution(coefficients):
    a, b, c, d = coefficients
    fa = float(a)
    fb = float(b)
    fc = float(c)
    fd = float(d)
    solution = float((fd - fb)/(fa - fc))
    return solution

def intervalToString(interval):
    return ['x \in [%s,%s]' %(interval[0], interval[1])]

def stringForAnswersWithTwoIntervals(leftInterval, rightInterval):
    print leftInterval
    leftL, leftR = leftInterval
    rightL, rightR = rightInterval
    return ['x_1 \in [%s, %s] \\text{ and } x_2 \in [%s,%s]' %(leftL, leftR, rightL, rightR)]

def distractorNegativeSolution(coefficients):
    a, b, c, d = coefficients
    return [a, -b, c, -d]

#Thoughts to test in the future
def distractorBalanceIncorrectly(coefficients):
    a, b, c, d = coefficients
    return [a, -b, -c, d]

def distractorFlipFraction(coefficients):
    a, b, c, d = coefficients
    if (d-b==0):
        return [d+1, c, b, a]
    else:
        return [d, c, b, a]

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

intervalRange=4
numberOfSolutions = random.randint(0, 1)
#numberOfSolutions = 0
coefficients = generateCoefficients(numberOfSolutions)
solution = generateSolution(coefficients)
# sqrt{\sage{displayFactor1}} - sqrt{\sage{displayFactor2}} = 0

if coefficients[1] < 0:
    displayFactor1 = "%d x - %d" %(coefficients[0], -coefficients[1])
else:
    displayFactor1 = "%d x + %d" %(coefficients[0], coefficients[1])

if coefficients[3] <0:
    displayFactor2 = "%d x - %d" %(coefficients[2], -coefficients[3])
else:
    displayFactor2 = "%d x + %d" %(coefficients[2], coefficients[3])

if (numberOfSolutions==1):
    solutionLength = 1
    distractor1Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
else:
    solutionLength = 0
    solutionInterval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
    distractor1 = solution

displayStem = 'Solve the radical equation below. Then, choose the interval(s) that the solution(s) belongs to.'
displayProblem = '\\sqrt{%s} - \sqrt{%s} = 0' %(displayFactor1, displayFactor2)
if (numberOfSolutions==0):
    displaySolution = '\\text{All solutions lead to invalid or complex values in the equation.}'
else:
    displaySolution = 'x = %s' %(solution)

distractor2 = generateSolution(distractorNegativeSolution(coefficients))
distractor3 = [solution, generateSolution(distractorFlipFraction(coefficients))]
distractor4 = [solution, generateSolution(distractorNegativeSolution(coefficients))]

if(solutionLength == 0):
    firstSolutionSet = [distractor1, distractor2, distractor3[0], distractor4[0]]
else:
    firstSolutionSet = [solution, distractor2, distractor3[0], distractor4[0]]
precision = 1
intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
secondSolutionSet = [distractor3[1], distractor4[1]]
intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)
if(solutionLength == 0):
    distractor1Interval = intervalToString(intervalOptionsFirstSet[0])
else:
    solutionInterval = intervalToString(intervalOptionsFirstSet[0])
distractor2Interval = intervalToString(intervalOptionsFirstSet[1])
distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[2], intervalOptionsSecondSet[0])
distractor4Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])

solutionInterval.append('* This is the correct option.')
distractor1Interval.append('')
distractor2Interval.append('')
distractor3Interval.append('')
distractor4Interval.append('')
answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
c4 = answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

comments = "General Comments: Distractors are different based on the number of solutions. For example, if the question is designed to have 0 options, then the distractors are solving the equation and not checking that the solution leads to complex numbers (because plugging them in makes the value under the square root negative). Remember that after solving, we need to make sure our solution does not make the original equation take the square root of a negative number!"

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I finished Module 6, Objective 3, Master"
