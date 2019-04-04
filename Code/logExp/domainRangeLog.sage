from random import shuffle
from sympy import solve
from sympy.abc import x
import random

# OBJECTIVE 1 - Describe the domain/range of Logarithmic and Exponential functions.

load("../Code/generalPurposeMethods.sage")

def chooseDomainOrRange():
    #shuffle wasn't working...
    listChoices = ["Domain", "Range"]
    random.shuffle(listChoices)
    return listChoices[0]

def chooseSignOfLeadingCoefficient():
    sign = (-1)**random.randint(0, 1)
    return sign

def generateShifting():
    h = 0
    k = 0
    while (h==0 or k==0 or h==k):
        h = random.randint(-9, 9)
        k = random.randint(-9, 9)
    return [h, k]

def generateSolutionInterval(solution, intervalRange):
    interval = createInterval(solution, intervalRange)
    return interval

def distractorInverseDomain(intervalPresentation):
    a, b = intervalPresentation
    return [b, a]

def distractorNegateDomain(intervalPresentation):
    a, b = intervalPresentation
    return [-a, -b]

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

# Type 1 - Logarithmic

# a * log_2 (x-h) + k
    # a Positive
        # Domain: (h, infty)
        # Range: (-infty, infty)
    # a Negative
        # Domain: (h, infty)
        # Range: (-infty, infty)
intervalRange = 5
domainOrRange = chooseDomainOrRange()
#domainOrRange = "Domain"
a = chooseSignOfLeadingCoefficient()
shift = generateShifting()
h = shift[0]
k = shift[1]

#print "Error checking: \n %s \n a = %s \n Shift: %s" %(domainOrRange, a, shift)

if (domainOrRange == "Domain"):
    intervalPresentation = [h, 0]
    solution = h
    distractor1 = k
    distractor2 = -h
    distractor3 = -k

    displaySolution = "(%d, \\infty)" %h
    solutionList = [solution, distractor1, distractor2, distractor3]
    precision = 1
    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

    solutionInterval = [intervalWithInfinityToStringExclusive(intervalPresentation), intervalOptions[0]]
    distractor1Interval = [intervalWithInfinityToStringInclusive(distractorInverseDomain(intervalPresentation)), intervalOptions[1]]
    distractor2Interval = [intervalWithInfinityToStringExclusive(distractorInverseDomain(intervalPresentation)), intervalOptions[2]]
    distractor3Interval = [intervalWithInfinityToStringInclusive(intervalPresentation), intervalOptions[3]]

    solutionInterval.append("* This is the solution.")
    distractor1Interval.append(" Distractor 1: This corresponds to using the vertical shift when shifting the Domain AND including the endpoint.")
    distractor2Interval.append(" Distractor 2: This corresponds to using negative of the horizontal shift. Remember: the general for is a*log(x-h)+k.")
    distractor3Interval.append(" Distractor 3: This corresponds to using the negative vertical shift AND including the endpoint.")

    answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
    random.shuffle(answerList)
    answerList.append(['(-\\infty, \\infty)', "Distractor 4: This corresponds to thinking of the Range of the log function (or the domain of the exponential function)."])
else:
    displaySolution = "(\\infty, \\infty)"
    #solutionInterval = ['(-\infty, \infty)', [' ', ' ']]
    intervalPresentation = [0, k]
    distractor1 = h
    distractor2 = -k
    distractor3 = k
    distractor4 = -h

    solutionList = [distractor1, distractor2, distractor3, distractor4]

    precision = 1
    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)
    distractor1Interval = [intervalWithInfinityToStringInclusive(distractorInverseDomain(intervalPresentation)), intervalOptions[0]]
    distractor2Interval = [intervalWithInfinityToStringExclusive(distractorNegateDomain(intervalPresentation)), intervalOptions[1]]
    distractor3Interval = [intervalWithInfinityToStringExclusive(intervalPresentation), intervalOptions[2]]
    distractor4Interval = [intervalWithInfinityToStringInclusive(intervalPresentation), intervalOptions[3]]

    distractor1Interval.append("* Distractor 1: This corresponds to using the flipped Domain AND including the endpoint.")
    distractor2Interval.append("* Distractor 2: This corresponds to using the using the negative of vertical shift on (0, infinity).")
    distractor3Interval.append("* Distractor 3: This corresponds to using the using the vertical shift while the Range is (-infinity, infinity).")
    distractor4Interval.append("* Distractor 4: This corresponds to using the negative of the horizontal shift AND including the endpoint.")

    answerList = [distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
    random.shuffle(answerList)
    answerList.append(['(-\\infty, \\infty)', ' * This is the correct solution.'])

displayStem = 'Which of the following intervals describes the %s of the function below?' %domainOrRange
# Makes the function display correctly.
if (a<0):
    if (h<0):
        if(k<0):
            displayProblem = 'f(x) = -\\log_2{(x+%d)}-%d' %(-h, -k)
        else:
            displayProblem = 'f(x) = -\\log_2{(x+%d)}+%d' %(-h, k)
    else:
        if(k<0):
            displayProblem = 'f(x) = -\\log_2{(x-%d)}-%d' %(h, -k)
        else:
            displayProblem = 'f(x) = -\\log_2{(x-%d)}+%d' %(h, k)
else:
    if (h<0):
        if(k<0):
            displayProblem = 'f(x) = \\log_2{(x+%d)}-%d' %(-h, -k)
        else:
            displayProblem = 'f(x) = \\log_2{(x+%d)}+%d' %(-h, k)
    else:
        if(k<0):
            displayProblem = 'f(x) = \\log_2{(x-%d)}-%d' %(h, -k)
        else:
            displayProblem = 'f(x) = \\log_2{(x-%d)}+%d' %(h, k)

generalComments = "General Comments: The domain of a basic logarithmic function is $(0, \\infty)$ and the Range is $(-\\infty, \\infty)$. We can use shifts when finding the Domain, but the Range will always be all Real numbers."

c0 = "%s, a \\in [%s, %s]" %(answerList[0][0], answerList[0][1][0], answerList[0][1][1])
c1 = "%s, a \\in [%s, %s]" %(answerList[1][0], answerList[1][1][0], answerList[1][1][1])
c2 = "%s, a \\in [%s, %s]" %(answerList[2][0], answerList[2][1][0], answerList[2][1][1])
c3 = "%s, a \\in [%s, %s]" %(answerList[3][0], answerList[3][1][0], answerList[3][1][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I finished Module 8, Objective 1, Type 1, Master"
