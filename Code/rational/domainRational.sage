# Module 12 - Rational Functions
# Objective 1 - Domain of Rational Functions

import random

def generateRationalFunction():
    a1 = random.randint(3, 6)
    b1 = maybeMakeNegative(random.randint(3, 6))
    a2 = random.randint(3, 6)
    b2 = maybeMakeNegative(random.randint(3, 6))
    excludeFromDomain1 = float(-b1)/float(a1)
    excludeFromDomain2 = float(-b2)/float(a2)
    while (excludeFromDomain1 == excludeFromDomain2):
        a1 = random.randint(3, 6)
        b1 = maybeMakeNegative(random.randint(3, 6))
        a2 = random.randint(3, 6)
        b2 = maybeMakeNegative(random.randint(3, 6))
        excludeFromDomain1 = float(-b1)/float(a1)
        excludeFromDomain2 = float(-b2)/float(a2)
    # (a1*x+b1)(a2*x+b2) = (a1*a2)*x**2 + (a1*b2 + a2*b1)*x + (b1*b2)
    coeffA = a1*a2
    coeffB = a1*b2 + a2*b1
    coeffC = b1*b2
    if coeffC < 0:
        if coeffB < 0:
            function = "%s x^2 - %s x - %s" %(coeffA, -coeffB, -coeffC)
        else:
            function = "%s x^2 + %s x - %s" %(coeffA, coeffB, -coeffC)
    else:
        if coeffB < 0:
            function = "%s x^2 - %s x + %s" %(coeffA, -coeffB, coeffC)
        else:
            function = "%s x^2 + %s x + %s" %(coeffA, coeffB, coeffC)
    distractor1 = -a1*b1
    distractor2 = -a2*b2
    return [function, excludeFromDomain1, excludeFromDomain2, distractor1, distractor2]

quadraticDenominator, exclude1, exclude2, distractor1, distractor2 = generateRationalFunction()
numerator = random.randint(3, 6)
intervalRange = 3
precision = 1

listOfValues = [exclude1, exclude2, distractor1, distractor2]
intervalOptions = createIntervalOptions(listOfValues, intervalRange, precision)

solution = ["\\text{All Real numbers except } x = a \\text{ and } x = b, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(intervalOptions[0][0], intervalOptions[0][1], intervalOptions[1][0], intervalOptions[1][1]), "This is the correct option!"]
distractorExclude2 = ["\\text{All Real numbers except } x = a \\text{ and } x = b, \\text{ where } a \\in [%s, %s] \\text{ and } b \\in [%s, %s]" %(intervalOptions[2][0], intervalOptions[2][1], intervalOptions[3][0], intervalOptions[3][1]), "This corresponds to not factoring the denominator correctly."]
distractorExclude1Wrong = ["\\text{All Real numbers except } x = a, \\text{ where } a \\in [%s, %s]" %(intervalOptions[0][0], intervalOptions[0][1]), "This corresponds to removing only 1 value from the denominator."]
distractorExclude1Right = ["\\text{All Real numbers except } x = a, \\text{ where } a \\in [%s, %s]" %(intervalOptions[2][0], intervalOptions[2][1]), "This corresponds to removing a distractor value from the denominator."]
distractorAll = ["\\text{All Real numbers.}", "This corresponds to thinking the denominator has complex roots or that rational functions have a domain of all Real numbers."]

displayStem = "Determine the domain of the function below."
displayProblem = "\\frac{%s}{%s}" %(numerator, quadraticDenominator)
displaySolution = solution[0]
generalComments = "General Comments: The new domain is the intersection of the previous domains."

answerList = [solution, distractorExclude2, distractorExclude1Wrong, distractorExclude1Right, distractorAll]
random.shuffle(answerList)

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
c4 = answerList[4][0]
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1], answerList[4][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I have completed Module 12 Objective 1, Master"
