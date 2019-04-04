import random
# OBJECTIVE 1 - Describe and graph one-dimensional inequalities.
# Types - Convert description to compound inequalities
    # Right now, just one kind ("or")
#load("../Code/generalPurposeMethods.sage")

def generateProblem(minimum, maximum):
    distance = random.randint(minimum, maximum)
    fromNumber = random.randint(-maximum, maximum)
    while distance == fromNumber:
        distance = random.randint(minimum, maximum)
        fromNumber = random.randint(-maximum, maximum)
    return [distance, fromNumber]
def generateSolution(problem):
    distance, fromNumber = problem
    return [fromNumber - distance, fromNumber + distance]
def distractorFlipFlopProblem(problem):
    fromNumber, distance = problem
    if (distance<0):
        return [fromNumber + distance, fromNumber - distance]
    else:
        return [fromNumber - distance, fromNumber + distance]

minimum = 3
maximum = 9
problem = generateProblem(minimum, maximum)
distance, fromNumber = problem

solution = generateSolution(problem)
solutionInterval = ['[%d, %d]' %(solution[0], solution[1]) ]
distractor1Interval = ['(%d, %d)' %(solution[0], solution[1]) ]

distractor = distractorFlipFlopProblem(problem)
distractor2Interval = [ '[%d, %d]' %(distractor[0], distractor[1]) ]
distractor3Interval = [ '(%d, %d)' %(distractor[0], distractor[1]) ]

displayStem = 'Using an interval or intervals, describe all the $x$-values within or including a distance of the given values.'
displayProblem = '\\text{ No more than } %d \\text{ units from the number } %d.' %(distance, fromNumber)
displaySolution = '[%d, %d]' %(solution[0], solution[1])
comments = "General Comments: No more than translates to within. So, we are looking for all the numbers within a certain number."

solutionInterval.append("* Correct option.")
distractor1Interval.append("Corresponds to not including the endpoints.")
distractor2Interval.append("Corresponds to flipping which number is the 'center' and how far away we are counting from the center number.")
distractor3Interval.append("Corresponds to flipping the numbers AND not including the endpoints.")

answerList = [solutionInterval, distractor1Interval, distractor2Interval, distractor3Interval]
random.shuffle(answerList)

c0 = answerList[0][0]
c1 = answerList[1][0]
c2 = answerList[2][0]
c3 = answerList[3][0]
choices = [c0, c1, c2, c3]
choiceComments = [answerList[0][1], answerList[1][1], answerList[2][1], answerList[3][1]]

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)

print "I finished Module 4, Objective 1 Master"
