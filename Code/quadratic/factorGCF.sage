# OBJECTIVE 1 - Factor the GCF out of an expression
import numpy
from sympy.abc import x, y
from sympy import Symbol

load("../Code/generalPurposeMethods.sage")
#load("./generalPurposeMethods.sage")

def generateSolutionIntervals(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
def generateDistractorDivideByFour(solution, additionalFactor):
    return [additionalFactor, solution[1], solution[2]]
def generateDistractorMaxFactors(problem):
    One, Two, Three = problem
    output = [max(One[i], Two[i], Three[i]) for i in xrange(len(One))]
    return output
def generateDistractorMaxFactorsWithGCD(problem, GCDconstants):
    One, Two, Three = problem
    output = [max(One[i], Two[i], Three[i]) for i in xrange(len(One))]
    output[0] = GCDconstants
    return output
def generateDistractorMinMaxMix(problem, additionalFactor):
    One, Two, Three = problem
    index = random.randint(1,2)
    output = [max(One[i], Two[i], Three[i]) for i in xrange(len(One))]
    output[0] = additionalFactor
    output[index] = min(One[index], Two[index], Three[index])
    return output

def generateTermDisplay(a, b, c):
    if b == 0:
        if c == 0:
            generalForm = "%s" %a
        elif c == 1:
            generalForm = "%s y" %a
        else:
            generalForm = "%s y^{%s}" %(a, c)
    elif b == 1:
        if c == 0:
            generalForm = "%s x" %a
        elif c == 1:
            generalForm = "%s xy" %a
        else:
            generalForm = "%s xy^{%s}" %(a, c)
    else:
        if c == 0:
            generalForm = "%s x^{%s}" %a
        elif c == 1:
            generalForm = "%s x^{%s}y" %(a, b)
        else:
            generalForm = "%s x^{%s} y^{%s}" %(a, b, c)
    return generalForm

def createThreeRelativelyPrime():
    a = random.randint(2, 9)
    b = random.randint(2, 9)
    c = random.randint(2, 9)
    while gcd(a, b) > 1 or gcd(b, c) > 1 or gcd(a, c) > 1:
        a = random.randint(2, 9)
        b = random.randint(2, 9)
        c = random.randint(2, 9)
    return [a, b, c]

intervalRange = 3
# Generates GCD of coefficients
additionalFactor = 4
GCDconstants = 4*random.randint(5, 15)

# Generates random values for terms
relativelyPrime = createThreeRelativelyPrime()
One = [maybeMakeNegative(GCDconstants * relativelyPrime[0]), random.randint(0, 4), random.randint(0, 4)]
Two = [maybeMakeNegative(GCDconstants * relativelyPrime[1]), random.randint(0, 4), random.randint(0, 4)]
Three = [maybeMakeNegative(GCDconstants * relativelyPrime[2]), random.randint(0, 4), random.randint(0, 4)]

problem = [One, Two, Three]
GCDxExponent = min(One[1], Two[1], Three[1])
GCDyExponent = min(One[2], Two[2], Three[2])

solution = [GCDconstants, GCDxExponent, GCDyExponent]

distractor1 = generateDistractorDivideByFour(solution, additionalFactor)
distractor2 = generateDistractorMaxFactors(problem)
distractor3 = generateDistractorMaxFactorsWithGCD(problem, GCDconstants)
distractor4 = generateDistractorMinMaxMix(problem, additionalFactor)

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

displayStem = 'Find the greatest common factor of the expression below. Then, choose the intervals that contain the coefficient and exponents in the form $ax^by^c$.'

# Generates the correct Problem Display
if Two[0] < 0:
    if Three[0] < 0:
        generalFormOne = generateTermDisplay(One[0], One[1], One[2])
        generalFormTwo = generateTermDisplay(-Two[0], Two[1], Two[2])
        generalFormThree = generateTermDisplay(-Three[0], Three[1], Three[2])
        displayProblem = "%s - %s - %s" %(generalFormOne, generalFormTwo, generalFormThree)
    else:
        generalFormOne = generateTermDisplay(One[0], One[1], One[2])
        generalFormTwo = generateTermDisplay(-Two[0], Two[1], Two[2])
        generalFormThree = generateTermDisplay(Three[0], Three[1], Three[2])
        displayProblem = "%s - %s + %s" %(generalFormOne, generalFormTwo, generalFormThree)
else:
    if Three[0] < 0:
        generalFormOne = generateTermDisplay(One[0], One[1], One[2])
        generalFormTwo = generateTermDisplay(Two[0], Two[1], Two[2])
        generalFormThree = generateTermDisplay(-Three[0], Three[1], Three[2])
        displayProblem = "%s + %s - %s" %(generalFormOne, generalFormTwo, generalFormThree)
    else:
        generalFormOne = generateTermDisplay(One[0], One[1], One[2])
        generalFormTwo = generateTermDisplay(Two[0], Two[1], Two[2])
        generalFormThree = generateTermDisplay(Three[0], Three[1], Three[2])
        displayProblem = "%s + %s + %s" %(generalFormOne, generalFormTwo, generalFormThree)

displaySolution = "%s x^{%s} y^{%s}" %(solution[0], solution[1], solution[2])
comments = "General Comments: If variables are missing, that means the greatest common factor has that variable to the 0 power."

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to not reducing the coefficients completely.")
distractor2Interval.append(" Corresponds to only taking the maximum of the x factors.")
distractor3Interval.append(" Corresponds to only taking the maximum of the y factors but with the GCD of the coefficients.")
distractor4Interval.append(" Corresponds to mixing the maxes and mins of the powers.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s], b \\in [%s, %s], \\text{ and } c \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1])
c1 = "a \\in [%s, %s], b \\in [%s, %s], \\text{ and } c \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1])
c2 = "a \\in [%s, %s], b \\in [%s, %s], \\text{ and } c \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1])
c3 = "a \\in [%s, %s], b \\in [%s, %s], \\text{ and } c \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1])
c4 = "a \\in [%s, %s], b \\in [%s, %s], \\text{ and } c \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][3], answerList[1][3], answerList[2][3], answerList[3][3], answerList[4][3]]

#createAnswerKeyFile(moduleNumber, version)
writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

# Ideas for Distractors
    # Smaller divisors. Maybe we force the GCD to be composite to give us some
        # distractor divisors?
    # max(One[1], Two[1], Three[1]) - I've seen students do this
    # max(One[2], Two[2], Three[2]) - I've seen students do this
    # That should be enough by doing combinations. Mix the correct GCD with maxes
