import random
import numpy
import math
from sympy.solvers import solve
from sympy.abc import x
from sympy import Symbol

x = Symbol('x')
#load("../Code/generalPurposeMethods.sage")

# Objective 2 - Evaluate the composition of two functions.
print "I have started Objective 2"
#x = sympy.Symbol('x')
intervalRange = 5
precision = 1

def generateFunction(functionClass):
    #functionClass = {"Polynomial", "Radical", "Rational"}
    degree = int(random.randint(2, 3))
    print "Degree: %d" %degree
    counter = degree
    functionCoefficients = [0, 0, 0, 0]
    while (counter>=0):
        index = degree - counter
        print "Index: %s" %index
        functionCoefficients[index] = int(maybeMakeNegative(random.randint(1, 4)))
        print functionCoefficients
        counter = counter - 1
        print "Counter: %d" %counter
    return functionCoefficients

def evaluateValue(functionCoefficients, evaluateAt):
    print "These are the coefficients: %s" %functionCoefficients
    print "This is the value being evaluated: %s" %evaluateAt
    degree = len(functionCoefficients)
    #print "Degree: %d" %degree
    countdown = degree
    value = float(0)
    while (countdown>=1):
        index = degree - countdown
        print "Index: %d" %index
        value = float(value + functionCoefficients[index]*(evaluateAt)**(countdown-1))
        print "Value: %f" %value
        countdown = countdown - 1
        print "Countdown: %d" %countdown
    return float(value)

# In the future, we can make this more nuanced and pull from different classes of functions.
#functionClasses = generateFunctionClasses()

function1 = generateFunction("Polynomial")
print "Function 1: %s" %function1

function2 = generateFunction("Polynomial")
print "Function 2: %s" %function2

evaluateAt = maybeMakeNegative(random.randint(1, 2))
print "Evaluate At: %d" %evaluateAt

intermediate = evaluateValue(function2, evaluateAt)
output = evaluateValue(function1, intermediate)
solution = output

print "Start: %s, intermediate: %s, output: %s" %(evaluateAt, intermediate, output)
# Student reversed the composition
distractor1 = evaluateValue(function2, evaluateValue(function1, evaluateAt))

while (abs(solution) > 100 or abs(distractor1) > 100):
    function1 = generateFunction("Polynomial")
    function2 = generateFunction("Polynomial")
    evaluateAt = maybeMakeNegative(random.randint(1, 2))
    intermediate = evaluateValue(function2, evaluateAt)
    output = evaluateValue(function1, intermediate)
    solution = output
    print "Start: %s, intermediate: %s, output: %s" %(evaluateAt, intermediate, output)
    distractor1 = evaluateValue(function2, evaluateValue(function1, evaluateAt))

# Shift from correct solution (needs to be revised)
distractor2 = solution + maybeMakeNegative(random.randint(5, 10))

# Shift from distractor solution (needs to be revised)
distractor3 = distractor1 + maybeMakeNegative(random.randint(5, 10))

solutionList = [solution, distractor1, distractor2, distractor3]
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = [intervalOptions[0]]
distractor1Interval = [intervalOptions[1]]
distractor2Interval = [intervalOptions[2]]
distractor3Interval = [intervalOptions[3]]

solutionInterval.append("* This is the correct solution")
distractor1Interval.append(" Distractor 1: Corresponds to reversing the composition.")
distractor2Interval.append(" Distractor 2: Corresponds to being slightly off from the solution.")
distractor3Interval.append(" Distractor 3: Corresponds to being slightly off from the solution.")

a1, a2, a3, a4 = function1
b1, b2, b3, b4 = function2
displayFunction1 = a1*x**3+a2*x**2+a3*x+a4
displayFunction2 = b1*x**3+b2*x**2+b3*x+b4

displayStem = "Choose the interval below that $f$ composed with $g$ at $x=%d$ is in." %evaluateAt
displayProblem = "f(x) = %s \\text{ and } g(x) = %s" %(displayFunction1, displayFunction2)
displaySolution = solution
generalComments = "General Comments: $f$ composed with $g$ at $x$ means $f(g(x))$. The order matters!"

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)

c0 = "(f \\circ g)(%d) \\in [%s, %s]" %(evaluateAt, answerList[0][0][0], answerList[0][0][1])
c1 = "(f \\circ g)(%d) \\in [%s, %s]" %(evaluateAt, answerList[1][0][0], answerList[1][0][1])
c2 = "(f \\circ g)(%d) \\in [%s, %s]" %(evaluateAt, answerList[2][0][0], answerList[2][0][1])
c3 = "(f \\circ g)(%d) \\in [%s, %s]" %(evaluateAt, answerList[3][0][0], answerList[3][0][1])
c4 = "\\text{It is not possible to compose the two functions.}"
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], ""]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Objective 2, Master"
