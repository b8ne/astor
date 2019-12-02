#!/bin/bash

ASTOR_PATH="/Users/ben/Documents/Uni/astor"
LOG="batch_log.txt"

# $1: mode jgenprog, jmutrepair, jkali, cardumen
# $2: location
# $3: dependencies
# $4: maxgen 200
# $5: out (workingDirectory) ./output_astor/
function runAstor
{
  #echo Running astor for $1 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  start=`date +%s`
  java -cp $(cat ./astor-classpath.txt):target/classes fr.inria.main.evolution.AstorMain -mode $1 -srcjavafolder /src/java/ -srctestfolder /src/test/ -binjavafolder /target/classes/ -bintestfolder /target/test-classes/ -location $2 -dependencies $3 -maxgen $4 -out $5pop10/ -population 10
  end=`date +%s`

  #echo -e Finished | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e MaxGenerations: $4 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e Project: $3 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e Execution Time: $((end-start)) | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo "----------------------------------------------------------------" >> $LOG
  echo $2, $4, 10, $((end-start)) >> $LOG

  #echo Running astor for $1 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  start=`date +%s`
  java -cp $(cat ./astor-classpath.txt):target/classes fr.inria.main.evolution.AstorMain -mode $1 -srcjavafolder /src/java/ -srctestfolder /src/test/ -binjavafolder /target/classes/ -bintestfolder /target/test-classes/ -location $2 -dependencies $3 -maxgen $4 -out $5pop20/ -population 20
  end=`date +%s`

  #echo -e Finished | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e MaxGenerations: $4 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e Project: $3 | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo -e Execution Time: $((end-start)) | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
  #echo "----------------------------------------------------------------" >> $LOG
  echo $2, $4, 20, $((end-start)) >> $LOG
}

# $1: location
function runjgenprog {
  runAstor "jgenprog" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 50 "./output_astor/$2gen-50/jgenprog/"
  #runAstor "jgenprog" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 100 "./output_astor/$2gen-100/jgenprog/"
  #runAstor "jgenprog" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 200 "./output_astor/$2gen-200/jgenprog/"
}
function runjmutrepair {
  runAstor "jmutrepair" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 50 "./output_astor/$2gen-50/jmutrepair/"
  #runAstor "jmutrepair" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 100 "./output_astor/$2gen-100/jmutrepair/"
  #runAstor "jmutrepair" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 200 "./output_astor/$2gen-200/jmutrepair/"
}
function runjkali {
  runAstor "jkali" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 50 "./output_astor/$2gen-50/jkali/"
  #runAstor "jkali" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 100 "./output_astor/$2gen-100/jkali/"
  #runAstor "jkali" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 200 "./output_astor/$2gen-200/jkali/"
}
function runcardumen {
  runAstor "cardumen" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 50 "./output_astor/$2gen-50/cardumen/"
  #runAstor "cardumen" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 100 "./output_astor/$2gen-100/cardumen/"
  #runAstor "cardumen" "$ASTOR_PATH/$1" "$ASTOR_PATH/$1lib" 200 "./output_astor/$2gen-200/cardumen/"
}

echo -e STARTING NEW BATCH REPAIR | ts '[%Y-%m-%d %H:%M:%S]' >> $LOG
echo "----------------------------------------------------------------" >> $LOG

# Run grouped directories
for PROJ in $( ls "./examples/testMultiMet/" )
	do
	  if [[ -f "examples/testMultiMet/$PROJ/pom.xml" ]]; then
      runjgenprog "examples/testMultiMet/$PROJ" "testMultiMet/$PROJ"
      #runjmutrepair "examples/testMultiMet/$PROJ" "testMultiMet/$PROJ"
      #runjkali "examples/testMultiMet/$PROJ" "testMultiMet/$PROJ"
      #runcardumen "examples/testMultiMet/$PROJ" "testMultiMet/$PROJ"
    fi
	done

for PROJ in $( ls "./examples/testMet/" )
	do
	  if [[ -f "examples/testMet/$PROJ/pom.xml" ]]; then
      runjgenprog "examples/testMet/$PROJ" "testMet/$PROJ"
      #runjmutrepair "examples/testMet/$PROJ" "testMet/$PROJ"
      #runjkali "examples/testMet/$PROJ" "testMet/$PROJ"
      #runcardumen "examples/testMet/$PROJ" "testMet/$PROJ"
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
                      "lang_7/"
                      )
for i in "${EXAMPLES[@]}"
  do
      runjgenprog "examples/$i" $i
      #runjmutrepair "examples/$i" $i
      #runjkali "examples/$i" $i
      #runcardumen "examples/$i" $i
  done

echo "----------------------------------------------------------------" >> $LOG
echo FINISHED RUNNING BATCH REPAIR >> $LOG

exit 0;
