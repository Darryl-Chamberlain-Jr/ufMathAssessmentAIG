# IDEA - Create two lists, randomly choose whether linear or not, randomly choose from list.

linear0 = "\\text{Jamal is choosing between two truck-rental companies. The first, Keep on Trucking, Inc., charges an up-front fee of \$20, then 59 cents a mile. The second, Move It Your Way, charges an up-front fee of \$16, then 63 cents a mile.}"
linear1 = "\\text{A town has an initial population of 75,000. It grows at a constant rate of 2, 500 per year for 5 years.}"
linear2 = "\\text{The number of people afflicted with the common cold in the winter months steadily decreased by 205 each year from 2005 until 2010. In 2005, 12,025 people were inflicted.}"
linear3 = "\\text{}"
listOfLinear = [linear0, linear1, linear2, linear3]

notLinear0 = "\\text{}"
notLinear1 = "\\text{}"
notLinear2 = "\\text{}"
notLinear3 = "\\text{}"
listOfNotLinear = [notLinear0, notLinear1, notLinear2, notLinear3]

chooseAnswer = ZZ.random_element(2)
displayStem = "True or False: it would be appropriate to model the situation below with a linear function."
if chooseAnswer == 0:
    displayProblem = listOfLinear[ZZ.random_element(0, 4)]
    displaySolution = "\\text{True}"
else:
    displayProblem = listOfNotLinear[ZZ.random_element(0, 4)]
    answer = "\\text{False}"
choices = ["True", "False"]
choiceComments = ["", ""]
comments = "General Comments: For linear functions, we are looking for a \\textbf{constant} change between the quantities. That means we are adding/subtracting the same number each time."
######
### moduleNumber, version, problemNumber are defined in the tex file ###
writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
