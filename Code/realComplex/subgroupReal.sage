from sympy import *
import numpy
import random

#OBJECTIVE 1 - Identify the subgroup of Real numbers a number belongs to.
#TYPES - Autogenerate a Whole, Integer, Rational, Irrational, or non-real number.

#Allows you to control question type
#load("../Code/generalPurposeMethods.sage")

answers = ['Whole', 'Integer', 'Rational', 'Irrational', 'Not a Real Number']
random.shuffle(answers)
questiontype = answers[random.randint(0, 4)]
choices = ['\\text{Whole}', '\\text{Integer}', '\\text{Rational}', '\\text{Irrational}', '\\text{Not a Real number}']
random.shuffle(choices)

print "Question type: %s" %questiontype

#Question Type 1 generates Whole numbers
if questiontype=='Whole':
    denominatorbase = random.randint(5, 25)
    numeratorbase = denominatorbase * random.randint(5, 25)
    denominator = denominatorbase * denominatorbase
    numerator = numeratorbase * numeratorbase
    displayProblem =  '\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)

#Question Type 2 generates Integers
elif questiontype=='Integer':
    denominatorbase = random.randint(5, 25)
    # Makes sure we return a natural number
    numeratorbase = denominatorbase * random.randint(5, 25)
    # Makes perfect squares
    denominator = denominatorbase * denominatorbase
    numerator = numeratorbase * numeratorbase
    displayProblem =  '-\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)

#Question Type 3 generates Rational numbers
elif questiontype=='Rational':
    numerator = random.randint(5, 25)
    denominator = random.randint(5, 25)
    # Checks to make sure we get a non-Whole, Rational number
    while (gcd(numerator, denominator) > 1):
        denominator = random.randint(5, 25)

    randomNeg = (-1)**random.randint(0, 1)
    if randomNeg == -1:
        displayProblem =  '-\\sqrt{\\frac{%d}{%d}}' %(numerator**2, denominator**2)
    else:
        displayProblem =  '\\sqrt{\\frac{%d}{%d}}' %(numerator**2, denominator**2)

#Question Type 4 generates Irrational numbers
elif questiontype=='Irrational':
	# Base of the number under the square root
    discriminantbase = random.randint(9, 18)
    # The number we will use to make sure we get an irrational number
    irrationalmaker = 5

    # Masks that the fraction is not a perfect square
    maskirrational = random.randint(5, 15)

	# Makes sure the product is not a perfect square
    while gcd(discriminantbase, irrationalmaker) > 1:
        irrationalmaker = random.randint(9, 18)

    numerator = discriminantbase * irrationalmaker * maskirrational
    denominator = maskirrational

    randomNeg = (-1)**random.randint(0, 1)
    if randomNeg == -1:
        displayProblem =  '-\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)
    else:
        displayProblem =  '\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)

#Question Type 5 generates Non-Real numbers (divding by zero or complex)
elif questiontype == 'Not a Real Number':
    chooseZeroOrComplex = random.randint(0, 1)

    if chooseZeroOrComplex == 0:
        # Not a number
        numerator = random.randint(5, 25)
        denominator = 0

        randomNeg = (-1)**random.randint(0, 1)
        if randomNeg == -1:
            displayProblem =  '-\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)
        else:
            displayProblem =  '\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)

    else:
        # Complex number
        discrim = random.randint(9, 18)
        irrationalmaker = 5
        maskirrational = random.randint(5, 15)

        while gcd(discrim, irrationalmaker) > 1:
            irrationalmaker = random.randint(9, 18)

        numerator = - discrim * irrationalmaker * maskirrational
        denominator = maskirrational
        randomNeg = (-1)**random.randint(0, 1)

        if randomNeg == -1:
            displayProblem =  '-\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)
        else:
            displayProblem =  '\\sqrt{\\frac{%d}{%d}}' %(numerator, denominator)
else:
    print "Something bad happened!"

#displayNumber = randomnegative * sqrt(numerator/denominator)
# This randomizes the answer choices
displayStem = 'Choose the \\textbf{smallest} set of Real numbers that the number below belongs to.'
displaySolution = "\\text{%s}" %questiontype
print displayProblem
# No comments per choice
choiceComments = ["", "", "", "", ""]

comments = "General Comments: The only ways to *not* be a Real number are: dividing by 0 or taking the square root of a negative number. Irrational numbers are more than just square root of 3: adding or subtracting values from square root of 3 is also irrational."
#print "Version: %s" %version

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
print "Finished with Objective 1!"
