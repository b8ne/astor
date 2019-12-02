#!/bin/bash


EXPORT="batch_results-50_gen_all_modes.csv"

echo PROJECT,GENERATIONS,VARIANTS,SOLUTIONS >> $EXPORT
VARIANTS=0
SOLUTIONS=0

# Run grouped directories
for PROJ in $( ls "./examples/testMultiMet/" )
	do
	  if [[ -f "examples/testMultiMet/$PROJ/pom.xml" ]]; then
	  	{
		    VARIANTS=$(find ./output_astor/testMultiMet/$PROJ'gen-50'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMultiMet/$PROJ'gen-50'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,50,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/testMultiMet/$PROJ'gen-100'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMultiMet/$PROJ'gen-100'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,100,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/testMultiMet/$PROJ'gen-200'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMultiMet/$PROJ'gen-200'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,200,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
    fi
	done

for PROJ in $( ls "./examples/testMet/" )
	do
	  if [[ -f "examples/testMet/$PROJ/pom.xml" ]]; then
       {
		    VARIANTS=$(find ./output_astor/testMet/$PROJ'gen-50'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMet/$PROJ'gen-50'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,50,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/testMet/$PROJ'gen-100'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMet/$PROJ'gen-100'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,100,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/testMet/$PROJ'gen-200'/jgenprog/AstorMain-$PROJ/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/testMet/$PROJ'gen-200'/jgenprog/AstorMain-$PROJ/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,200,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
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
	    {
		    VARIANTS=$(find ./output_astor/$i'gen-50'/jgenprog/AstorMain-$i/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/$i'gen-50'/jgenprog/AstorMain-$i/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,50,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/$i'gen-100'/jgenprog/AstorMain-$i/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/$i'gen-100'/jgenprog/AstorMain-$i/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,100,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	  	{
		    VARIANTS=$(find ./output_astor/$i'gen-200'/jgenprog/AstorMain-$i/bin/ -type d -name "variant*" | wc -l)
		    SOLUTIONS=$(find ./output_astor/$i'gen-200'/jgenprog/AstorMain-$i/src/ -type d -name "variant*_f" | wc -l)
		    echo $PROJ,200,$VARIANTS,$SOLUTIONS >> $EXPORT
	  	}
	done