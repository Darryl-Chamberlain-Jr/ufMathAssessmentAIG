import numpy
import math
import random
import matplotlib.pyplot as plt

def sketchRationalFunction(vertAsy, leadingCoeff, power, horShift, figureName, optionLetter):
    ### Defines x-values to avoid asymptote
    plt.rcParams.update({'font.size': 22})
    stepSize = 0.01
    xLeftMin = vertAsy - 2.5
    xLeftMax = vertAsy - stepSize
    xRightMin = vertAsy + stepSize
    xRightMax = vertAsy + 2.5
    ### x-values for graphing
    xLeft = numpy.arange(xLeftMin, xLeftMax, stepSize)
    xPlotLeft = leadingCoeff/(xLeft-vertAsy)**power + horShift
    xRight = numpy.arange(xRightMin, xRightMax, stepSize)
    xPlotRight = leadingCoeff/(xRight-vertAsy)**power + horShift
    ### Lines to plot
    plt.plot(xLeft, xPlotLeft, linewidth=5, color='blue')
    plt.plot(xRight, xPlotRight, linewidth=5, color='blue')
    plt.axvline(x=vertAsy, ls=('dashed'), color='black')
    plt.axhline(y=horShift, ls=('dashed'), color='black')
    ### x and y bounds to make pretty picture
    yMin = horShift - 2.5
    yMax = horShift + 2.5
    #plt.xlim(xMin, xMax)
    plt.ylim([float(yMin),float(yMax)])
    ### Saves and closes picture
    plt.grid(True)
    plt.savefig('../Figures/' + str(figureName) + str(optionLetter) + '.png', bbox_inches='tight')
    plt.close()

def createFunction():
    vertAsy = random.randint(1, 3)*(-1)**random.randint(0, 1)
    horShift = random.randint(1, 3)*(-1)**random.randint(0, 1)
    leadingCoeff = (-1)**random.randint(0, 1)
    power = random.randint(1, 2)
    return [vertAsy, leadingCoeff, power, horShift]

def displayEquation(vertAsy, leadingCoeff, power, horShift):
    if power == 1:
        if vertAsy < 0:
            if horShift < 0:
                equation = "\\frac{%s}{x + %s} - %s" %(leadingCoeff, -vertAsy, -horShift)
            else:
                equation = "\\frac{%s}{x + %s} + %s" %(leadingCoeff, -vertAsy, horShift)
        else:
            if horShift < 0:
                equation = "\\frac{%s}{x - %s} - %s" %(leadingCoeff, vertAsy, -horShift)
            else:
                equation = "\\frac{%s}{x - %s} + %s" %(leadingCoeff, vertAsy, horShift)
    else:
        if vertAsy < 0:
            if horShift < 0:
                equation = "\\frac{%s}{(x + %s)^2} - %s" %(leadingCoeff, -vertAsy, -horShift)
            else:
                equation = "\\frac{%s}{(x + %s)^2} + %s" %(leadingCoeff, -vertAsy, horShift)
        else:
            if horShift < 0:
                equation = "\\frac{%s}{(x - %s)^2} - %s" %(leadingCoeff, vertAsy, -horShift)
            else:
                equation = "\\frac{%s}{(x - %s)^2} + %s" %(leadingCoeff, vertAsy, horShift)
    return equation

def createDistractors(vertAsy, leadingCoeff, power, horShift, figureName, optionList):
    if power == 1:
        distractor1 = [displayEquation(-vertAsy, -leadingCoeff, power, horShift), "Corresponds to using the general form $f(x) = \\frac{a}{x+h}+k$ and the opposite leading coefficient."]
        sketchRationalFunction(-vertAsy, -leadingCoeff, power, horShift, figureName, optionList[1])
        distractor2 = [displayEquation(vertAsy, leadingCoeff, power+1, horShift), "Corresponds to thinking the graph was a shifted version of $\\frac{1}{x^2}$."]
        sketchRationalFunction(vertAsy, leadingCoeff, power+1, horShift, figureName, optionList[2])
        distractor3 = [displayEquation(-vertAsy, -leadingCoeff, power+1, horShift), "Corresponds to thinking the graph was a shifted version of $\\frac{1}{x^2}$, using the general form $f(x) = \\frac{a}{x+h}+k$, and the opposite leading coefficient."]
        sketchRationalFunction(-vertAsy, -leadingCoeff, power+1, horShift, figureName, optionList[3])
    else:
        distractor1 = [displayEquation(-vertAsy, -leadingCoeff, power, horShift), "Corresponds to using the general form $f(x) = \\frac{a}{(x+h)^2}+k$ and the opposite leading coefficient."]
        sketchRationalFunction(-vertAsy, -leadingCoeff, power, horShift, figureName, optionList[1])
        distractor2 = [displayEquation(vertAsy, leadingCoeff, power-1, horShift), "Corresponds to thinking the graph was a shifted version of $\\frac{1}{x}$."]
        sketchRationalFunction(vertAsy, leadingCoeff, power-1, horShift, figureName, optionList[2])
        distractor3 = [displayEquation(-vertAsy, -leadingCoeff, power-1, horShift), "Corresponds to thinking the graph was a shifted version of $\\frac{1}{x}$, using the general form $f(x) = \\frac{a}{(x+h)^2}+k$, and the opposite leading coefficient."]
        sketchRationalFunction(-vertAsy, -leadingCoeff, power-1, horShift, figureName, optionList[3])
    return [distractor1, distractor2, distractor3]

##### END OF DEFINITIONS #####
figureName = "question%s%s" %(problemNumber, version)
optionList = ["A", "B", "C", "D"]
random.shuffle(optionList)
figureNameShuffledList = [ "%s%s" %(figureName, optionList[0]), "%s%s" %(figureName, optionList[1]), "%s%s" %(figureName, optionList[2]), "%s%s" %(figureName, optionList[3])]
vertAsy, leadingCoeff, power, horShift = createFunction()
sketchRationalFunction(vertAsy, leadingCoeff, power, horShift, figureName, optionList[0])

solution = [displayEquation(vertAsy, leadingCoeff, power, horShift), "This is the correct option."]
distractor1, distractor2, distractor3 = createDistractors(vertAsy, leadingCoeff, power, horShift, figureName, optionList)

displayStem = "Choose the graph of the equation below."
displayProblem = solution[0]
generalComments = "General Comments: Remember that the general form of a basic rational equation is $ f(x) = \\frac{a}{(x-h)^n} + k$, where $a$ is the leading coefficient (and in this case, we assume is either $1$ or $-1$), $n$ is the degree (in this case, either $1$ or $2$), and $(h, k)$ is the intersection of the asymptotes."
choiceComments = ["", "", "", ""]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, figureNameShuffledList[0], figureNameShuffledList, choiceComments)
writeCommentsToFile(moduleNumber, version, generalComments)

print "\n \n Successfully finished running rationalEquationToGraph.sage \n"
