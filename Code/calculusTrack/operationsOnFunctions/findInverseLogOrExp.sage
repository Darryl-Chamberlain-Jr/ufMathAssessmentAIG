from sympy import Symbol
import math
x = Symbol('x')
#load("../Code/generalPurposeMethods.sage")

# Objective 4 - Find the inverse of a function, if it exists.
    # Type 1 - Polynomial or Rational Functions
    # Type 2 - Log/Exp functions

# Question: Find the inverse of the function below. Then, evaluate the inverse at $x = a$ and choose the interval the $f^{-1}(a)$ belongs to.

print "Starting Module 10 Objective 4 Type 2"

intervalRange = 5
precision = 1

def defineFunctionAndInverse():
    classesOfFunctions = ["ln", "exp"]
    type = classesOfFunctions[random.randint(0, 1)]
    print type
    if (type == "ln"):
        h = maybeMakeNegative(random.randint(2, 5))
        k = maybeMakeNegative(random.randint(2, 5))
        while (h==k):
            h = maybeMakeNegative(random.randint(2, 5))
            k = maybeMakeNegative(random.randint(2, 5))

        if (h<0):
            if (k<0):
                lnFunc = "\\ln{(x+%d)}-%d" %(-h, -k)
            else:
                lnFunc = "\\ln{(x+%d)}+%d" %(-h, k)
        else:
            if (k<0):
                lnFunc = "\\ln{(x-%d)}-%d" %(h, -k)
            else:
                lnFunc = "\\ln{(x-%d)}+%d" %(h, k)

        lnInv = e**(x-k)+h
        return [lnFunc, lnInv, h, k, "ln"]
    else:
        h = maybeMakeNegative(random.randint(2, 5))
        k = maybeMakeNegative(random.randint(2, 5))
        while (h==k):
            h = maybeMakeNegative(random.randint(2, 5))
            k = maybeMakeNegative(random.randint(2, 5))

        if (h<0):
            if (k<0):
                expFunc = "e^{x+%d}-%d" %(-h, -k)
            else:
                expFunc = "e^{x+%d}+%d" %(-h, k)
        else:
            if (k<0):
                expFunc = "e^{x-%d}-%d" %(h, -k)
            else:
                expFunc = "e^{x-%d}+%d" %(h, k)

        expInv = ln(x-k)+h
        return [expFunc, expInv, h, k, "exp"]

def distractorsLn(h, k, evaluateAt):
    distractor1 = math.exp(evaluateAt+k)+h
    distractor2 = math.exp(evaluateAt+h)+k
    distractor3 = math.exp(evaluateAt-k)-h
    distractor4 = math.exp(evaluateAt-h)+k
    return [distractor1, distractor2, distractor3, distractor4]

def distractorsExp(h, k, evaulateAt):
    distractor1 = math.log(evaluateAt-k, math.exp(1))-h
    distractor2 = math.log(evaluateAt+k, math.exp(1))+k
    distractor3 = math.log(evaluateAt+h, math.exp(1))+k
    distractor4 = math.log(evaluateAt-h, math.exp(1))+k
    return [distractor1, distractor2, distractor3, distractor4]

functionAndInverse = defineFunctionAndInverse()
h = functionAndInverse[2]
k = functionAndInverse[3]
evaluateAt = max(abs(h), abs(k)) + random.randint(2, 5)
intervalRange = 5
precision = 1

function = functionAndInverse[1]

if (functionAndInverse[4]=="ln"):
    solution = math.exp(evaluateAt-k)+h
    distractors = distractorsLn(functionAndInverse[2], functionAndInverse[3], evaluateAt)
else:
    solution = math.log(evaluateAt-k, math.exp(1))+h
    distractors = distractorsExp(functionAndInverse[2], functionAndInverse[3], evaluateAt)

solutionList = [solution, distractors[0], distractors[1], distractors[2], distractors[3]]
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = [intervalOptions[0]]
distractor1Interval = [intervalOptions[1]]
distractor2Interval = [intervalOptions[2]]
distractor3Interval = [intervalOptions[3]]
distractor4Interval = [intervalOptions[4]]

solutionInterval.append(" This is the solution.")
distractor1Interval.append(" This solution corresponds to distractor 1.")
distractor2Interval.append(" This solution corresponds to distractor 2.")
distractor3Interval.append(" This solution corresponds to distractor 3.")
distractor4Interval.append(" This solution corresponds to distractor 4.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

#print "/n Answer List, check each one \n %s \n %s \n %s \n %s \n %s \n" %(answerList[0], answerList[1], answerList[2], answerList[3], answerList[4])

displayStem = "Find the inverse of the function below. Then, evaluate the inverse at $x = %d$ and choose the interval that $f^{-1}(%d)$ belongs to." %(evaluateAt, evaluateAt)
displayProblem = functionAndInverse[0]
displaySolution = "f^{-1}(%d) = %s" %(evaluateAt, round(solution, 3))
generalComments = "Natural log and exponential functions always have an inverse. Once you switch the $x$ and $y$, use the conversion $ e^y = x \\leftrightarrow y=\\ln(x)$."

c0 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[0][0][0], answerList[0][0][1])
c1 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[1][0][0], answerList[1][0][1])
c2 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[2][0][0], answerList[2][0][1])
c3 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[3][0][0], answerList[3][0][1])
c4 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[4][0][0], answerList[4][0][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 10 Objective 4 Type 2, Master"
