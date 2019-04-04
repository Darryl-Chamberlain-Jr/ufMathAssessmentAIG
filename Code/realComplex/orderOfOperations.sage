import random

load("../Code/generalPurposeMethods.sage")

print "I have started Module 1 Objective 2"
#load("generalPurposeMethods.sage")
def intervalToString(intervalList):
    return "[" + str(intervalList[0]) + ", " + str(intervalList[1]) + "]"
#OBJECTIVE 2 - Apply the properties of Real numbers to simplify large expressions.
listNaturals=list(range(1, 21))

#Range for all of the intervals that we are going to be using.
intervalRange = 5
precision = 1

# Array of 6 distinct integers
constants = random.sample(listNaturals, 6)

first = float(constants[0])
second = float(constants[1])
third = float(constants[2])
fourth = float(constants[3])
fifth = float(constants[4])
sixth = float(constants[5])

solution = float((first - ((second/third) * fourth)) - (fifth * sixth ))
distractor1 = float(first - (second / (third * fourth) ) - (fifth * sixth))
distractor2 =  float(first - (second / (third * fourth)) - fifth * -1.0 * sixth)
distractor3 =  float(((first - ((second/third) * fourth)) - fifth) * sixth)
distractor4 = float((first - ((second/third) * -1.0 *  fourth) - fifth) * sixth)

while solution == distractor1 or solution == distractor2 or solution == distractor3 or solution == distractor4 or distractor1 == distractor2 or distractor1 == distractor3 or distractor1 == distractor4 or distractor2 == distractor3 or distractor2 == distractor4 or distractor3 == distractor4:
    listNaturals = list(range(1, 21))
    constants = random.sample(listNaturals, 6)

    first = float(constants[0])
    second = float(constants[1])
    third = float(constants[2])
    fourth = float(constants[3])
    fifth = float(constants[4])
    sixth = float(constants[5])

    solution = float((first - ((second/third) * fourth)) - (fifth * sixth))
    # Most common distractor
    distractor1 =  float(first - (second / (third * fourth)) - (fifth * sixth))
    # Second most common
    distractor2 = float(first - (second / (third * fourth)) - fifth * -1.0 * sixth)
    distractor3 = float(((first - ((second/third) * fourth)) - fifth) * sixth)
    distractor4 = float((first - ((second/third) * -1.0 *  fourth) - fifth) * sixth)

solutionList = [solution, distractor1, distractor2, distractor3, distractor4]
print "Solution and Distractors: %s" %solutionList

displayStem = 'Simplify the expression below and choose the interval the simplification is contained within.'
displayProblem = '%d - %d \\div %d * %d - (%d * %d)' %(first, second, third, fourth, fifth, sixth)
displaySolution = round(solution, 3)
comments = "General Comments: While you may remember (or were taught) PEMDAS is done in order, it is actually done as P/E/MD/AS. When we are at MD or AS, we read left to right."

intervalOptions = createIntervalOptions(solutionList, intervalRange, precision)

solutionInterval = intervalOptions[0]
distractor1Interval = intervalOptions[1]
distractor2Interval = intervalOptions[2]
distractor3Interval = intervalOptions[3]
distractor4Interval = intervalOptions[4]

solutionInterval.append("* Correct option.")
distractor1Interval.append(" Messed up their order of operations.")
distractor2Interval.append(" Did not distribute addition and subtraction correctly.")
distractor3Interval.append(" Did not distribute negative correctly.")
distractor4Interval.append(" This is just an arbitrary distractor.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval, distractor4Interval]
random.shuffle(answerList)

c0 = "[%s, %s]" %(answerList[0][0], answerList[0][1])
c1 = "[%s, %s]" %(answerList[1][0], answerList[1][1])
c2 = "[%s, %s]" %(answerList[2][0], answerList[2][1])
c3 = "[%s, %s]" %(answerList[3][0], answerList[3][1])
c4 = "[%s, %s]" %(answerList[4][0], answerList[4][1])
choices = [c0, c1, c2, c3, c4]
choiceComments = [answerList[0][2], answerList[1][2], answerList[2][2], answerList[3][2], answerList[4][2]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "Objective 2 completed without error"
