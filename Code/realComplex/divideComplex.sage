import random
from sympy import Symbol

import random
from sympy import Symbol
print "I have started Objective 4 Type 1"
def generateProblem():
    listIntegers = [i for i in xrange(1, 7)]
    constants = random.sample(listIntegers, 4)
    constants = [maybeMakeNegative(i) for i in constants]
    return constants
def generateSolution(complex1, complex2):
    quotient = complex1/complex2
    return [quotient.real, quotient.imag]
def generateSolutionIntervals(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

def generateDistractors(problem):
    a1, b1, a2, b2 = problem

    #Divide like terms
    distractor1 = [float(a1/a2), float(b1/b2)]
    print "This should be first term divided by first term and second term divided by second term. "

    # Multiply by non-conjugate and treat like conjugate in denominator
    numeratorD2 = complex(a1, b1) * complex(a2, b2)
    denominatorD2 = complex(a2, b2) * complex(a2, -b2)
    quotientD2 = numeratorD2/denominatorD2.real
    distractor2 = [quotientD2.real, quotientD2.imag]

    # Multiply by conjugate, only divide first term
    numeratorD3 = complex(a1, b1) * complex(a2, -b2)
    denominatorD3 = complex(a2, b2) * complex(a2, -b2)
    realTermD3 = float(numeratorD3.real / denominatorD3.real)
    imagTermD3 = float(numeratorD3.imag)
    distractor3 = [realTermD3, imagTermD3]

    # Multiply by conjugate, only divide second term
    numeratorD4 = complex(a1, b1) * complex(a2, -b2)
    denominatorD4 = complex(a2, b2) * complex(a2, -b2)
    realTermD4 = float(numeratorD4.real)
    imagTermD4 = float(numeratorD4.imag / denominatorD4.real)
    distractor4 = [realTermD4, imagTermD4]

    return [distractor1, distractor2, distractor3, distractor4]


#load("../Code/generalPurposeMethods.sage")
intervalRange = 5
precision = 1
# OBJECTIVE 4 - Add/Subtract/Multiply/Divide Complex numbers.
# Two complex numbers will be generated, which we can ask students to multiply or divide.

problem = generateProblem()
a1, b1, a2, b2 = problem
a1 = 9 * a1
b1 = 11 * b1

#This is just to check if the two complex numbers are equal. SageTeX doesn't
    # want to show it in this way.
complex1 = CC(a1, b1)
complex2 = CC(a2, b2)

while complex1 == complex2:
    problem = generateProblem()
    a1, b1, a2, b2 = problem
    a1 = 9 * a1
    b1 = 11 * b1
    complex1 = CC(a1, b1)
    complex2 = CC(a2, b2)

solution = generateSolution(complex1, complex2)
coefficients = [a1, b1, a2, b2]

distractors = generateDistractors(coefficients)

solutionList = [solution, distractors[0], distractors[1], distractors[2], distractors[3]]

intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to just dividing the first term by the first term and the second by the second.")
distractor2Interval.append(" Forgot to multiply the conjugate by the numerator and didn't compute the conjugate correctly")
distractor3Interval.append(" Forgot to multiply the conjugate by the numerator.")
distractor4Interval.append(" Forgot to multiply the conjugate by the numerator and added a plus instead of a minus in the denominator.")
i = Symbol('i')
complexDisplay1 = a1 + b1*i
complexDisplay2 = a2 + b2*i

displayStem = 'Simplify the expression below into the form $a+bi$. Then, choose the intervals that $a$ and $b$ belong to.'
# This makes sure the problem displays correctly in LaTeX.
if (b1<0):
    if (b2<0):
        displayProblem = '\\frac{%d-%di}{%d-%di}' %(a1, -b1, a2, -b2)
    else:
        displayProblem = '\\frac{%d-%di}{%d+%di}' %(a1, -b1, a2, b2)
else:
    if (b2<0):
        displayProblem = '\\frac{%d+%di}{%d-%di}' %(a1, b1, a2, -b2)
    else:
        displayProblem = '\\frac{%d+%di}{%d+%di}' %(a1, b1, a2, b2)

if solution[1] < 0:
    displaySolution = "%s - %s i" %(round(solution[0], 2), -round(solution[1], 2))
else:
    displaySolution = "%s + %s i" %(round(solution[0], 2), round(solution[1], 2))

comments = "General Comment: Multiply the numerator and denominator by the *conjugate* of the denominator, then simplify. For example, if we have $2+3i$, the conjugate is $2-3i$."

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1])
c1 = "a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1])
c2 = "a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1])
c3 = "a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1])
c4 = "a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][2]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
