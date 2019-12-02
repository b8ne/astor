#!/bin/bash

# Bash script to run a batch of Astor runs
# Mode is fixed on jGenProg
# MaxGenerations is fixed on 50
# Population size varies on 1, 10, 20, 50

#Local Astor Path
ASTOR_PATH="/Users/ben/Documents/Uni/astor"

# Log Output Path
LOG="batch_log_10threads.txt"
CSV_LOG="batch_log_10threads.csv"

# Main running function
# $1: mode (jgenprog, jmutrepair, jkali, cardumen)
# $2: location/package
# $3: dependencies
# $4: maxgenerations
# $5: out (workingDirectory) default: ./output_astor/
# $6: population size
function runAstor
{
  # Use ts to timestamp all log entries
  echo Running astor for $1 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  start=`date +%s`
  java -cp $(cat ./astor-classpath.txt):target/classes fr.inria.main.evolution.AstorMain -mode $1 -srcjavafolder /src/java/ -srctestfolder /src/test/ -binjavafolder /target/classes/ -bintestfolder /target/test-classes/ -location $2 -dependencies $3 -maxgen $4 -out $5 -population $6
  end=`date +%s`

  # Output to log
  echo Finished | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  echo Population Size: $6 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  echo Project: $3 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  echo Execution Time: $((end-start)) | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  echo "----------------------------------------------------------------" >> $LOG

  # Output to CSV
  echo $2, $4, $1, $6, $((end-start)) >> $CSV_LOG
}

function runjgenprog {
  declare -a POPULATION=(1, 10, 20, 50)
  for i in "${POPULATION[@]}"
  do
      runAstor "jgenprog" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 50 "./output_astor/$2population-$i/jgenprog/" $i
  done
}

# Start Log
echo STARTING NEW BATCH REPAIR | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
echo "----------------------------------------------------------------" >> $LOG

#Add CSV headers
echo PACKAGE, GENERATIONS, MODE, POPULATION SIZE, EXECUTION TIME >> $CSV_LOG

# Run grouped testMultiMet directories
for PROJ in $( ls "./examples/testMultiMet/" )
do
  if [[ -f "examples/testMultiMet/$PROJ/pom.xml" ]]; then
    runjgenprog "examples/testMultiMet/$PROJ" "testMultiMet/$PROJ"
  fi
done

# Run grouped testMet directories
for PROJ in $( ls "./examples/testMet/" )
do
  if [[ -f "examples/testMet/$PROJ/pom.xml" ]]; then
    runjgenprog "examples/testMet/$PROJ" "testMet/$PROJ"
  fi
done

# Run single directories
declare -a EXAMPLES=("Math-0c1ef/"
                      "math_85/"
                      "math_70/"
                      "Math-issue-280/"
                      "Math-issue-288/"
                      "math_2/"
                      "math_5/"
                      "jsoup31be24/"
                      "introclass/3b2376/003/"
                      "math_50/"
                      "math_74/"
                      "math_76/"
                      "math_106/"
                      "lang_63/"
                      "lang_39/"
                      "lang_1/"
                      "lang_55/"
                      "math_57/"
                      "math_70_modified/"
                      "lang_7/")
for i in "${EXAMPLES[@]}"
do
    runjgenprog "examples/$i" $i
done

echo "----------------------------------------------------------------" >> $LOG
echo FINISHED RUNNING BATCH REPAIR >> $LOG

exit 0;
