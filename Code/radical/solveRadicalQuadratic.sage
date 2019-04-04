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
    equation = (a*x+b)*(c*x+d)
    solution = solve(equation)
    # radical 1 = a*c*x**2+b*d
    if (a*c*solution[0]**2+b*d < 0):
        r0SolutionA = 0
    else:
        r0SolutionA = 1
    #radical 2 = -(a*d+b*c)*x
    if (-(a*d+b*c)*solution[0] < 0):
        r0SolutionB = 0
    else:
        r0SolutionB = 1

    if (a*c*solution[1]**2+b*d < 0):
        r1SolutionA = 0
    else:
        r1SolutionA = 1

    if (-(a*d+b*c)*solution[1] < 0):
        r1SolutionB = 0
    else:
        r1SolutionB = 1
    print
    print "Possible solutions are: %s and %s" %(solution[0], solution[1])
    print
    print "First radical to check: %d x^2 + %d" %(a*c, b*d)
    print "Values when plugged into first radical: %d and %d" %(a*c*solution[0]**2+b*d, a*c*solution[1]**2+b*d)
    print "Checks on first radical: %d and %d" %(r0SolutionA, r1SolutionA)
    print
    print "Second radical to check: %d x" %(-(a*d + b*c))
    print "Values when plugged into second radical: %d and %d" %(-(a*d+b*c)*solution[0], -(a*d+b*c)*solution[1])
    print "Checks on second radical: %d and %d" %(r0SolutionB, r1SolutionB)
    return [r0SolutionA, r0SolutionB, r1SolutionA, r1SolutionB]

def generateCoefficients(numberOfSolutions):
    # Converted to Quadratic Equation = (a*x+b)*(c*x+d)
    # a*c*x**2+(a*d+b*c)*x+bd
    # Force a fail so numbers are generated below.
    checkDiscriminant = 0
    check = [0, 0, 0, 0]
    #
    if (numberOfSolutions==0):
        # Makes sure each solution fails at least one of the radicals
        while (check[0]*check[1]+check[2]*check[3] > 0 or checkDiscriminant<=0 or (a==c and b==d)):
            a = maybeMakeNegative(random.randint(2, 9))
            b = maybeMakeNegative(random.randint(2, 9))
            c = maybeMakeNegative(random.randint(2, 9))
            d = maybeMakeNegative(random.randint(2, 9))
            check = radicalCheck([a, b, c, d])
            checkDiscriminant = float((a*d+b*c)**2 - 4*a*c*b*d)
    elif (numberOfSolutions==1):
        while (check[0]*check[1]+check[2]*check[3] !=1 or checkDiscriminant<=0 or (a==c and b==d)):
            a = maybeMakeNegative(random.randint(2, 9))
            b = maybeMakeNegative(random.randint(2, 9))
            c = maybeMakeNegative(random.randint(2, 9))
            d = maybeMakeNegative(random.randint(2, 9))
            check = radicalCheck([a, b, c, d])
            checkDiscriminant = float((a*d+b*c)**2 - 4*a*c*b*d)
    else:
        while (check[0]*check[1]+check[2]*check[3] < 1 or checkDiscriminant<=0 or (a==c and b==d)):
            a = maybeMakeNegative(random.randint(2, 9))
            b = maybeMakeNegative(random.randint(2, 9))
            c = maybeMakeNegative(random.randint(2, 9))
            d = maybeMakeNegative(random.randint(2, 9))
            check = radicalCheck([a, b, c, d])
            checkDiscriminant = float((a*d+b*c)**2 - 4*a*c*b*d)
    return [a, b, c, d]

def generateSolutionToQuadratic(coefficients):
    a, b, c, d = coefficients
    equation = (a*x+b)*(c*x+d)
    solution = solve(equation)
    if solution[0] < solution[1]:
        return solution
    else:
        return [solution[1], solution[0]]

def intervalToString(interval):
    return ['x \in [%s,%s]' %(interval[0], interval[1])]

def stringForAnswersWithTwoIntervals(leftInterval, rightInterval):
    print leftInterval
    leftL, leftR = leftInterval
    rightL, rightR = rightInterval
    return ['x_1 \in [%s, %s] \\text{ and } x_2 \in [%s,%s]' %(leftL, leftR, rightL, rightR)]

# Options
    # There should always be a 'There is no solution to the equation.'
    # Two with a single solution
        # One of the solutions from (a*x+b)*(c*x+d)
        # The other solution from (a*x+b)*(c*x+d)
    # Two with two solutions
        # Both solutions to the quadratic (a*x+b)*(c*x+d)
        # Solutions to the equation (a*x+b)*(-c*x-d)

intervalRange=4
numberOfSolutions = random.randint(0, 2)
#numberOfSolutions = 2
coefficients = generateCoefficients(numberOfSolutions)
print
print "print Number of Solutions: %d" %numberOfSolutions
print "Coefficients for last problem: %s" %coefficients
print
print

# sqrt{\sage{displayFactor1}} - \sage{displayFactor2} = 0
if coefficients[1]*coefficients[3] < 0:
    displayFactor1 = "%d x^2 - %d" %(coefficients[0]*coefficients[2], -coefficients[1]*coefficients[3])
else:
    displayFactor1 = "%d x^2 + %d" %(coefficients[0]*coefficients[2], coefficients[1]*coefficients[3])
displayFactor2 = "%d x" %(-(coefficients[0]*coefficients[3] + coefficients[1]*coefficients[2]))

# Different cases for each number of solutions
if (numberOfSolutions==0):
    solution = generateSolutionToQuadratic(coefficients)
    print solution
    solutionInterval = ['\\text{All solutions lead to invalid or complex values in the equation.}']

    distractor1 = solution[0]
    distractor2 = solution[1]
    distractor3 = solution
    if (abs(solution[0])==solution[0] and abs(solution[1])==solution[1] ):
        distractor4 = [-solution[0], -solution[1]]
    else:
        distractor4 = [abs(solution[0]), abs(solution[1])]

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
    # Radical Check: Checks if the solution is allowed in the first (0) and second (1) radical
    # [r0SolutionA, r0SolutionB, r1SolutionA, r1SolutionB]
    findZeros = radicalCheck(coefficients)
    print
    print
    print "Radical Check: %s" %findZeros
    print
    print
    if (findZeros[0]*findZeros[1]==0): # This means the first zero failed at least one of the radicals
        solutionToQuadratic = generateSolutionToQuadratic(coefficients)
        solution = solutionToQuadratic[1] # Thus the one solution must be the other zero.
        distractor1 = solutionToQuadratic[0]
    else:
        solutionToQuadratic = generateSolutionToQuadratic(coefficients) # If it didn't fail, then it is the correct zero.
        solution = solutionToQuadratic[0]
        distractor1 = solutionToQuadratic[1]

    distractor2Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']
    firstSolutionSet = [solution, distractor1, distractor3[0], distractor4[0]]
    precision = 1
    intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
    secondSolutionSet = [distractor3[1], distractor4[1]]
    intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)
    solutionInterval = intervalToString(intervalOptionsFirstSet[0])
    distractor1Interval = intervalToString(intervalOptionsFirstSet[1])
    distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[2], intervalOptionsSecondSet[0])
    distractor4Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])

else:
    solution = generateSolutionToQuadratic(coefficients)
    solutionInterval = stringForAnswersWithTwoIntervals(generateSolutionInterval(float(solution[0]), intervalRange), generateSolutionInterval(float(solution[1]), intervalRange))

    distractor1 = solution[0]
    distractor2 = solution[1]
    if (abs(solution[0])==solution[0] and abs(solution[1])==solution[1] ):
        distractor3 = [-solution[0], -solution[1]]
    else:
        distractor3 = [abs(solution[0]), abs(solution[1])]
    #distractor4

    firstSolutionSet = [solution[0], distractor1, distractor2, distractor3[0]]
    precision = 1
    intervalOptionsFirstSet = createIntervalOptions(firstSolutionSet, intervalRange, precision)
    secondSolutionSet = [solution[1], distractor3[1]]
    intervalOptionsSecondSet = createIntervalOptions(secondSolutionSet, intervalRange, precision)
    solutionInterval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[0], intervalOptionsSecondSet[0])
    distractor1Interval = intervalToString(intervalOptionsFirstSet[1])
    distractor2Interval = intervalToString(intervalOptionsFirstSet[2])
    distractor3Interval = stringForAnswersWithTwoIntervals(intervalOptionsFirstSet[3], intervalOptionsSecondSet[1])
    distractor4Interval = ['\\text{All solutions lead to invalid or complex values in the equation.}']

displayStem = 'Solve the radical equation below. Then, choose the interval(s) that the solution(s) belongs to.'
displayProblem = '\\sqrt{%s} - \\sqrt{%s} = 0' %(displayFactor1, displayFactor2)
displaySolution = '\\text{that there are } %d \\text{ many solutions and they are } %s' %(numberOfSolutions, solution)
print displaySolution
comments = "General Comments: Distractors are different based on the number of solutions. For example, if the question is designed to have 0 options, then the distractors are solving the equation and not checking that the solutions lead to complex numbers (because plugging them in makes the value under the square root negative). Remember that after solving, we need to make sure our solution does not make the original equation take the square root of a negative number!"

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

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I finished Module 6, Objective 3, Type 2, Master"
