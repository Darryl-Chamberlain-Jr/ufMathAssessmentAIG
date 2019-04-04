from sympy import Symbol
x = Symbol('x')
#load("../Code/generalPurposeMethods.sage")

# Objective 4 - Find the inverse of a function, if it exists.
    # Type 1 - Polynomial (degree 2 or 3 with a shift) or Radical Functions
    # Type 2 - Log/Exp functions

# Question: Find the inverse of the function below (if it exists).
    # Then, evaluate the inverse at $x = a$ and choose the interval the $f^{-1}(a)$ belongs to.

print "Starting Module 10 Objective 4 Type 1"

intervalRange = 5
precision = 1

def defineFunctionAndMaybeInverse():
    classesOfFunctions = ["degree2Poly", "radical", "degree3Poly"]
    # degree3Poly broken right now. Getting ValueError: non-integer stop for randrange()
    type = classesOfFunctions[random.randint(0, 1)]
    a = random.randint(2, 5)
    b = maybeMakeNegative(random.randint(2, 5))
    while (abs(a)==abs(b)):
        a = random.randint(2, 5)
        b = maybeMakeNegative(random.randint(2, 5))

    if (type=="degree2Poly"):
        function = a*x**2 + b
        return [function, "no", a, b]

    elif (type=="degree3Poly"):
        function = a*x**3 + b
        inverseFunction = ((x-b)/a)**(1/3)
        return [function, "yes", inverseFunction, a, b, "poly"]

    elif (type == "radical"):
        function = (a*x + b)**(1/3)
        inverseFunction = (x**3-b)/a
        return [function, "yes", inverseFunction, a, b, "radical"]

    else:
        return "You done fucked up this time."

# Generates distractors together
def distractorsDegree2Poly(a, b, evaluateAt):
    # Not invertible
    distractor1 = float( abs ( ( (evaluateAt-b)/a)**(1/2) ) )
    distractor2 = float( abs( ((evaluateAt+b)/a)**(1/2) ) )
    distractor3 = distractor1 + random.randint(1, 3)
    while (distractor3 == distractor1 or distractor3 == distractor2):
        distractor3 = distractor1 + random.randint(1, 3)
    distractor4 = distractor3 + random.randint(1, 3)
    while (distractor4 == distractor1 or distractor4 == distractor2 or distractor4 == distractor3):
        distractor4 = distractor3 + random.randint(1, 3)

    return [distractor1, distractor2, distractor3, distractor4]

def distractorsDegree3Poly(a, b, evaluateAt):
    # solution = ((x-b)/a)**(1/3)
    v1 = float( (evaluateAt+b)/a )
    if ( v1 < 0):
        distractor1 = -(-v1)**(1/3)
    else:
        distractor1 = (v1)**(1/3)

    v2 = float((evaluateAt-b)/(a))
    if (v2 < 0):
        distractor2 = -(-v2)**(1/3)
    else:
        distractor2 = (v2)**(1/3)

    v3 = float((evaluateAt+b)/(-a))
    if (v3<0):
        distractor3 = -(-v3)**(1/3)
    else:
        distractor3 = (v3)**(1/3)
    print distractor1, distractor2, distractor3
    return [distractor1, distractor2, distractor3]

def distractorsRadical(a, b, evaluateAt):
    # solution = (x**3-b)/a
    distractor1 = float((evaluateAt**3 +b)/a)
    distractor2 = float( (evaluateAt**3 -b)/(-a) )
    distractor3 = float( (evaluateAt**3 +b)/(-a) )
    return [distractor1, distractor2, distractor3]

functionAndMaybeInverse = defineFunctionAndMaybeInverse()
evaluateAt = float(maybeMakeNegative(random.randint(10, 15)))
intervalRange = 5
precision = 1

print functionAndMaybeInverse[0], functionAndMaybeInverse[1]

if (functionAndMaybeInverse[1]=="no"):
    a = float(functionAndMaybeInverse[2])
    b = float(functionAndMaybeInverse[3])

    solution = ["\\text{ The function is not invertible for all Real numbers. }", "* This is the correct option."]
    distractors = distractorsDegree2Poly(a, b, evaluateAt)
    solutionList = distractors

    print solutionList

    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)
    print intervalOptions

    distractor1Interval = [intervalOptions[0]]
    distractor2Interval = [intervalOptions[1]]
    distractor3Interval = [intervalOptions[2]]
    distractor4Interval = [intervalOptions[3]]

    distractor1Interval.append(" Distractor 1: This corresponds to trying to find the inverse even though the function is not 1-1. ")
    distractor2Interval.append(" Distractor 2: This corresponds to finding the (nonexistent) inverse and not subtracting by the vertical shift.")
    distractor3Interval.append(" Distractor 3: This corresponds to finding the (nonexistent) inverse and dividing by a negative.")
    distractor4Interval.append(" Distractor 4: This corresponds to both distractors 2 and 3.")

    answerList = [distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]

    displayStem = "Find the inverse of the function below (if it exists). Then, evaluate the inverse at $x = %d$ and choose the interval that $f^{-1}(%d)$ belongs to." %(evaluateAt, evaluateAt)
    displayProblem = functionAndMaybeInverse[0]
    displaySolution = solution[0]

    random.shuffle(answerList)
    answerList.append(solution)

else:
    a = float(functionAndMaybeInverse[3])
    b = float(functionAndMaybeInverse[4])

    if (functionAndMaybeInverse[5]=="poly"):
        value = float( (evaluateAt-b)/a )
        if (value<0):
            solution = float( -(-value)**(1/3) )
        else:
            solution = float( (value)**(1/3) )
        distractors = distractorsDegree3Poly(a, b, evaluateAt)

    else:
        solution = float( (evaluateAt**3-b) /a )
        distractors = distractorsRadical(a, b, evaluateAt)

    solutionList = [solution, distractors[0], distractors[1], distractors[2]]
    print solutionList
    intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)
    print intervalOptions

    solutionInterval = [intervalOptions[0]]
    distractor1Interval = [intervalOptions[1]]
    distractor2Interval = [intervalOptions[2]]
    distractor3Interval = [intervalOptions[3]]
    distractor4Interval = ["\\text{ The function is not invertible for all Real numbers. }"]

    solutionInterval.append("* This is the correct solution.")
    distractor1Interval.append(" Distractor 1: This corresponds to ")
    distractor2Interval.append(" This solution corresponds to distractor 2.")
    distractor3Interval.append(" This solution corresponds to distractor 3.")
    distractor4Interval.append(" This solution corresponds to distractor 4.")

    answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
    print "Here?"
    displayStem = "Find the inverse of the function below (if it exists). Then, evaluate the inverse at $x = %d$ and choose the interval the $f^{-1}(%d)$ belongs to." %(evaluateAt, evaluateAt)
    displayProblem = functionAndMaybeInverse[0]
    displaySolution = solution

    random.shuffle(answerList)
    answerList.append(distractor4Interval)

print solutionList
generalComments = "General Comments: Be sure you check that the function is 1-1 before trying to find the inverse!"
#print "/n Answer List, check each one \n %s \n %s \n %s \n %s \n %s \n" %(answerList[0], answerList[1], answerList[2], answerList[3], answerList[4])

c0 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[0][0][0], answerList[0][0][1])
c1 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[1][0][0], answerList[1][0][1])
c2 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[2][0][0], answerList[2][0][1])
c3 = "f^{-1}(%d) \\in [%s, %s]" %(evaluateAt, answerList[3][0][0], answerList[3][0][1])
c4 = answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 10 Objective 4 Type 1, Master"
