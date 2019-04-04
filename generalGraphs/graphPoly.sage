from sympy.abc import x
import random
import matplotlib.pyplot as plt
import numpy

####
aCoeff = 1
zeros = [-1, 1, 2]
exponents = [1, 1, 2]
####
xMinimum = min(zeros)-0.25
xMaximum = max(zeros)+0.25
equationOfGraph = aCoeff*(x-zeros[0])**exponents[0] * (x-zeros[1])**exponents[1] * (x-zeros[2])**exponents[2]
xPlot = numpy.arange(xMinimum, xMaximum, 0.05)
solutionGraph = aCoeff*(xPlot-zeros[0])**exponents[0] * (xPlot-zeros[1])**exponents[1] * (xPlot-zeros[2])**exponents[2]
plt.rcParams.update({'font.size': 22})
showPlot = plt.plot(xPlot, solutionGraph, linewidth = 5, color = 	'#02325f')
plt.xlabel('x')
plt.ylabel('y')

plt.grid(True)
plt.savefig('graphPoly', bbox_inches='tight')
plt.close()
