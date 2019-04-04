# Objective 3 - Factor a trinomial with leading coefficient greater than 1.
# Create 3 different types - print 1 of each type
from sympy.abc import x
import random

load("../Code/generalPurposeMethods.sage")

def generateSolution(minimum, maximum):
    listPrimes = prime_range(minimum, maximum)
    a, c = random.sample(listPrimes, 2)

    b = maybeMakeNegative(random.randint(minimum, maximum))
    d = maybeMakeNegative(random.randint(minimum, maximum))

    # This makes sure we can't factor out a constant.
    while (gcd(a, b)*gcd(c, d)>1):
        a, c = random.sample(listPrimes, 2)
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
    return [int(a*c), int(a*d + b*c), int(b*d)]
def distractorA1(solution):
    a, b, c, d = solution
    return[1, b, a*c, d]
def distractorC1(solution):
    a, b, c, d = solution
    return[1, d, a*c, b]
def distractorOppositeSignsPrimes(solution):
    a, b, c, d = solution
    return[-c, d, -a, b]
def distractorOppositeSigns(solution):
    a, b, c, d = solution
    return[-c, -d, -a, -b]
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

# Type 2 - a=p and c=q where p, q prime
minimum = 3
maximum = 10

solution = generateSolution(minimum, maximum)
distractor1 = distractorA1(solution)
distractor2 = distractorC1(solution)
distractor3 = distractorOppositeSignsPrimes(solution)
distractor4 = distractorOppositeSigns(solution)
solutionList = [solution, distractor1, distractor2, distractor3, distractor4]

while (solutionList[0]==solutionList[1] or solutionList[0]==solutionList[2] or solutionList[0]==solutionList[3] or solutionList[0]==solutionList[4] or solutionList[1]==solutionList[2] or solutionList[1]==solutionList[3] or solutionList[1]==solutionList[4] or solutionList[2]==solutionList[3] or solutionList[2]==solutionList[4] or solutionList[3]==solutionList[4]):
    solution = generateSolution(minimum, maximum)
    distractor1 = distractorA1(solution)
    distractor2 = distractorC1(solution)
    distractor3 = distractorOppositeSignsPrimes(solution)
    distractor4 = distractorOppositeSigns(solution)
    solutionList = [solution, distractor1, distractor2, distractor3, distractor4]

intervalRange = 5
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

first, second, third = generateProblem(solution)
generalFormTypeTwo = first * x**2 + second * x + third

displayStem = 'Factor the quadratic below. Then, choose the intervals that contain the constants in the form $(ax+b)(cx+d); b \\leq d.$'

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

comments = "General Comments: While you may be able to factor this by guess-and-check, you may want to practice Factoring by Grouping with problems like this."

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Distractor 1: This distractor corresponds to choosing the leading coefficients a=1, c=pq for the factors.")
distractor2Interval.append(" Distractor 2: This distractor corresponds to choosing the leading coefficients a=pq, c=1 for the factors.")
distractor3Interval.append(" Distractor 3: This distractor corresponds to choosing the opposite signs of the primes.")
distractor4Interval.append(" Distractor 4: This distractor corresponds to choosing the opposite signs for all coefficients.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1], answerList[0][3][0], answerList[0][3][1])
c1 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1], answerList[1][3][0], answerList[1][3][1])
c2 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1], answerList[2][3][0], answerList[2][3][1])
c3 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1], answerList[3][3][0], answerList[3][3][1])
c4 = "a \\in [%s, %s], b \\in [%s, %s], c \\in [%s, %s], \\text{ and } d \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1], answerList[4][3][0], answerList[4][3][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][4], answerList[1][4], answerList[2][4], answerList[3][4], answerList[4][4]]

print
print displayProblem
print displaySolution
print

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I've completed Objective 3 Type 2"
