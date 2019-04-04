# Generates an answer key file. Takes in the Module number and Version (A, B, or C).
def writeQuestionToFile(moduleNumber, version, problemNumber, stem, problem):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("%d. %s\n" % (problemNumber, stem))
    keyFile.write("$$ %s $$ \n" % problem)
    keyFile.close()

def writePictureQuestionToFile(moduleNumber, version, problemNumber, stem, problem):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("%d. %s\n" % (problemNumber, stem))
    keyFile.write("%s \n" % problem)
    keyFile.close()

def writeSolutionAndOptionsToFile(moduleNumber, version, solution, items, itemComments):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("The solution is $ %s $ \n\n" %solution)
    keyFile.write("\\begin{enumerate}[label=\\Alph*.] \n")
    for i in xrange(len(items)):
        keyFile.write("\\item $ %s $ \n\n" %items[i])
        keyFile.write(" %s \n" %itemComments[i])
    keyFile.write("\\end{enumerate} \n \n")
    keyFile.close()

def writePictureSolutionAndPictureOptionsToFile(moduleNumber, version, solutionName, figureNames, itemComments):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("The solution is  \n")
    keyFile.write("\\begin{center}")
    keyFile.write("\\includegraphics[scale=0.5]{../Figures/%s.png}" %solutionName)
    keyFile.write("\\end{center}")
    keyFile.write("\\begin{enumerate}[label=\\Alph*.] \n")
    for i in xrange(len(figureNames)):
        keyFile.write("\\item %s \n" %itemComments[i])
        keyFile.write("\\begin{center}")
        keyFile.write("\\includegraphics[scale=0.5]{../Figures/%s.png}" %figureNames[i])
        keyFile.write("\\end{center} \n \n")
    keyFile.write("\\end{enumerate} \n \n")
    keyFile.close()

def writeCommentsToFile(moduleNumber, version, comment):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("%s\n\n" %comment)
    keyFile.write("-----------------------------------------------\n\n")
    keyFile.close()

def includePictureInKey(moduleNumber, figureName, version):
    keyFile = open('../Keys/key' + str(moduleNumber) + str(version) + '.tex', 'a')
    keyFile.write("\\begin{center}")
    keyFile.write("\\includegraphics[scale=0.5]{../Figures/%s.png}" %figureName)
    keyFile.write("\\end{center}")
    keyFile.close()
