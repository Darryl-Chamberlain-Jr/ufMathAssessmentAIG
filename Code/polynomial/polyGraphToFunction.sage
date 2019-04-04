from sympy.abc import x
import random
import matplotlib.pyplot as plt
import numpy

#load("../Code/generalPurposeMethods.sage")
# OBJECTIVE 1 - Convert between a polynomial function and its graph.
# Types of problems
    # Type 1 - Function to graph
    # Type 2 - Graph to function

# We only need one type for this test. It might be easier to do
    # Graph to function

# In the future: Plot zeros and where derivative is zero.

# Type 2 - Graph to function
    # Students should be able to determine the graph based on
        # the end behavior and degree of the polynomial.
# We need a way to zoom in on just the zeros. Multiplying by a small number doesn't work
aCoeff = (-1)**random.randint(0, 1)
degree = random.randint(3, 6)

listRandomZeros = range(-3, 3)
randomZeros = random.sample(listRandomZeros, 3)

xMinimum = min(randomZeros)-0.25
xMaximum = max(randomZeros)+0.25

def displayFactor(a):
    if a == 0:
        factor = "x"
    elif a < 0:
        factor = "(x + %d)" %-a
    else:
        factor = "(x - %d)" %a
    return factor

def displayEquation(a, z1, e1, z2, e2, z3, e3):
    print a, z1, e1, z2, e2, z3, e3
    if a < 0:
        if e1 == 2:
            if e2 == 2:
                if e3 == 2:
                    equation = "-%s^2%s^2%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "-%s^2%s^2%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
            else:
                if e3 == 2:
                    equation = "-%s^2%s%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "-%s^2%s%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
        else:
            if e2 == 2:
                if e3 == 2:
                    equation = "-%s%s^2%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "-%s%s^2%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
            else:
                if e3 == 2:
                    equation = "-%s%s%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "-%s%s%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
    else:
        if e1 == 2:
            if e2 == 2:
                if e3 == 2:
                    equation = "%s^2%s^2%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "%s^2%s^2%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
            else:
                if e3 == 2:
                    equation = "%s^2%s%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "%s^2%s%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
        else:
            if e2 == 2:
                if e3 == 2:
                    equation = "%s%s^2%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "%s%s^2%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
            else:
                if e3 == 2:
                    equation = "%s%s%s^2" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
                else:
                    equation = "%s%s%s" %(displayFactor(z1), displayFactor(z2), displayFactor(z3))
    print equation
    return equation

if degree == 6:
    print 'The issue is in degree 6.'
    equationOfGraph = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])**2
    displayEquationOfGraph = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 2)
    #
    xPlot = numpy.arange(xMinimum, xMaximum, 0.05)
    solutionGraph = aCoeff*(xPlot-randomZeros[0])**2 * (xPlot-randomZeros[1])**2 * (xPlot-randomZeros[2])**2
    plt.rcParams.update({'font.size': 22})
    showPlot = plt.plot(xPlot, solutionGraph, linewidth = 5, color = 	'#02325f')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid(True)
    plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
    plt.close()
    # Distractors #
    negativeEquation = -aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])**2
    displayNegativeEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 2)
    #
    oneZeroOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayOneZeroOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #
    twoZerosOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayTwoZerosOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #
    negativeOneZeroOffEquation = - aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayNegativeOneZeroOffEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #####

elif degree ==5:
    print 'The issue is in degree 5.'
    equationOfGraph = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayEquationOfGraph = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #
    xPlot = numpy.arange(xMinimum, xMaximum, 0.05)
    solutionGraph = aCoeff*(xPlot-randomZeros[0])**2 * (xPlot-randomZeros[1])**2 * (xPlot-randomZeros[2])
    plt.rcParams.update({'font.size': 22})
    showPlot = plt.plot(xPlot, solutionGraph, linewidth = 5, color = 	'#02325f')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid(True)
    plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
    plt.close()
    # Distractors #
    negativeEquation = -aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayNegativeEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #
    oneZeroOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayOneZeroOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #
    twoZerosOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])**2
    displayTwoZerosOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 2)
    #
    negativeOneZeroOffEquation = - aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])**2
    displayNegativeOneZeroOffEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 2)
    #####

elif degree ==4:
    print 'The issue is in degree 4.'
    equationOfGraph = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayEquationOfGraph = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #
    xPlot = numpy.arange(xMinimum, xMaximum, 0.05)
    solutionGraph = aCoeff*(xPlot-randomZeros[0])**2 * (xPlot-randomZeros[1]) * (xPlot-randomZeros[2])
    plt.rcParams.update({'font.size': 22})
    showPlot = plt.plot(xPlot, solutionGraph, linewidth = 5, color = 	'#02325f')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid(True)
    plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
    plt.close()
    # Distractors #
    negativeEquation = -aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayNegativeEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #
    oneZeroOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayOneZeroOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #
    twoZerosOffEquation = aCoeff*(x-randomZeros[0]) * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayTwoZerosOffEquation = displayEquation(aCoeff, randomZeros[0],  1, randomZeros[1], 2, randomZeros[2], 1)
    #
    negativeOneZeroOffEquation = - aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])**2
    displayNegativeOneZeroOffEquation= displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 2)
    #####

else:
    print 'The issue is in degree 3.'
    equationOfGraph = aCoeff*(x-randomZeros[0]) * (x-randomZeros[1]) * (x-randomZeros[2])
    displayEquationOfGraph = displayEquation(aCoeff, randomZeros[0],  1, randomZeros[1], 1, randomZeros[2], 1)
    #
    xPlot = numpy.arange(xMinimum, xMaximum, 0.05)
    solutionGraph = aCoeff*(xPlot-randomZeros[0]) * (xPlot-randomZeros[1]) * (xPlot-randomZeros[2])
    plt.rcParams.update({'font.size': 22})
    showPlot = plt.plot(xPlot, solutionGraph, linewidth = 5, color = 	'#02325f')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid(True)
    plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
    plt.close()
    # Distractors #
    negativeEquation = -aCoeff*(x-randomZeros[0]) * (x-randomZeros[1]) * (x-randomZeros[2])
    displayNegativeEquation = displayEquation(-aCoeff, randomZeros[0],  1, randomZeros[1], 1, randomZeros[2], 1)
    #
    oneZeroOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayOneZeroOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #
    twoZerosOffEquation = aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1])**2 * (x-randomZeros[2])
    displayTwoZerosOffEquation = displayEquation(aCoeff, randomZeros[0],  2, randomZeros[1], 2, randomZeros[2], 1)
    #
    negativeOneZeroOffEquation = -aCoeff*(x-randomZeros[0])**2 * (x-randomZeros[1]) * (x-randomZeros[2])
    displayNegativeOneZeroOffEquation = displayEquation(-aCoeff, randomZeros[0],  2, randomZeros[1], 1, randomZeros[2], 1)
    #####

displayStem = 'Which of the following equations \\textit{could} be of the graph presented below?'
displayProblem = ''
displaySolution = displayEquationOfGraph
generalComments = "General Comments: Draw the x-axis to determine which zeros are touching (and so have even multiplicity) or cross (and have odd multiplicity)"

answerList = [equationOfGraph]

c0 = negativeEquation
c1 = twoZerosOffEquation
c2 = negativeOneZeroOffEquation
c3 = equationOfGraph
c4 = oneZeroOffEquation
dc0 = displayNegativeEquation
dc1 = displayTwoZerosOffEquation
dc2 = displayNegativeOneZeroOffEquation
dc3 = displayEquationOfGraph
dc4 = displayOneZeroOffEquation
choicesAndDisplayChoices = [[c0, dc0], [c1, dc1], [c2, dc2], [c3, dc3], [c4, dc4]]
choiceComments = ["", "", "", "", ""]
random.shuffle(choicesAndDisplayChoices)
choices = [choicesAndDisplayChoices[0][0], choicesAndDisplayChoices[1][0], choicesAndDisplayChoices[2][0], choicesAndDisplayChoices[3][0], choicesAndDisplayChoices[4][0]]
displayChoices = [choicesAndDisplayChoices[0][1], choicesAndDisplayChoices[1][1], choicesAndDisplayChoices[2][1], choicesAndDisplayChoices[3][1], choicesAndDisplayChoices[4][1]]

figureName = "question%s%s" %(problemNumber, version)

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
includePictureInKey(moduleNumber, figureName, version)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, displayChoices, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "I finished Module 7, Objective 1, Master"
