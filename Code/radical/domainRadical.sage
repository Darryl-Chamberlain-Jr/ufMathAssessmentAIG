# Module 6 - Radical Equations
    # Objective 1 - Identify the domain of a radical function.
    # Objective 2 - Identify the graph of a radical function.
        # Two types of questions:
            # Graph to equation
            # Equation to graph
    # Objective 3 - Solve radical equations that lead to linear equations.
    # Objective 4 - Solve radical equations that lead to quadratic equations.

# version and problemNumber defined in .tex file

import random

precision = 1
intervalRange = 5

def displayInterval(direction):
    if direction == "Right":
        interval = "[a, \\infty)"
    else:
        interval = "(-\\infty, a]"
    return interval

def displayFactor(a, b):
    if b < 0:
        display = "%s x - %s" %(int(a), -int(b))
    else:
        display = "%s x + %s" %(int(a), int(b))
    return display

def solutionAndDistractorsEven():
    # Generates pivot
    a = float(maybeMakeNegative(random.randint(3, 9)))
    b = float(maybeMakeNegative(random.randint(3, 9)))
    while abs(a) == abs(b):
        a = float(maybeMakeNegative(random.randint(3, 9)))
        b = float(maybeMakeNegative(random.randint(3, 9)))
    factor = displayFactor(a, b)
    pivot = -b/a
    #
    # Checks direction of domain
    if a > 0:
        direction = "Right"
        reverseDirection = "Left"
    else:
        direction = "Left"
        reverseDirection = "Right"
    #
    # Generate false pivot
    falsePivot = float(-a/b)
    #
    # Creates intervals for options
    optionList = [pivot, falsePivot]
    intervalOptions1 = createIntervalOptions(optionList, intervalRange, precision)
    intervalOptions2 = createIntervalOptions(optionList, intervalRange, precision)
    #
    # Sets up display of solution
    solution = ["%s, \\text{ where } a \\in [%s, %s]" %(displayInterval(direction), intervalOptions1[0][0], intervalOptions1[0][1])]
    if direction == "Right":
        displaySolution = "[%f, \\infty)" %round(float(pivot), 3)
    else:
        displaySolution = "(-\\infty, %f]" %round(float(pivot), 3)
    #
    # Sets up display of other options
    distractor1 = ["%s, \\text{where } a \\in [%s, %s]" %(displayInterval(reverseDirection), intervalOptions2[0][0], intervalOptions2[0][1])]
    distractor2 = ["%s, \\text{where } a \\in [%s, %s]" %(displayInterval(direction), intervalOptions1[1][0], intervalOptions1[1][1])]
    distractor3 = ["%s, \\text{where } a \\in [%s, %s]" %(displayInterval(reverseDirection), intervalOptions2[1][0], intervalOptions2[1][1])]
    distractor4 = ["(-\\infty, \\infty)"]
    #
    # Assigns comments to options
    solution.append("* This is the correct option.")
    distractor1.append("This distractor corresponds to reversing the direction of the domain.")
    distractor2.append("This distractor corresponds to the pivot %f." %round(falsePivot, 3))
    distractor3.append("This distractor corresponds to reversing the direction of the domain AND the pivot %f." %round(falsePivot, 3))
    distractor4.append("This distractor corresponds to the radical having an odd power.")
    #
    # Shuffles options
    allOptions = [solution, distractor1, distractor2, distractor3, distractor4]
    random.shuffle(allOptions)
    choices = [allOptions[0][0], allOptions[1][0], allOptions[2][0], allOptions[3][0], allOptions[4][0]]
    choiceComments = [allOptions[0][1], allOptions[1][1], allOptions[2][1], allOptions[3][1], allOptions[4][1]]
    return [factor, displaySolution, choices, choiceComments]

def solutionAndDistractorsOdd():
    # Generates pivot
    a = float(maybeMakeNegative(random.randint(3, 9)))
    b = float(maybeMakeNegative(random.randint(3, 9)))
    while abs(a) == abs(b):
        a = float(maybeMakeNegative(random.randint(3, 9)))
        b = float(maybeMakeNegative(random.randint(3, 9)))
    factor = displayFactor(a, b)
    pivot = -b/a
    #
    # Checks direction of domain
    if a > 0:
        direction = "Right"
        reverseDirection = "Left"
    else:
        direction = "Left"
        reverseDirection = "Right"
    #
    # Generate false pivot
    falsePivot = float(-a/b)
    #
    # Creates intervals for options
    optionList = [pivot, falsePivot]
    intervalOptions1 = createIntervalOptions(optionList, intervalRange, precision)
    intervalOptions2 = createIntervalOptions(optionList, intervalRange, precision)
    #
    # Sets up display of solution
    solution = ["(-\\infty, \\infty)"]
    displaySolution = solution[0]
    #
    # Sets up display of other options
    distractor1 = ["\\text{The domain is } %s, \\text{   where } a \\in [%s, %s]" %(displayInterval(direction), intervalOptions1[0][0], intervalOptions1[0][1])]
    distractor2 = ["\\text{The domain is } %s, \\text{   where } a \\in [%s, %s]" %(displayInterval(reverseDirection), intervalOptions2[0][0], intervalOptions2[0][1])]
    distractor3 = ["\\text{The domain is } %s, \\text{   where } a \\in [%s, %s]" %(displayInterval(direction), intervalOptions1[1][0], intervalOptions1[1][1])]
    distractor4 = ["\\text{The domain is } %s, \\text{   where } a \\in [%s, %s]" %(displayInterval(reverseDirection), intervalOptions2[1][0], intervalOptions2[1][1])]
    #
    # Assigns comments to options
    solution.append("* This is the correct option.")
    distractor1.append("This distractor corresponds to the radical having an even power.")
    distractor2.append("This distractor corresponds to radical having an even power AND reversing the direction of the domain.")
    distractor3.append("This distractor corresponds to the radical having an even power AND the pivot %f." %round(falsePivot, 3))
    distractor4.append("This distractor corresponds to the radical having an even power AND reversing the direction of the domain AND the pivot %f." %round(falsePivot, 3))
    #
    # Shuffles options
    allOptions = [solution, distractor1, distractor2, distractor3, distractor4]
    random.shuffle(allOptions)
    choices = [allOptions[0][0], allOptions[1][0], allOptions[2][0], allOptions[3][0], allOptions[4][0]]
    choiceComments = [allOptions[0][1], allOptions[1][1], allOptions[2][1], allOptions[3][1], allOptions[4][1]]
    return [factor, displaySolution, choices, choiceComments]

rootDegree = random.randint(3, 8)
if rootDegree % 2 == 0:
    factor, displaySolution, choices, choiceComments = solutionAndDistractorsEven()
else:
    factor, displaySolution, choices, choiceComments = solutionAndDistractorsOdd()

print "%s \n %s \n %s \n %s \n %s \n" %(choices[0], choices[1], choices[2], choices[3], choices[4])

displayStem = "What is the domain of the function below?"
displayProblem = "f(x) = \\sqrt[%d]{%s}" %(rootDegree, factor)
generalComments = "Remember that we cannot take the even root of a negative number - this is why the domain is only sometimes restricted! If we have an even root, we solve $%s \\geq 0$. Since this is an inequality, remember to flip the inequality if we divide by a negative number." %factor

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)
print 'I have finished running Objective 1, Master'
