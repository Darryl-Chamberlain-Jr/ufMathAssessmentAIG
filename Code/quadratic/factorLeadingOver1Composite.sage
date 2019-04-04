# Objective 3 - Factor a trinomial with leading coefficient greater than 1.
# Create 3 different types - print 1 of each type
from sympy.abc import x
import random

#load("../Code/generalPurposeMethods.sage")
load("../generalPurposeMethods.sage")

def generateFactors(minimumPrime, maximumPrime, numberOfFactors):
    listPrimes = prime_range(minimum, maximum)
    aFactors = [random.sample(listPrimes, 1) for i in xrange(numberOfFactors)]
    cFactors = [random.sample(listPrimes, 1) for i in xrange(numberOfFactors)]
    return [aFactors, cFactors]

def generateSolution(minimum, maximum, factors):
    aFactors = factors[0]
    cFactors = factors[1]
    a = numpy.prod(aFactors)
    c = numpy.prod(cFactors)
    b = maybeMakeNegative(random.randint(minimum, maximum))
    d = maybeMakeNegative(random.randint(minimum, maximum))

    # This makes sure we can't factor out a constant.
    while ((gcd(a, b)*gcd(c, d)>1) or (a==c and b==-d)):
        aFactors = factors[0]
        cFactors = factors[1]
        a = numpy.prod(aFactors)
        c = numpy.prod(cFactors)
        b = maybeMakeNegative(random.randint(minimum, maximum))
        d = maybeMakeNegative(random.randint(minimum, maximum))

    #This will guarantee that we always generate solutions with b <= d
    if(b <= d):
        return [a, b, c, d]
    else:
        return[c, d, a, b]
def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
def generateProblem(solution):
    a, b, c, d = solution
    return [a*c, a*d + b*c, b*d]
def distractorA1(solution):
    a, b, c, d = solution
    return[1, b, a*c, d]
def distractorC1(solution):
    a, b, c, d = solution
    return[1, -b, a*c, -d]
def distractorLumpedCFactors(solution, factors):
    aFactors = factors[0]
    cFactors = factors[1]
    a, b, c, d = solution
    index = random.randint(0,len(aFactors)-1)

    a = a/(aFactors[index][0])
    c = c*aFactors[index][0]
    if(b <= d):
        return [a, b, c, d]
    else:
        return[c, d, a, b]
def distractorLumpedAFactors(solution, factors):
    aFactors = factors[0]
    cFactors = factors[1]
    a, b, c, d = solution
    index = random.randint(0,len(aFactors)-1)
    c = c/(cFactors[index][0])
    a = a*cFactors[index][0]
    if(b <= d):
        return [a, b, c, d]
    else:
        return[c, d, a, b]
def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

def displayFactor(a, b):
    if b < 0:
        display = "%s x - %s" %(a, -b)
    else:
        display = "%s x + %s" %(a, b)
    return display

# Type 3 - a and c are fairly composite (ac has at least 6 factors)
intervalRange = 1
minimum = 2
maximum = 5
numberOfFactors = 3

factors = generateFactors(minimum, maximum, numberOfFactors)
solution = generateSolution(minimum, maximum, factors)
distractor1 = distractorA1(solution)
distractor2 = distractorC1(solution)
distractor3 = distractorLumpedCFactors(solution, factors)
distractor4 = distractorLumpedAFactors(solution, factors)
solutionList = [solution, distractor1, distractor2, distractor3, distractor4]

while (solutionList[0]==solutionList[1] or solutionList[0]==solutionList[2] or solutionList[0]==solutionList[3] or solutionList[0]==solutionList[4] or solutionList[1]==solutionList[2] or solutionList[1]==solutionList[3] or solutionList[1]==solutionList[4] or solutionList[2]==solutionList[3] or solutionList[2]==solutionList[4] or solutionList[3]==solutionList[4]):
    factors = generateFactors(minimum, maximum, numberOfFactors)
    solution = generateSolution(minimum, maximum, factors)
    distractor1 = distractorA1(solution)
    distractor2 = distractorC1(solution)
    distractor3 = distractorLumpedCFactors(solution, factors)
    distractor4 = distractorLumpedAFactors(solution, factors)
    solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
    print solutionList

precision = 0.5
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

problem = generateProblem(solution)
generalFormTypeThree = problem[0] * x**2 + problem[1] * x + problem[2]

displayStem = 'Factor the quadratic below. Then, choose the intervals that contain the constants in the form $(ax+b)(cx+d); b \\leq d.$'

first, second, third = problem
if second < 0 and third < 0:
    displayProblem = "%s x^2 - %s x - %s" %(first, -second, -third)
elif second < 0 and third > 0:
    displayProblem = "%s x^2 - %s x + %s" %(first, -second, third)
elif second > 0 and third < 0:
    displayProblem = "%s x^2 + %s x - %s" %(first, second, -third)
else:
    displayProblem = "%s x^2 + %s x + %s" %(first, second, third)

solutionFactor0 = displayFactor(solution[0], solution[1])
solutionFactor1 = displayFactor(solution[2], solution[3])
displaySolution = '(%s)(%s)' %(solutionFactor0, solutionFactor1)

comment = "General Comments: $ac$ had many factors in this problem. It is best to list out the possible pairs in order to make sure you don't miss any."

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to choosing a=1.")
distractor2Interval.append(" Corresponds to choosing c=1.")
distractor3Interval.append(" Corresponds to associating some factor of c to a.")
distractor4Interval.append(" Corresponds to associating some factor of a to c.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\hspace*{5mm} c \\in [%s, %s], \\text{ and } \\hspace*{5mm} d \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\hspace*{5mm} c \\in [%s, %s], \\text{ and } \\hspace*{5mm} d \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\hspace*{5mm} c \\in [%s, %s], \\text{ and } \\hspace*{5mm} d \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\hspace*{5mm} c \\in [%s, %s], \\text{ and } \\hspace*{5mm} d \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\hspace*{5mm} c \\in [%s, %s], \\text{ and } \\hspace*{5mm} d \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

print "Question: %s" %displayProblem
print "Solution: %s" %displaySolution

#writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
#writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
#writeCommentsToFile(moduleNumber, version, comments)
