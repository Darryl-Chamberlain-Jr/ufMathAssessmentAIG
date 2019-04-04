import numpy
from sympy.abc import x, y
from sympy import Symbol
import matplotlib.pyplot as plt
import fractions

##### IMPORTANT DAMNIT #####
# If we just use gcd, Sage assumes it is the Sage function (and so we have to be careful what types of values we feed it.)
# To just use the Python gcd, we import fractions and use fractions.gcd

#load("../Code/generalPurposeMethods.sage")
print "Starting Objective 1 Type 3"
# OBJECTIVE 1 - Constructing linear functions from points and slope
# We can make a few types of this:
    # Type 1 - Two points (zero/non-zero slope)
    # Type 2 - Another line and a point
    # Type 3 - Go from graph to equation (either slope-int or standard)
    # Future Type - Ask for Standard Form A, B, C.

# Type 3 - Graph to Standard Form
# For now, we make sure the y-intercept is an integer.
def simplifySolution(A, B, C):
    if(A < 0):
        A = -A
        B = -B
        C = -C
    print 'These are the coefficients so far %d %d %d' %(A, B, C)
    aBGCD = fractions.gcd(A, B)
    print aBGCD
    bCGCD = fractions.gcd(B, C)
    print bCGCD
    mixedGCD = fractions.gcd(aBGCD, bCGCD)
    while(mixedGCD > 1):
        A = A/mixedGCD
        B = B/mixedGCD
        C = C/mixedGCD
        aBGCD = fractions.gcd(A, B)
        bCGCD = fractions.gcd(B, C)
        mixedGCD = fractions.gcd(aBGCD, bCGCD)
    return [A, B, C]

def generateProblemAndSolution(numeratorMax, interceptMax):
    numeratorSlope = float(maybeMakeNegative(random.randint(2, numeratorMax)))
    denominatorSlope = float(random.randint(2, numeratorMax))

    # Makes sure slope is rational
    while fractions.gcd(numeratorSlope, denominatorSlope) > 1:
        numeratorSlope = float(maybeMakeNegative(random.randint(2, numeratorMax)))
        denominatorSlope = float(random.randint(2, numeratorMax))

    print "Slope should be: %s/%s" %(numeratorSlope, denominatorSlope)
    slopeGraph = float(numeratorSlope/denominatorSlope)
    yInt = random.randint(-interceptMax, interceptMax)

    point2 = [denominatorSlope, slopeGraph*denominatorSlope + yInt]
    point3 = [-denominatorSlope, -slopeGraph*denominatorSlope + yInt]

    # Converts to Stadard Form
    if slopeGraph > 0:
        aOfGraph = -numeratorSlope
        bOfGraph = denominatorSlope
        cOfGraph = denominatorSlope*yInt
    else:
        aOfGraph = numeratorSlope
        bOfGraph = -denominatorSlope
        cOfGraph = -denominatorSlope*yInt
    return [simplifySolution(aOfGraph, bOfGraph, cOfGraph), [slopeGraph, yInt], point2, point3]

def distractorNegativeA(solution):
    # (-aOfGraph, -bOfGraph, -cOfGraph)
        # Student didn't make sure A is positive
    A, B, C = solution
    return [-A, -B, -C]
def distractorRemoveFractions(slopeInt):
    # (-slopeGraph, 1, yInt)
        # Student didn't remove rational coefficients
    slope, yInt = slopeInt
    return[-slope, 1, yInt]
def distractorOppositeSlope(solution):
    A, B, C = solution
    return [-B, A, (A*C)/B]
    # (- denominatorSlope, numeratorSlope*pointGraph[1], numeratorSlope*yIntBad)
        # Used opposite slope. Recalculate yInt for the opposite slope.
def distractorOppositeSlopeRemoveFractions(solution):
    A, B, C = solution
    return [-B/A, 1, (A*C)/B]

def generateSolutionInterval(solution, intervalRange):
    intervalList = [[]]*len(solution)
    for i in xrange(0, len(solution)):
        intervalList[i] = createInterval(solution[i], intervalRange)
    return intervalList
# Ideas for Distractors

    # (-denominatorSlope/numeratorSlope, 1, yIntBad)
        # Student didn't remove rational coefficients
intervalRange = 5
numeratorMax = 5
interceptMax = 5
solution, slopeInt, point2, point3 = generateProblemAndSolution(numeratorMax, interceptMax)
print "This is the solution and slope/y-int: %s and %s" %(solution, slopeInt)
#solutionInterval = generateSolutionInterval(listToFloats(solution), intervalRange)
distractor1 = distractorNegativeA(solution)
distractor2 = simplifySolution(distractorRemoveFractions(slopeInt)[0], distractorRemoveFractions(slopeInt)[1], distractorRemoveFractions(slopeInt)[2])
distractor3 = simplifySolution(distractorOppositeSlope(solution)[0], distractorOppositeSlope(solution)[1], distractorOppositeSlope(solution)[2])
distractor4 = simplifySolution(distractorOppositeSlopeRemoveFractions(solution)[0], distractorOppositeSlopeRemoveFractions(solution)[1], distractorOppositeSlopeRemoveFractions(solution)[2])

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
precision = 1
intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

#distractor1Interval = createFeasibleIntervals(listToFloats(distractor1), solution, intervalRange)
#distractor2Interval = createFeasibleIntervals(listToFloats(distractor2), solution, intervalRange)
#distractor3Interval = createFeasibleIntervals(listToFloats(distractor3), solution, intervalRange)
#distractor4Interval = createFeasibleIntervals(listToFloats(distractor4), solution, intervalRange)

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Corresponds to not making $A$ positive (by multiplying the equation by $-1$).")
distractor2Interval.append(" Corresponds to not removing rational values.")
distractor3Interval.append(" Corresponds to using the opposite slope of the graph, but did everything else correctly.")
distractor4Interval.append(" Corresponds to using the opposite slope of the graph and not removing rational values.")

slopeGraph, yInt = slopeInt
graphToEquation = slopeGraph * x + yInt
print "Equation that was graphed: %s" %graphToEquation

#########################

# TESTING NEW GRAPH METHOD #
graphX = numpy.arange(-5, 5, 0.5)
graphY = slopeGraph*graphX + yInt

#exterma = [-5*slopeGraph+yInt, 5*slopeGraph+yInt]
#yMin = int(min(exterma))
#yMax = int(max(exterma))

plt.figure(1)
plt.subplot(111)
plt.plot(graphX, graphY, linewidth = 5, color = '#02325f')

plt.subplot(111)
plt.plot([0], [yInt], 'bs')
plt.text(0, yInt, "[0, %s]" %yInt)

plt.subplot(111)
plt.plot([point2[0]], [point2[1]], 'bs')
plt.text(point2[0], point2[1], "[%d, %d]" %(point2[0], point2[1]))

plt.subplot(111)
plt.plot([point3[0]], [point3[1]], 'bs')
plt.text(point3[0], point3[1], "[%d, %d]" %(point3[0], point3[1]))

#plt.xlim(-6, 6)
#plt.ylim(yMin, yMax)
plt.rcParams.update({'font.size': 22})
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.savefig('../Figures/question' + str(problemNumber) + str(version) + '.png', bbox_inches='tight')
plt.close()

###########################

displayStem = 'Write the equation of the line in the graph below in the form $Ax+By=C$. Then, choose the intervals that contain $A, B, \\text{ and } C$.'

displaySlope = round(slopeGraph, 3)
if yInt < 0:
    equationToDisplay = "%s x - %s" %(displaySlope, -yInt)
else:
    equationToDisplay = "%s x + %s" %(displaySlope, yInt)
displayProblem = "\\text{Equation that was graphed: } %s" %equationToDisplay

if solution[1] < 0:
    solutionFunction = "%s x - %s y" %(Integer(solution[0]), -Integer(solution[1]))
else:
    solutionFunction = "%s x + %s y" %(Integer(solution[0]), Integer(solution[1]))

displaySolution = "%s = %s" %(solutionFunction, Integer(solution[2]))

comments = "General Comments: Standard form is supposed to have $A > 0$ and all fractions removed."

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "A \\in [%s, %s], \\hspace{3mm} B \\in [%s, %s], \\text{ and } \\hspace{3mm} C \\in [%s, %s]" %(answerList[0][0][0], answerList[0][0][1], answerList[0][1][0], answerList[0][1][1], answerList[0][2][0], answerList[0][2][1])
c1 = "A \\in [%s, %s], \\hspace{3mm} B \\in [%s, %s], \\text{ and } \\hspace{3mm} C \\in [%s, %s]" %(answerList[1][0][0], answerList[1][0][1], answerList[1][1][0], answerList[1][1][1], answerList[1][2][0], answerList[1][2][1])
c2 = "A \\in [%s, %s], \\hspace{3mm} B \\in [%s, %s], \\text{ and } \\hspace{3mm} C \\in [%s, %s]" %(answerList[2][0][0], answerList[2][0][1], answerList[2][1][0], answerList[2][1][1], answerList[2][2][0], answerList[2][2][1])
c3 = "A \\in [%s, %s], \\hspace{3mm} B \\in [%s, %s], \\text{ and } \\hspace{3mm} C \\in [%s, %s]" %(answerList[3][0][0], answerList[3][0][1], answerList[3][1][0], answerList[3][1][1], answerList[3][2][0], answerList[3][2][1])
c4 = "A \\in [%s, %s], \\hspace{3mm} B \\in [%s, %s], \\text{ and } \\hspace{3mm} C \\in [%s, %s]" %(answerList[4][0][0], answerList[4][0][1], answerList[4][1][0], answerList[4][1][1], answerList[4][2][0], answerList[4][2][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][3], answerList[1][3], answerList[2][3], answerList[3][3], answerList[4][3]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
