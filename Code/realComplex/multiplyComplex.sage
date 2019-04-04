import random
from sympy import Symbol

#load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
print "I have started objective 4 type 1"
def generateProblem():
    listIntegers = range(2, 11)
    constants = random.sample(listIntegers, 4)
    constants = [float(maybeMakeNegative(i)) for i in constants]
    return constants

def generateSolution(complex1, complex2):
    product = complex1*complex2
    return [float(product.real), float(product.imag)]

def distractorMinusFirst(problem):
    a1, b1, a2, b2 = problem
    complex1 = complex(a1, -b1)
    complex2 = complex(a2, b2)
    product = complex1*complex2
    return [float(product.real), float(product.imag)]

def distractorSecondMinus(problem):
    a1, b1, a2, b2 = problem
    complex1 = complex(a1, b1)
    complex2 = complex(a2, -b2)
    product = complex1*complex2
    return [float(product.real), float(product.imag)]

def distractorBothMinus(problem):
    a1, b1, a2, b2 = problem
    complex1 = complex(a1, -b1)
    complex2 = complex(a2, -b2)
    product = complex1*complex2
    return [float(product.real), float(product.imag)]

def distractorWhatEvenAreYouDoing(problem):
    a1, b1, a2, b2 = problem
    crazySolution = complex(a1*a2, b1*b2)
    return [float(crazySolution.real), float(crazySolution.imag)]

# OBJECTIVE 4 - Add/Subtract/Multiply/Divide Complex numbers.
# Two complex numbers will be generated, which we can ask students to multiply or divide.
intervalRange = 5
precision = 1
problem = generateProblem()
a1, b1, a2, b2 = problem

#This is just to check if the two complex numbers are equal. SageTeX doesn't
    # want to show it in this way.
complex1 = complex(a1, b1)
complex2 = complex(a2, b2)

while complex1 == complex2 or (a1*b2 + b1*a2) == 0:
    problem = generateProblem()
    a1, b1, a2, b2 = problem
    complex1 = complex(a1, b1)
    complex2 = complex(a2, b2)

solution = generateSolution(complex1, complex2)

distractor1 = distractorMinusFirst(problem)
distractor2 = distractorSecondMinus(problem)
distractor3 = distractorBothMinus(problem)
distractor4 = distractorWhatEvenAreYouDoing(problem)

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]

intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to adding a minus sign in the first term.")
distractor2Interval.append(" Corresponds to adding a minus sign in the second term.")
distractor3Interval.append(" Corresponds to adding a minus sign in both terms.")
distractor4Interval.append(" Corresponds to just multiplying the real terms to get the real part of the solution and the coefficients in the complex terms to get the complex part.")

i = Symbol('i')
complexDisplayOne = a1 + b1*i
complexDisplayTwo = a2+ b2*i

displayStem = 'Simplify the expression below into the form $a+bi$. Then, choose the intervals that $a$ and $b$ belong to.'
# This makes sure the problem displays correctly in LaTeX.
if (b1<0):
    if (b2<0):
        displayProblem = '(%d - %d i)(%d - %d i)' %(a1, -b1, a2, -b2)
    else:
        displayProblem = '(%d - %d i)(%d + %d i)' %(a1, -b1, a2, b2)
else:
    if (b2<0):
        displayProblem = '(%d + %d i)(%d - %d i)' %(a1, b1, a2, -b2)
    else:
        displayProblem = '(%d + %d i)(%d + %d i)' %(a1, b1, a2, b2)

if solution[1] < 0:
    displaySolution = "%s - %s i" %(solution[0], -solution[1])
else:
    displaySolution = "%s + %s i" %(solution[0], solution[1])

comments = "General Comments: You can treat $i$ as a variable and distribute. Just remember that $i^2=-1$, so you can continue to reduce after you distribute."

print displayProblem
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
