from sympy.abc import x
import numpy
import matplotlib.pyplot as plt

x = var("x")
# OBJECTIVE 1 - Convert between a quadratic function and its graph.
# Two types:
    # Type 1 - Graph to function
    # Type 2 - Function to graph
print "I  have begun running Objective 1"
load("../Code/generalPurposeMethods.sage")
#load("generalPurposeMethods.sage")
# TYPE 1 - Graph to function
# To allow students to graph, we need to control the vertex and let a=1
aCoeffGtF = maybeMakeNegative(1)
vertexGtF = [0, 0]
vertexGtF[0] = maybeMakeNegative(random.randint(1, 2))*2
vertexGtF[1] = maybeMakeNegative(random.randint(1, 5))*2

graphToFunction = aCoeffGtF * (x-vertexGtF[0])**2 + vertexGtF[1]
plt.rcParams.update({'font.size': 22})
plt.figure(1)
plt.subplot(111)

graphX = numpy.arange(vertexGtF[0] - 3, vertexGtF[0] + 3, 0.01)
graphY = aCoeffGtF * (graphX-vertexGtF[0])**2 + vertexGtF[1]
plt.plot(graphX, graphY, linewidth = 5, color = 	'#02325f')

plt.subplot(111)
plt.plot( [ vertexGtF[0] ], [ vertexGtF[1] ], 'bs')

plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
plt.close()

bCoeffGtF = -2*vertexGtF[0]*aCoeffGtF
cCoeffGtF = aCoeffGtF*vertexGtF[0]^2 +vertexGtF[1]

solution = [aCoeffGtF, bCoeffGtF, cCoeffGtF]

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList

intervalRange = 3

solutionInterval = generateSolutionInterval(solution, intervalRange)
# Ideas for distractors
    # DISTRACTORbCoeffGtF = Integer(2*vertexGtF[0]*aCoeffGtF)
distractorBcoeff = [aCoeffGtF, 2*vertexGtF[0]*aCoeffGtF, cCoeffGtF]
    # DISTRACTORcCoeffGtF = Integer(aCoeffGtF*vertexGtF[0]^2 - vertexGtF[1])
distractorCcoeff = [aCoeffGtF, bCoeffGtF, aCoeffGtF*vertexGtF[0]**2 - vertexGtF[1]]
    # Both distractors so far
distractorBandCcoeff = [aCoeffGtF, 2*vertexGtF[0]*aCoeffGtF, aCoeffGtF*vertexGtF[0]**2 - vertexGtF[1]]
    # DISTRACTORaCoeffGtF = - aCoeffGtF
distractorAcoeff = [-aCoeffGtF, 2*vertexGtF[0]*aCoeffGtF, cCoeffGtF]

distractor1 = distractorBcoeff
distractor2 = distractorCcoeff
distractor3 = [aCoeffGtF, 2*vertexGtF[0]*aCoeffGtF, aCoeffGtF*vertexGtF[0]**2 - vertexGtF[1]]
distractor4 = [-aCoeffGtF, 2*vertexGtF[0]*aCoeffGtF, cCoeffGtF]

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = [createIntervalOptions([aCoeffGtF], intervalRange, precision)[0], intervalOptions[1][1], intervalOptions[1][2]]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

displayStem1 = 'Write the equation of the graph presented below in the form $f(x)=ax^2+bx+c$, assuming  $a=1$ or $a=-1$. Then, choose the intervals that $a, b,$ and $c$ belong to.'
displayProblem1 = "\\begin{center} \\includegraphics[width = 0.35\\textwidth]{../Figures/question%s%s.png} \\end{center}" %(problemNumber, version)

if solution[0] < 0:
    if solution[1] < 0:
        if solution[2] < 0:
            displaySolution1 = "-x^2 - %s x - %s" %(-solution[1], -solution[2])
        else:
            displaySolution1 = "-x^2 - %s x + %s" %(-solution[1], solution[2])
    else:
        if solution[2] < 0:
            displaySolution1 = "-x^2 + %s x - %s" %(solution[1], -solution[2])
        else:
            displaySolution1 = "-x^2 + %s x + %s" %(solution[1], solution[2])
else:
    if solution[1] < 0:
        if solution[2] < 0:
            displaySolution1 = "x^2 - %s x - %s" %(-solution[1], -solution[2])
        else:
            displaySolution1 = "x^2 - %s x + %s" %(-solution[1], solution[2])
    else:
        if solution[2] < 0:
            displaySolution1 = "x^2 + %s x - %s" %(solution[1], -solution[2])
        else:
            displaySolution1 = "x^2 + %s x + %s" %(solution[1], solution[2])

comments = "General Comments: When the graph is pointing up, $a=1$. When the graph is pointing down, $a=-1$. Be sure to use Vertex Form: $y = a(x-h)^2+k$."

solutionInterval.append("* This is the correct solution")
distractor1Interval.append(" Distractor 1: This distractor corresponds to having b as negative.")
distractor2Interval.append(" Distractor 2: This distractor corresponds to not distributing correctly (so that c is not correct).")
# START HERE
distractor3Interval.append(" Distractor 3: This distractor corresponds to having b as negative AND not distributing correctly.")
distractor4Interval.append(" Distractor 4: This distractor corresponds to having a and b as negative.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\text{ and } \\hspace*{5mm} c \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1])
c1 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\text{ and } \\hspace*{5mm} c \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1])
c2 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\text{ and } \\hspace*{5mm} c \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1])
c3 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\text{ and } \\hspace*{5mm} c \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1])
c4 = "a \\in [%s, %s], \\hspace*{5mm} b \\in [%s, %s], \\text{ and } \\hspace*{5mm} c \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][3], answerList[1][3], answerList[2][3], answerList[3][3], answerList[4][3]]

writePictureQuestionToFile(moduleNumber, version, problemNumber, displayStem1, displayProblem1)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution1, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

######################################################
print "I  have finished running Objective 1 Type 1"
print "I  have begun running Objective 1 Type 2"
######################################################

problemNumber = problemNumber + 1
# Type 2 - Function to graph

def putChoicesInOrder(choiceAndComment):
    if choiceAndComment[0] == "A":
        place = 0
    elif choiceAndComment[0] == "B":
        place = 1
    elif choiceAndComment[0] == "C":
        place = 2
    elif choiceAndComment[0] == "D":
        place = 3
    else:
        place = 4
    return place

aCoeffFtG = maybeMakeNegative(1)
vertexFtG = [int(0), int(0)]
vertexFtG[0] = maybeMakeNegative(random.randint(1, 4))
vertexFtG[1] = maybeMakeNegative(random.randint(10, 20))

functionToGraph = aCoeffFtG* (x-vertexFtG[0])**2 + vertexFtG[1]

# Ideas for distractions
    # a(x+h)^2+k
figureAnswerList = [["A", ''], ["B", ''], ["C", ''], ["D", ''], ["E", '']]
random.shuffle(figureAnswerList)
xPlot = numpy.arange(-5, 5, 0.01)
graphX = numpy.arange(-5, 5, 0.01)

solutionGraph = aCoeffFtG* (xPlot-vertexFtG[0])**2 + vertexFtG[1]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(graphX, solutionGraph, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + figureAnswerList[0][0] + str(version) + '.png', bbox_inches='tight')
plt.close()
figureAnswerList[0][1] = "This is the correct option."

# a(x+h)^2+k
postiveHdistractor = aCoeffFtG* (xPlot+vertexFtG[0])**2 + vertexFtG[1]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(graphX, postiveHdistractor, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + figureAnswerList[1][0] + str(version) + '.png', bbox_inches='tight')
plt.close()
figureAnswerList[1][1] = "Distractor: Used the incorrect general form $f(x) = a(x+h)^2 + k$"

# a(x+h)^2-k
negativeKdistractor = aCoeffFtG* (xPlot+vertexFtG[0])**2 - vertexFtG[1]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(graphX, negativeKdistractor, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + figureAnswerList[2][0] + str(version) + '.png', bbox_inches='tight')
plt.close()
figureAnswerList[2][1] = "Distractor: Used the incorrect general form $f(x) = a(x+h)^2 - k$"

# -a(x-h)^2+k
negativeAdistractor = -aCoeffFtG* (xPlot-vertexFtG[0])**2 + vertexFtG[1]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(graphX, negativeAdistractor, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + figureAnswerList[3][0] + str(version) + '.png', bbox_inches='tight')
plt.close()
figureAnswerList[3][1] = "Distractor: Used the incorrect general form $f(x) = -a(x-h)^2 + k$"

#-a(x+h)^2+k
negativeApositiveHdistractor = -aCoeffFtG* (xPlot+vertexFtG[0])**2 + vertexFtG[1]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(graphX, negativeApositiveHdistractor, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + figureAnswerList[4][0] + str(version) + '.png', bbox_inches='tight')
plt.close()
figureAnswerList[4][1] = "Distractor: Used the incorrect general form $f(x) = -a(x+h)^2 + k$"

displayStem2 = 'Graph the equation below.'

# functionToGraph = aCoeffFtG* (x-vertexFtG[0])**2 + vertexFtG[1]
if aCoeffFtG < 0:
    if vertexFtG[0] < 0:
        if vertexFtG[1] < 0:
            displayProblem2 = 'f(x) = -(x+%s)^2 - %s' %(-vertexFtG[0], -vertexFtG[1])
        else:
            displayProblem2 = 'f(x) = -(x+%s)^2 + %s' %(-vertexFtG[0], vertexFtG[1])
    else:
        if vertexFtG[1] < 0:
            displayProblem2 = 'f(x) = -(x-%s)^2 - %s' %(vertexFtG[0], -vertexFtG[1])
        else:
            displayProblem2 = 'f(x) = -(x-%s)^2 + %s' %(vertexFtG[0], vertexFtG[1])
else:
    if vertexFtG[0] < 0:
        if vertexFtG[1] < 0:
            displayProblem2 = 'f(x) = (x+%s)^2 - %s' %(-vertexFtG[0], -vertexFtG[1])
        else:
            displayProblem2 = 'f(x) = (x+%s)^2 + %s' %(-vertexFtG[0], vertexFtG[1])
    else:
        if vertexFtG[1] < 0:
            displayProblem2 = 'f(x) = (x-%s)^2 - %s' %(vertexFtG[0], -vertexFtG[1])
        else:
            displayProblem2 = 'f(x) = (x-%s)^2 + %s' %(vertexFtG[0], vertexFtG[1])

displaySolution2 =  "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%s%s%s.png}" %(problemNumber, figureAnswerList[0][0], version)
figureSolution = "question%s%s%s" %(problemNumber, figureAnswerList[0][0], version)
comments = "General Comments: Remember that Vertex Form is $y = a(x-h)^2+k$, where the vertex is $(h, k)$."

choices2 = ["", "", "", "", ""]
choices2[0] = "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%sA%s.png}" %(problemNumber, version)
choices2[1] = "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%sB%s.png}" %(problemNumber, version)
choices2[2] = "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%sC%s.png}" %(problemNumber, version)
choices2[3] = "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%sD%s.png}" %(problemNumber, version)
choices2[4] = "\\includegraphics[width = 0.25\\textwidth]{../Figures/question%sE%s.png}" %(problemNumber, version)
allFigureNames = ["question%sA%s" %(problemNumber, version), "question%sB%s" %(problemNumber, version), "question%sC%s" %(problemNumber, version), "question%sD%s" %(problemNumber, version), "question%sE%s" %(problemNumber, version)]

choiceComments2 = ["", "", "", "", ""]

placement0 = putChoicesInOrder(figureAnswerList[0])
placement1 = putChoicesInOrder(figureAnswerList[1])
placement2 = putChoicesInOrder(figureAnswerList[2])
placement3 = putChoicesInOrder(figureAnswerList[3])
placement4 = putChoicesInOrder(figureAnswerList[4])
placements = [placement0, placement1, placement2, placement3, placement4]

choiceComments2[placement0] = figureAnswerList[0][1]
choiceComments2[placement1] = figureAnswerList[1][1]
choiceComments2[placement2] = figureAnswerList[2][1]
choiceComments2[placement3] = figureAnswerList[3][1]
choiceComments2[placement4] = figureAnswerList[4][1]

#print "Problems here: \n"
#print "Answer List Mixed Order %s \n" %figureAnswerList
#print "Choice order: %s \n" %placements
#print choiceComments2

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem2, displayProblem2)
#writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution2, choices2, choiceComments2)
writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, figureSolution, allFigureNames, choiceComments2)
writeCommentsToFile(moduleNumber, version, comments)
print 'I have finished running Objective 1 Master'
