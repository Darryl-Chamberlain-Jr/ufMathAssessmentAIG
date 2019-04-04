from sympy.abc import x
import random
import matplotlib.pyplot as plt
import numpy

### If I want to graph a random rational function ###
vertAsy = random.randint(-3, 3)
horShift = random.randint(-2, 2)
leadingCoeff = (-1)**random.randint(0, 1)
power = random.randint(1, 2)
stepSize = 0.01
######################################
### Particular Rational function ###
### (y-bounds may need to change) ###
#vertAsy = 3
#horShift = 1
#leadingCoeff = -1
#power = 2
#stepSize = 0.01
#######################################
### Defines x-values to avoid asymptote
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
xMin = xLeftMin - 0.5
xMax = xRightMax + 0.5
plt.xlim(xMin, xMax)
plt.ylim(-5,5)
### Saves and closes picture
plt.grid(True)
plt.savefig('graphRational', bbox_inches='tight')
plt.close()
