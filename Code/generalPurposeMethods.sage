from sympy import *
import numpy
import random
from decimal import Decimal
import decimal

def greatestCommonDenominator(a, b):
    if(not (isinstance(a, int) and isinstance(b, int))):
        raise TypeError("One of the numbers you passed is not an integer.")
    while (not b == 0):
        temp = b
        b = a % b
        a = temp
    return abs(a)

def listToFloats(listOfNumbers):
    listOfNumbers = [float(i) for i in listOfNumbers]
    return listOfNumbers

def format_number(num):
    try:
        dec = decimal.Decimal(num)
    except:
        return 'bad'
    tup = dec.as_tuple()
    delta = len(tup.digits) + tup.exponent
    digits = ''.join(str(d) for d in tup.digits)
    if delta <= 0:
        zeros = abs(tup.exponent) - len(tup.digits)
        val = '0.' + ('0'*zeros) + digits
    else:
        val = digits[:delta] + ('0'*tup.exponent) + '.' + digits[delta:]
    val = val.rstrip('0')
    if val[-1] == '.':
        val = val[:-1]
    if tup.sign:
        return '-' + val
    return val

def cleanInterval(interval):
    print(interval)
    return [format_number(str(float(str(interval[0])))), format_number(str(float(str(interval[1]))))]
def simplifyFraction(numerator, denominator):
    if(not (isinstance(numerator, int) and isinstance(denominator, int))):
        raise TypeError("One of the numbers you passed is not an integer.")
    if(denominator == 0):
        raise ValueError("Divide by zero error when dividing %d/%d" %(numerator, denominator))
    gcd = greatestCommonDenominator(numerator, denominator)
    return [numerator/gcd, denominator/gcd]

def checkInterval(interval, solution):
    solution = float(solution)
    #The inputs of this function are the list of intervals for the distractor solutions and the list of solutions.
    isPermissible = False
    leftPoint = interval[0]
    rightPoint = interval[1]
    if(not (solution <= rightPoint and solution >= leftPoint)):
        isPermissible = True
    return isPermissible

def maybeMakeNegative(rational):
    maybeNegative = int((-1)**random.randint(0, 1))
    rational = maybeNegative * rational
    return rational

def createInterval(solution, intervalRange, precision = None):
    if(precision == None):
        leftPoint = round(solution - math.floor(abs(random.gauss(0, intervalRange/2))), 2)
        rightPoint = round(solution + math.ceil(abs(random.gauss(0, intervalRange/2))), 2)
        if (not (solution <= rightPoint and solution >= leftPoint) or rightPoint == leftPoint):
            createInterval(solution, intervalRange)
        return [leftPoint, rightPoint]
    else:
        if(isinstance(precision, int)):
            leftPoint = round(solution - math.floor(abs(random.gauss(random.uniform(0, intervalRange), intervalRange/2))), 2)
            rightPoint = round(solution + math.ceil(abs(random.gauss(random.uniform(0, intervalRange), intervalRange/2))), 2)
            if (not (solution <= rightPoint and solution >= leftPoint) or rightPoint == leftPoint):
                createInterval(solution, intervalRange)
            return [leftPoint, rightPoint]
        else:
            precision = float(precision)
            leftPoint = solution - abs(random.gauss(random.uniform(0, intervalRange), intervalRange/2))
            rightPoint = solution + abs(random.gauss(random.uniform(0, intervalRange), intervalRange/2))
            leftPoint = round(floor(leftPoint/precision)*precision, 2)
            rightPoint = round(ceil(rightPoint/precision)*precision, 2)
            if (not (solution <= rightPoint and solution >= leftPoint) or rightPoint == leftPoint):
                createInterval(solution, intervalRange)
            return [leftPoint, rightPoint]

def checkInterval(interval, solution):
    solution = float(solution)
    #The inputs of this function are the list of intervals for the distractor solutions and the list of solutions.
    isPermissible = False
    leftPoint = float(interval[0])
    rightPoint = float(interval[1])
    if(not (solution <= rightPoint and solution >= leftPoint)):
        isPermissible = True
    return isPermissible

def checkAllIntervals(intervals, solutions):
    isPermissible = True
    for i in xrange(len(intervals)):
        for j in xrange(len(solutions)):
            if(not i == j):
                if(not checkInterval(intervals[i], solutions[j])):
                    isPermissible = False
                    return isPermissible
    return isPermissible

def createIntervalList(solutions, intervalRange, precision):
    intervalList = []
    for i in xrange(len(solutions)):
        intervalList.append(createInterval(solutions[i], intervalRange, precision))
    return intervalList

def createDisjointIntervalList(solutions, intervalRange, precision):
    intervalList = createIntervalList(solutions, intervalRange, precision)
    throttleNumber = 0
    while(not checkAllIntervals(intervalList, solutions)):
        throttleNumber = throttleNumber + 1
        if(throttleNumber % 3 == 0):
            precision = precision/10.0
            intervalRange = intervalRange/2.0
        intervalList = createIntervalList(solutions, intervalRange, precision)
    return intervalList

def create2DList(rows, columns):
    outputList = []
    for i in xrange(rows):
        new = []
        for j in xrange(columns):
            new.append([])
        outputList.append(new)
    return outputList

def createIntervalOptions(solutionMatrix, intervalRange, precision):
    if (not(isinstance(solutionMatrix[0], list))):
        currentList = [solutionMatrix[j] for j in xrange(len(solutionMatrix))]
        currentSet = list(set(currentList))
        setIntervals =  createDisjointIntervalList(currentSet, intervalRange, precision)
        intervalList = [0]*len(currentList)
        print(setIntervals)
        for j in xrange(len(currentList)):
            for k in xrange(len(setIntervals)):
                if(not checkInterval(setIntervals[k], currentList[j])):
                    intervalList[j] = setIntervals[k]
        for i in xrange(len(intervalList)):
            intervalList[i] = cleanInterval(intervalList[i])

        return intervalList
    else:
        rows = len(solutionMatrix)
        columns = len(solutionMatrix[0])
        intervalMatrix = create2DList(rows, columns)
        for i in xrange(len(solutionMatrix[0])):
            currentList = [solutionMatrix[j][i] for j in xrange(len(solutionMatrix))]
            currentSet = list(set(currentList))
            setIntervals = createDisjointIntervalList(currentSet, intervalRange, precision)
            for j in xrange(len(currentList)):
                for k in xrange(len(setIntervals)):
                    if(not checkInterval(setIntervals[k], currentList[j])):
                        intervalMatrix[j][i] = setIntervals[k]
        for i in xrange(len(intervalMatrix)):
            for j in xrange(len(intervalMatrix[0])):
                intervalMatrix[i][j] = cleanInterval(intervalMatrix[i][j])
        return intervalMatrix
