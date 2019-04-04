import random
from sympy.abc import x
from sympy import solve
from sympy import Symbol

#load("../Code/generalPurposeMethods.sage")

# OBJECTIVE 2 - Solve single linear inequalities
# Types: Basic (no fractions, no division by negative) and Advanced

# TYPE 1 - Advanced (fractions)
# For now, these can just use >
# block[0] + block[1] * x > block[2] * x + block[3]
    # If we make block[1] < block[2], we can get students to divide by a negative

def createNumerators():
    numerators = [0, 0, 0, 0]
    while (numerators[1] >= numerators[2] or numerators[0] == numerators[3]):
        numerators[0] = maybeMakeNegative(random.randint(3, 10))
        numerators[1] = maybeMakeNegative(random.randint(3, 10))
        numerators[2] = maybeMakeNegative(random.randint(3, 10))
        numerators[3] = maybeMakeNegative(random.randint(3, 10))
    return numerators

def createDenominators():
    listOfDenominators= range(2, 10)
    denominators = random.sample(listOfDenominators, 4)
    return denominators

def createIntervalDisplay(numerators, denominators):
    n0 = float(numerators[0])
    n1 = float(numerators[1])
    n2 = float(numerators[2])
    n3 = float(numerators[3])

    d0 =float(denominators[0])
    d1 =float(denominators[1])
    d2 =float(denominators[2])
    d3 =float(denominators[3])

    x = Symbol('x')
    left = (n0/d0)+(n1/d1)*x
    right = (n2/d2)*x+(n3/d3)
    endpoint = solve(left-right)

    while (endpoint==[] or abs(endpoint[0])<1 ):
        numerators = createNumerators()
        denominators = createDenominators()

        n0 = float(numerators[0])
        n1 = float(numerators[1])
        n2 = float(numerators[2])
        n3 = float(numerators[3])

        d0 =float(denominators[0])
        d1 =float(denominators[1])
        d2 =float(denominators[2])
        d3 =float(denominators[3])

        x = Symbol('x')
        left = (n0/d0)+(n1/d1)*x
        right = (n2/d2)*x+(n3/d3)
        endpoint = solve(left-right)

    nearEndpoint = float(endpoint[0]) - 1
    checkNearby = float(float(n0/d0)+float(n1/d1)*nearEndpoint - float(n2/d2)*nearEndpoint-float(n3/d3))

    numerators = [n0, n1, n2, n3]
    denominators = [d0, d1, d2, d3]

    if (checkNearby > 0):
        return [0, endpoint[0], numerators, denominators]
    else:
        return [endpoint[0], 0, numerators, denominators]

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def distractorInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [b, a]

def distractorNegateSolution(intervalPresentation):
    a, b = intervalPresentation
    return [-a, -b]

def distractorNegateAndInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [-b, -a]

def intervalWithInfinityToStringInclusive(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return "(-\infty, a]"
    else:
        return "[a, \infty)"
def intervalWithInfinityToStringExclusive(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return "(-\infty, a)"
    else:
        return "(a, \infty)"
def extractValue(solutionInterval):
    a, b = solutionInterval
    if(a == 0):
        return b
    else:
        return a

intervalRange = 3
numerators = createNumerators()
denominators = createDenominators()
intervalAndValues = createIntervalDisplay(numerators, denominators)

intervalDisplay = [intervalAndValues[0], intervalAndValues[1]]
#Since numerators and denominators were redefined to create a good endpoint, they need to be redefined to display properly.
numerators = intervalAndValues[2]
n0 = Integer(numerators[0])
n1 = Integer(numerators[1])
n2 = Integer(numerators[2])
n3 = Integer(numerators[3])

denominators = intervalAndValues[3]
d0 = Integer(denominators[0])
d1 = Integer(denominators[1])
d2 = Integer(denominators[2])
d3 = Integer(denominators[3])

# Display for LaTeX
x = Symbol('x')
displayLeftFactor = Rational(n0/d0) + Rational(n1/d1) * x
displayRightFactor = Rational(n2/d2) * x + Rational(n3/d3)

intervalPresentation = intervalDisplay

solution = [extractValue(intervalPresentation)]
distractor1 = [extractValue(distractorNegateSolution(intervalPresentation))]
distractor2 = [extractValue(distractorInverseDomain(intervalPresentation))]
distractor3 = [extractValue(distractorNegateAndInverseDomain(intervalPresentation))]

solutionList = [solution, distractor1, distractor2, distractor3]

solutionList1 = [solution, distractor1]
solutionList2 = [distractor2, distractor3]
solutionList = [solution, distractor1, distractor2, distractor3]
precision = 1
intervalOptions1 = createIntervalOptions(solutionList1, intervalRange, precision)
intervalOptions2 = createIntervalOptions(solutionList2, intervalRange, precision)

solutionInterval = [intervalWithInfinityToStringExclusive(intervalPresentation), intervalOptions1[0]]
distractor1Interval = [intervalWithInfinityToStringExclusive(distractorNegateSolution(intervalPresentation)), intervalOptions1[1]]
distractor2Interval = [intervalWithInfinityToStringExclusive(distractorInverseDomain(intervalPresentation)), intervalOptions2[0]]
distractor3Interval = [intervalWithInfinityToStringExclusive(distractorNegateAndInverseDomain(intervalPresentation)), intervalOptions2[1]]

displayStem = 'Solve the linear inequality below. Then, choose the constant and interval combination that describes the solution set.'

display0 = Rational(n0/d0)
display1 = Rational(n1/d1)
display2 = Rational(n2/d2)
display3 = Rational(n3/d3)
if n1 < 0 and n3 < 0:
    displayProblem = "\\frac{%d}{%d} - \\frac{%d}{%d} x > \\frac{%d}{%d} x - \\frac{%d}{%d}" %(n0, d0, -n1, d1, n2, d2, -n3, d3)
elif n1 < 0 and n3 > 0:
    displayProblem = "\\frac{%d}{%d} - \\frac{%d}{%d} x > \\frac{%d}{%d} x + \\frac{%d}{%d}" %(n0, d0, -n1, d1, n2, d2, n3, d3)
elif n1 > 0 and n3 < 0:
    displayProblem = "\\frac{%d}{%d} + \\frac{%d}{%d} x > \\frac{%d}{%d} x - \\frac{%d}{%d}" %(n0, d0, n1, d1, n2, d2, -n3, d3)
else:
    displayProblem = "\\frac{%d}{%d} + \\frac{%d}{%d} x > \\frac{%d}{%d} x + \\frac{%d}{%d}" %(n0, d0, n1, d1, n2, d2, n3, d3)

display0 = round(float(intervalDisplay[0]), 3)
display1 = round(float(intervalDisplay[1]), 3)
if intervalDisplay[0] == 0:
    displaySolution = "(-\\infty, %s)" %display1
else:
    displaySolution = "(%s, \\infty)" %display0

comments = "General Comments: Remember that less than or equal to includes the endpoint. Also, when multiplying or dividing by a negative, flip the sign."

solutionInterval.append(' * Correct option.')
distractor1Interval.append("Corresponds to getting the negative of the solution.")
distractor2Interval.append("Corresponds to inverting the inequality.")
distractor3Interval.append("Corresponds to inverting the inequality AND getting the negative of the solution.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)
toAppendAnswer = "\\text{There is no solution to the inequality.}"
toAppendComment = "Corresponds to the variable canceling, which does not happen in this instance."
answerList.append([toAppendAnswer, toAppendComment])

c0 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[0][0], answerList[0][1][0][0], answerList[0][1][0][1])
c1 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[1][0], answerList[1][1][0][0], answerList[1][1][0][1])
c2 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[2][0], answerList[2][1][0][0], answerList[2][1][0][1])
c3 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[3][0], answerList[3][1][0][0], answerList[3][1][0][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print
print "I finished Module 4, Objective 2, Type 2, Master"
