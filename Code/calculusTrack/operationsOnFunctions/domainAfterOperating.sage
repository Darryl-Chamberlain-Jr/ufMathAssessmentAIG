import random
import numpy
import math
from sympy.solvers import solve
from sympy.abc import x
from sympy import Symbol

#load("../Code/generalPurposeMethods.sage")
print "Starting Module 10 Objective 1"
#load("generalPurposeMethods.sage")

# OBJECTIVE 1 - Identify the domain after operating (+/-/x/div) on two functions.

#x = Symbol('x')
intervalRange = 5
precision = 1

def generateFunctionClasses(operation):
    functionClass = ["Polynomial", "Radical", "Rational"]
    random.shuffle(functionClass)

    function1Class = functionClass[int(random.randint(0, 2))]
    function2Class = functionClass[int(random.randint(0, 2))]

    if (operation == "Multiply"):
        # Removes Poly x Rational or Rational x Poly
        while ((function1Class=="Polynomial" and function2Class == "Rational") or (function1Class=="Rational" and function2Class == "Polynomial")):
            function1Class = functionClass[int(random.randint(0, 2))]
            function2Class = functionClass[int(random.randint(0, 2))]
    #For the future
    elif (operation == "Divide"):
        # Removes Rational equations from function options
        function1Class = functionClass[int(random.randint(0, 1))]
        function2Class = functionClass[int(random.randint(0, 1))]
    else:
        function1Class = functionClass[int(random.randint(0, 2))]
        function2Class = functionClass[int(random.randint(0, 2))]

    return [function1Class, function2Class]

def generateFunctionAndDomain(functionClass):
    #functionClass = {"Polynomial", "Radical", "Rational"}
    if (functionClass=="Polynomial"):
        degree = random.randint(1, 4)
        function = 0
        while (degree>=0):
            function = function + random.randint(1, 7)*x**degree
            degree = degree - 1
        return [function, "RR"]

    elif (functionClass == "Rational"):
        numerator = random.randint(1, 5)
        a = random.randint(3, 6)
        b = maybeMakeNegative(a*random.randint(3, 6) + random.randint(1, 6))
        while (not(gcd(a, b)==1)):
            a = random.randint(3, 6)
            b = maybeMakeNegative(a*random.randint(3, 6) + random.randint(1, 6))
        term = a*x+b
        excludeFromDomain = float(-b)/float(a)
        #print "One of the functions is Rational and excluding %f" %excludeFromDomain
        if (b<0):
            function = "\\frac{%d}{%dx-%d}" %(numerator, a, -b)
        else:
            function = "\\frac{%d}{%dx+%d}" %(numerator, a, b)
        print excludeFromDomain
        return [function, excludeFromDomain]

    else:
        a = float(maybeMakeNegative(random.randint(3, 6)))
        b = float(maybeMakeNegative(a*random.randint(3, 6) + random.randint(1, 6)))
        term = a*x+b
        excludeFromDomain = float(-b)/float(a)
        if (a>0):
            inequalityDirection = "geq"
        else:
            inequalityDirection = "leq"
        if (b<0):
            function = "\\sqrt{%dx-%d} " %(a, -b)
        else:
            function = "\\sqrt{%dx+%d} " %(a, b)
        print "One of the functions is Radical and excluding %f" %excludeFromDomain
        return [function, excludeFromDomain, inequalityDirection]

def determineOperatedFunctionsInfo(function1, function2):
#Possibilities:
    #Poly, Poly
    if (function1[1]=="RR" and function2[1]=="RR"):
        return ["RR"]

    #Poly, Radical or Poly, Rational
    elif (function1[1]=="RR" and not(function2[1]=="RR")):
        return function2

    #Radical, Poly or Rational, Poly
    elif (function2[1]=="RR" and not(function1[1]=="RR")):
        return function1

    #Radical, Radical excluded
    #Radical, Rational
    #Excluded for now

    #Rational, Radical
    #Excluded for now

    #Rational, Rational
    else:
        # We need to include placeholders to make the return long enough to be distinct from the others
        return [function1, function2, 0, 0]

def domainOfFunctions(operatedFunctionInfo):
    #Poly/Poly
    if (len(operatedFunctionInfo)==1):
        message = "\\text{ The domain is all Real numbers. }"
        return [message]

    #Poly/Rational, Rational/Poly
    elif (len(operatedFunctionInfo)==2):
        message = "\\text{ The domain is all Real numbers except } x = a"
        #print "This should be a single value: %f" %operatedFunctionInfo[1]
        interval = createIntervalOptions([float(operatedFunctionInfo[1])], 5, 1)
        return [message, operatedFunctionInfo[1], interval]

    #Poly/Radical, Radical/Poly
    elif (len(operatedFunctionInfo)==3):
        if (operatedFunctionInfo[2] == "geq"):
            message = "\\text{ The domain is all Real numbers greater than or equal to } x = a"
            #print "This should be a single value in GEQ: %f" %operatedFunctionInfo[1]
            interval = createIntervalOptions([float(operatedFunctionInfo[1])], 5, 1)
            return [message, operatedFunctionInfo[1], interval]
        else:
            message = "\\text{ The domain is all Real numbers less than or equal to } x = a"
            interval = createIntervalOptions([operatedFunctionInfo[1]], 5, 1)
            return [message, operatedFunctionInfo[1], interval]

    #Rational/Rational
    else:
        message1 = "\\text{ The domain is all Real numbers except } x = a \\text{ and } x = b"
        message2 = "\\text{ and } b \\in "
        #print "Two excluded values: %f and %f" %(operatedFunctionInfo[0][1], operatedFunctionInfo[1][1])
        interval1 = createIntervalOptions([float(operatedFunctionInfo[0][1])], 5, 1)
        interval2 = createIntervalOptions([float(operatedFunctionInfo[1][1])], 5, 1)
        return [message1, message2, operatedFunctionInfo[0][1], operatedFunctionInfo[1][1], interval1, interval2]

def randomRationalDomain():
    f = generateFunctionAndDomain("Rational")
    domain = domainOfFunctions(f)
    return domain

def randomRadicalDomain(inequalityDirection):
    f = generateFunctionAndDomain("Radical")
    print f
    while (not (f[2] == inequalityDirection) ):
        f = generateFunctionAndDomain("Radical")
    domain = domainOfFunctions(f)
    return domain

def randomDoubleRationalDomain():
    f = generateFunctionAndDomain("Rational")
    g = generateFunctionAndDomain("Rational")

    info = [f, g, 0, 0]
    domain = domainOfFunctions(info)
    return domain

# BEGIN
#For now, remove "Divide"
operationList = ["Add", "Subtract", "Multiply"]
random.shuffle(operationList)

operation = operationList[int(random.randint(0, 2))]
functionClasses = generateFunctionClasses(operation)
while ((functionClasses[0] == "Radical" and functionClasses[1] == "Radical") or (functionClasses[0] == "Rational" and functionClasses[1] == "Radical") or (functionClasses[0] == "Radical" and functionClasses[1] == "Rational")):
    functionClasses = generateFunctionClasses(operation)

function1 = generateFunctionAndDomain(functionClasses[0])
function2 = generateFunctionAndDomain(functionClasses[1])

print "These are the functions: %s \\text{ and } %s" %(function1, function2)

operatedFunctionInfo = determineOperatedFunctionsInfo(function1, function2)
print "This is the info we feed into domainOfFunctions: %s" %operatedFunctionInfo
solution = domainOfFunctions(operatedFunctionInfo)
solution.append("* This is the solution!")

print len(operatedFunctionInfo)
#Poly/Poly
if (len(operatedFunctionInfo)==1):
    print "I've started distractor 1 in Poly/Poly"
    distractor1 = randomRationalDomain()
    print "I've started distractor 2 in Poly/Poly"
    distractor2 = randomRadicalDomain("leq")
    print "I've started distractor 3 in Poly/Poly"
    distractor3 = randomRadicalDomain("geq")

    # Shuffles all answers that have a single interval to input
    answerList = [distractor1, distractor2, distractor3]
    random.shuffle(answerList)

    # 4th option always has 2 intervals to input
    print "I've started distractor 4 in Poly/Poly"
    distractor4 = randomDoubleRationalDomain()
    answerList.append(distractor4)

    # Final answer is Domain of all real numbers
    displaySolution = "(-\\infty, \\infty)"
    answerList.append(solution)

#Poly/Rational, Rational/Poly
elif (len(operatedFunctionInfo)==2):
    print "I've started distractor 1 in Single Rational"
    distractor1 = randomRadicalDomain("leq")
    print "I've started distractor 2 in Single Rational"
    distractor2 = randomRadicalDomain("geq")
    print solution
    print
    displaySolution = "\\text{ The domain is all Real numbers except } x = %s" %solution[1]

    # Shuffles all answers that have a single interval to input
    answerList = [distractor1, distractor2, solution]
    random.shuffle(answerList)

    # 4th option always has 2 intervals to input
    print "I've started distractor 3 in Single Rational"
    distractor3 = randomDoubleRationalDomain()
    answerList.append(distractor3)

    # Final answer is Domain of all real numbers
    print "I've started distractor 4 in Single Rational"
    distractor4 = domainOfFunctions(["RR"])
    answerList.append(distractor4)

#Poly/Radical, Radical/Poly
elif (len(operatedFunctionInfo)==3):
    if (operatedFunctionInfo[2] == "geq"):
        print "I've started distractor 1 in Single Radical geq"
        distractor1 = randomRationalDomain()
        print "I've started distractor 2 in Single Radical geq"
        distractor2 = randomRadicalDomain("leq")
        print "Issue here."
        displaySolution = "\\text{ The domain is all Real numbers greater than or equal to} x = %s." %solution[1]

        # Shuffles all answers that have a single interval to input
        answerList = [distractor1, distractor2, solution]
        print answerList

        random.shuffle(answerList)

        # 4th option always has 2 intervals to input
        print "I've started distractor 3 in Single Radical geq"
        distractor3 = randomDoubleRationalDomain()
        answerList.append(distractor3)

        # Final answer is Domain of all real numbers
        print "I've started distractor 4 in Single Radical geq"
        distractor4 = domainOfFunctions(["RR"])
        answerList.append(distractor4)

    else:
        print "I've started distractor 1 in Single Radical leq"
        distractor1 = randomRationalDomain()
        print "I've started distractor 2 in Single Radical leq"
        distractor2 = randomRadicalDomain("geq")
        displaySolution = "\\text{ The domain is all Real numbers less than or equal to} x = %s." %solution[1]

        # Shuffles all answers that have a single interval to input
        answerList = [distractor1, distractor2, solution]
        random.shuffle(answerList)

        # 4th option always has 2 intervals to input
        print "I've started distractor 3 in Single Radical leq"
        distractor3 = randomDoubleRationalDomain()
        answerList.append(distractor3)

        # Final answer is Domain of all real numbers
        print "I've started distractor 4 in Single Radical leq"
        distractor4 = domainOfFunctions(["RR"])
        answerList.append(distractor4)

#Rational/Rational
else:
    #In the future, this should grab functions from the double and put them into the singles.
    print "I've started distractor 1 in Double Rational"
    distractor1 = randomRationalDomain()
    print "I've started distractor 2 in Double Rational"
    distractor2 = randomRadicalDomain("leq")
    print "I've started distractor 3 in Double Rational"
    distractor3 = randomRadicalDomain("geq")

    # Shuffles all answers that have a single interval to input
    answerList = [distractor1, distractor2, distractor3]
    random.shuffle(answerList)

    # 4th option always has 2 intervals to input
    answerList.append(solution)
    displaySolution = "\\text{ The domain is all Real numbers except } x = %s \\text{ and } x = %s" %(solution[2], solution[3])

    # Final answer is Domain of all real numbers
    print "I've started distractor 4 in Double Rational"
    distractor4 = domainOfFunctions(["RR"])
    answerList.append(distractor4)

# functionClasses - ["Polynomial", "Radical", "Rational"]
displayFunction1 = function1[0]
displayFunction2 = function2[0]

# In the future, this should have 10 options
displayStem = "%s the following functions, then choose the domain of the resulting function from the list below." %operation
displayProblem = "f(x) = %s \\text{ and } g(x) = %s" %(function1[0], function2[0])
generalComments = "General Comments: The new domain is the intersection of the previous domains."

c0 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[0][0], answerList[0][2][0][0], answerList[0][2][0][1])
c1 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[1][0], answerList[1][2][0][0], answerList[1][2][0][1])
c2 = "%s, \\text{ where } a \\in [%s, %s]" %(answerList[2][0], answerList[2][2][0][0], answerList[2][2][0][1])
c3 = "%s, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(answerList[3][0], answerList[3][4][0][0], answerList[3][4][0][1], answerList[3][5][0][0], answerList[3][5][0][1])
c4 = "%s" %answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = ["", "", "", "", ""]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 10 Objective 1, Master"
