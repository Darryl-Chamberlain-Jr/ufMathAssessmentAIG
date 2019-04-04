#!/bin/bash
# This script generates exams. You will need to change DIR to match where your directory is located.

DIR="media/archdoc/7636-BC29/improvedExamGeneration"

createAnswerKeyFile() {
    MODULENUMBER=$1
    MODULEVERSION=$2
    /bin/cat > /${DIR}/Keys/key${MODULENUMBER}${MODULEVERSION}.tex << FINISH_HIM
\documentclass{article}[10pt]
\usepackage{multicol, enumerate, enumitem, hyperref, color, soul, setspace, parskip, fancyhdr, amssymb, amsthm, amsmath, bbm, latexsym, units, mathtools}
\everymath{\displaystyle}
\usepackage[headsep=0.5cm,headheight=0cm, left=1 in,right= 1 in,top= 1 in,bottom= 1 in]{geometry}

\begin{document}
This is the Answer Key for Module ${MODULENUMBER} Version ${MODULEVERSION}.

FINISH_HIM
}

finishAnswerKeyFile() {
    MODULENUMBER=$1
    MODULVERVERSION=$2
    /bin/cat >> /${DIR}/Keys/key${MODULENUMBER}${MODULEVERSION}.tex << FINISH_HIM

\end{document}
FINISH_HIM
}

generateModuleAllVersions() {
    MODULENAME=$1
    MODULENUMBER=$2
    # Creating empty keys for all versions
    for version in A B C MU
    do
        cd /${DIR}/${MODULENAME}/
        createAnswerKeyFile $2 $version
        pdflatex -file-line-error -halt-on-error /${DIR}/${MODULENAME}/Module${MODULENUMBER}${version}.tex
        sage /${DIR}/${MODULENAME}/Module${MODULENUMBER}${version}.sagetex.sage
        pdflatex -file-line-error -halt-on-error /${DIR}/${MODULENAME}/Module${MODULENUMBER}${version}.tex
        finishAnswerKeyFile $2 $version
        cd /${DIR}/Keys/
        pdflatex -file-line-error -halt-on-error /${DIR}/Keys/key${MODULENUMBER}${version}.tex
    done
    # Copy/Pastes all completed PDFs to a new folder
    cp /${DIR}/${MODULENAME}/*.pdf /${DIR}/CompleteExam/PDFs
}

generateModuleSingleVersion() {
    MODULENAME=$1
    MODULENUMBER=$2
    VERSION=$3
    cd /${DIR}/${MODULENAME}/
    createAnswerKeyFile $2 $3
    pdflatex -file-line-error -halt-on-error /${DIR}/${MODULENAME}/Module${MODULENUMBER}${VERSION}.tex
    sage /${DIR}/${MODULENAME}/Module${MODULENUMBER}${VERSION}.sagetex.sage
    pdflatex -file-line-error -halt-on-error /${DIR}/${MODULENAME}/Module${MODULENUMBER}${VERSION}.tex
    finishAnswerKeyFile $2 $3
    cd /${DIR}/Keys/
    pdflatex -file-line-error -halt-on-error /${DIR}/Keys/key${MODULENUMBER}${VERSION}.tex
    cp /${DIR}/${MODULENAME}/Module${MODULENUMBER}${VERSION}.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/Keys/key${MODULENUMBER}${VERSION}.pdf /${DIR}/CompleteExam/Keys/
}

copyAllModulePDFs() {
    cp /${DIR}/M01RealAndComplexNumbers/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M02Linear/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M03inequality/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M04Quadratic/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M05Radical/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M06Polynomials/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M07Rational/*.pdf /${DIR}/CompleteExam/PDFs
    cp /${DIR}/M08LogAndExp/*.pdf /${DIR}/CompleteExam/PDFs
}

copyKeys() {
    cp /${DIR}/Keys/*.pdf /${DIR}/CompleteExam/Keys/
}

clearOldVersions() {
    rm -rf /${DIR}/Keys/*
    rm -rf /${DIR}/CompleteExam/Keys/*
    rm -rf /${DIR}/CompleteExam/PDFs/*
}


clearOldVersions
##### COMMENT OUT AS FINISHED #####
generateModuleAllVersions 'M01RealAndComplexNumbers' 1
generateModuleAllVersions 'M02Linear' 2
generateModuleAllVersions 'M03Inequality' 3
#generateModuleAllVersions 'M04Quadratic' 4
generateModuleAllVersions 'M05Radical' 5
generateModuleAllVersions 'M06Polynomials' 6
generateModuleAllVersions 'M07Rational' 7
generateModuleAllVersions 'M08LogAndExp' 8
copyKeys

#For finicky code, use this to generate each version separately until it compiles without error.
### MAKE SURE YOU TURN OFF 'clearOldVersions' FIRST
#generateModuleSingleVersion 'M04Quadratic' 4 'C'
