# Module 6 - Radical Equations
    # Objective 1 - Identify the domain on which a radical function is not defined.
    # Objective 2 - Identify the graph of a radical function.
        # Two types of questions:
            # Graph to equation
            # Equation to graph
    # Objective 3 - Solve radical equations that lead to linear equations.
    # Objective 4 - Solve radical equations that lead to quadratic equations.

import numpy
import math
import random
import matplotlib.pyplot as plt

def cubeRootThisBitch(value):
    if value > 0:
        return (value)**(1./3.)
    else:
        return -(-value)**(1./3.)

def sketchFunctionAndPoint(rootDegree, coefficient, pointOfInterest, figureName, optionLetter):
    if rootDegree == 2:
        graphX = numpy.arange(pointOfInterest[0], pointOfInterest[0]+4, 0.05)
        graphY = [coefficient * math.sqrt(graphX[i] - pointOfInterest[0]) + pointOfInterest[1] for i in range(len(graphX)) ]
    else:
        graphX = numpy.arange(pointOfInterest[0]-3, pointOfInterest[0]+3, 0.05)
        graphY = [coefficient * cubeRootThisBitch(graphX[i] - pointOfInterest[0]) + pointOfInterest[1] for i in range(len(graphX)) ]

    plt.figure(1)
    plt.subplot(111)
    plt.plot(graphX, graphY, linewidth = 5)

    plt.subplot(111)
    plt.plot( [ pointOfInterest[0] ], [ pointOfInterest[1] ], 'bs')

    plt.rcParams.update({'font.size': 22})
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid(True)
    plt.savefig('../Figures/' + str(figureName) + str(optionLetter) + '.png', bbox_inches='tight')
    plt.close()

def createFunctionAndPointOfInterest(figureName, optionLetter):
    rootDegree = random.randint(2, 3)
    #rootDegree = 2
    coefficient = maybeMakeNegative(1)
    a = 1
    b = maybeMakeNegative(random.randint(3, 7))*2
    #while gcd(abs(a), abs(b)) == 1:
        #a = maybeMakeNegative(random.randint(3, 7))
        #b = maybeMakeNegative(random.randint(3, 7))
    k = maybeMakeNegative(random.randint(3, 7))
    fa = float(a)
    fb = float(b)
    pointOfInterest = [fb/fa, k]
    sketchFunctionAndPoint(rootDegree, coefficient, pointOfInterest, figureName, optionLetter)
    return [rootDegree, coefficient, pointOfInterest]

def displayEquation(rootDegree, coefficient, pointOfInterest):
    if rootDegree == 2:
        if pointOfInterest[0] < 0:
            if pointOfInterest[1] < 0:
                if coefficient < 0:
                    equation = "- \\sqrt{x + %d} - %d" %(-pointOfInterest[0], -pointOfInterest[1])
                else:
                    equation = "\\sqrt{x + %d} - %d" %(-pointOfInterest[0], -pointOfInterest[1])
            else:
                if coefficient < 0:
                    equation = "- \\sqrt{x + %d} + %d" %(-pointOfInterest[0], pointOfInterest[1])
                else:
                    equation = "\\sqrt{x + %d} + %d" %(-pointOfInterest[0], pointOfInterest[1])
        else:
            if pointOfInterest[1] < 0:
                if coefficient < 0:
                    equation = "- \\sqrt{x - %d} - %d" %(pointOfInterest[0], -pointOfInterest[1])
                else:
                    equation = "\\sqrt{x - %d} - %d" %(pointOfInterest[0], -pointOfInterest[1])
            else:
                if coefficient < 0:
                    equation = "- \\sqrt{x - %d} + %d" %(pointOfInterest[0], pointOfInterest[1])
                else:
                    equation = "\\sqrt{x - %d} + %d" %(pointOfInterest[0], pointOfInterest[1])
    else:
        if pointOfInterest[0] < 0:
            if pointOfInterest[1] < 0:
                if coefficient < 0:
                    equation = "- \\sqrt[3]{x + %d} - %d" %(-pointOfInterest[0], -pointOfInterest[1])
                else:
                    equation = "\\sqrt[3]{x + %d} - %d" %(-pointOfInterest[0], -pointOfInterest[1])
            else:
                if coefficient < 0:
                    equation = "- \\sqrt[3]{x + %d} + %s" %(-pointOfInterest[0], pointOfInterest[1])
                else:
                    equation = "\\sqrt[3]{x + %d} + %d" %(-pointOfInterest[0], pointOfInterest[1])
        else:
            if pointOfInterest[1] < 0:
                if coefficient < 0:
                    equation = "- \\sqrt[3]{x - %d} - %d" %(pointOfInterest[0], -pointOfInterest[1])
                else:
                    equation = "\\sqrt[3]{x - %d} - %d" %(pointOfInterest[0], -pointOfInterest[1])
            else:
                if coefficient < 0:
                    equation = "- \\sqrt[3]{x - %d} + %d" %(pointOfInterest[0], pointOfInterest[1])
                else:
                    equation = "\\sqrt[3]{x - %d} + %d" %(pointOfInterest[0], pointOfInterest[1])
    return equation

def createDistractors(rootDegree, coefficient, pointOfInterest, optionList, figureName):
    # -coefficient, [pointOfInterest[0], pointOfInterest[1]]
    distractor1 = [displayEquation(rootDegree, -coefficient, [pointOfInterest[0], pointOfInterest[1]]), "Corresponds to switching the coefficient and having the correct vertex."]
    sketchFunctionAndPoint(rootDegree, -coefficient, [pointOfInterest[0], pointOfInterest[1]], figureName, optionList[1])

    # coefficient, (-pointOfInterest[0], pointOfInterest[1])
    distractor2 = [displayEquation(rootDegree, coefficient, [-pointOfInterest[0], pointOfInterest[1]]), "Corresponds to the correct coefficient and switching the $x$-value of the vertex."]
    sketchFunctionAndPoint(rootDegree, coefficient, [-pointOfInterest[0], pointOfInterest[1]], figureName, optionList[2])

    # -coefficient, (-pointOfInterest[0], pointOfInterest[1])
    distractor3 = [displayEquation(rootDegree, -coefficient, [-pointOfInterest[0], pointOfInterest[1]]), "Corresponds to switching the coefficient AND switching the $x$-value of the vertex."]
    sketchFunctionAndPoint(rootDegree, -coefficient, [-pointOfInterest[0], pointOfInterest[1]], figureName, optionList[3])

    return [distractor1, distractor2, distractor3]

##### END OF DEFINITIONS #####
figureName = "question%s%s" %(problemNumber, version)
optionList = ["A", "B", "C", "D"]
random.shuffle(optionList)
figureNameShuffledList = [ "%s%s" %(figureName, optionList[0]), "%s%s" %(figureName, optionList[1]), "%s%s" %(figureName, optionList[2]), "%s%s" %(figureName, optionList[3])]
rootDegree, coefficient, pointOfInterest = createFunctionAndPointOfInterest(figureName, optionList[0])

print
print "Check here."
print rootDegree, coefficient, pointOfInterest
print
solution = [displayEquation(rootDegree, coefficient, pointOfInterest), "This is the correct option."]
distractor1, distractor2, distractor3 = createDistractors(rootDegree, coefficient, pointOfInterest, optionList, figureName)

displayStem = "Choose the graph of the equation below."
displayProblem = solution[0]
#includePictureInKey(moduleNumber, figureName, version)
generalComments = "General Comments: Remember that the general form of a radical equation is $ f(x) = a \\sqrt[b]{x - h} + k$, where $a$ is the leading coefficient (and in this case, we assume is either $1$ or $-1$), $b$ is the root degree (in this case, either $2$ or $3$), and $(h, k)$ is the vertex."
choiceComments = ["This is the correct option.", "Corresponds to switching the coefficient and having the correct vertex.", "Corresponds to the correct coefficient and switching the $x$-value of the vertex.", "Corresponds to switching the coefficient AND switching the $x$-value of the vertex."]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, figureNameShuffledList[0], figureNameShuffledList, choiceComments)
#writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)
