print "I have started Objective 3"

from sympy import *
from sympy import Symbol


#load("../Code/generalPurposeMethods.sage")
#load("./generalPurposeMethods.sage")

# OBJECTIVE 3 - Identify the subgroup of Complex numbers a number belongs to.
# TYPES - Autogenerate a Rational, Irrational, Nonreal Complex, Pure Imaginary, or Non-Complex number
#Allows you to control question type

answers = ["Rational", "Irrational", "Nonreal Complex", "Pure Imaginary", "Not a Complex Number"]
random.shuffle(answers)

choices = ["\\text{Rational}", "\\text{Irrational}", "\\text{Nonreal Complex}", "\\text{Pure Imaginary}", "\\text{Not a Complex Number}"]
random.shuffle(choices)

questiontype = answers[random.randint(0, 4)]
print questiontype

#Question Type 1 generates Rational numbers of the form a + 0i
if questiontype == "Rational":

    numerator = random.randint(2, 20)*(-1)**random.randint(0, 1)
    denominator = random.randint(2, 20)*(-1)**random.randint(0, 1)
    i = Symbol('i')
    b = random.randint(2, 10)
    displayProblem = '\\frac{%d}{%d}+%d i^2' %(numerator, denominator, b)

#Question Type 2 generates Irrational numbers of the form a + 0i
elif questiontype == "Irrational":
    # Base of the number under the square root
    discriminantbase = random.randint(9, 18)
    # The number we will use to make sure we get an irrational number
    irrationalmaker = 5
    # Makes sure the product is not a perfect square
    while gcd(discriminantbase, irrationalmaker) > 1:
        irrationalmaker = random.randint(9, 18)

    numerator = discriminantbase * irrationalmaker
    denominator = random.randint(5, 20)
    i = Symbol('i')
    b = random.randint(2, 10)
    displayProblem = '\\frac{\\sqrt{%d}}{%d}+%d i^2' %(numerator, denominator, b)

#Question Type 3 generates Nonreal Complex numbers of the form a + bi
elif questiontype == "Nonreal Complex":
    numerator = random.randint(5, 25)*(-1)**random.randint(0, 1)
    denominator = random.randint(5, 25)
    while gcd(numerator, denominator) == denominator:
        denominator = random.randint(5, 25)

    # Base of the number under the square root
    discriminantbase = random.randint(9, 18)
    # The number we will use to make sure we get an irrational number
    irrationalmaker = 5
    # Makes sure the product is not a perfect square
    while gcd(discriminantbase, irrationalmaker) > 1:
        irrationalmaker = random.randint(9, 18)
    i = Symbol('i')
    inside = discriminantbase*irrationalmaker
    b = "\\sqrt{%d} %s" %(inside, i)

    displayProblem = '\\frac{%d}{%d}+%s' %(numerator, denominator, b)

#Question Type 4 generates Pure Imaginary numbers of the form 0 + bi
elif questiontype == "Pure Imaginary":
    numerator = 0
    denominator = random.randint(2, 20)*(-1)**random.randint(0, 1)
    i = Symbol('i')
    b = int(random.randint(2, 10))

    displayProblem = '\\frac{0}{%d \\pi}+%si' %(denominator, b)

#Question Type 5 generates Non-Complex numbers (dividing by 0)
elif questiontype == "Not a Complex Number":
    numerator = random.randint(5, 25)
    denominator = 0
    i = Symbol('i')
    b = random.randint(2, 10)

    displayProblem = '\\frac{%d \\pi}{0}+%d i^2' %(numerator, b)

# No comments per choice
choiceComments = ["", "", "", "", ""]

displayStem = 'Choose the \\textbf{smallest} set of Complex numbers that the number below belongs to.'
displaySolution = "\\text{%s}" %questiontype
comments = "General Comments: Be sure to simplify $i^2 = -1$. This may remove the imaginary portion for your number."

writeQuestionToFile(moduleNumber, version, problemNumber, displayStem, displayProblem)
writeSolutionAndOptionsToFile(moduleNumber, version, displaySolution, choices, choiceComments)
writeCommentsToFile(moduleNumber, version, comments)
