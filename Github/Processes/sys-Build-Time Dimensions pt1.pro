601,100
602,"sys-Build-Time Dimensions pt1"
562,"CHARACTERDELIMITED"
586,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\Month.csv"
585,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\Month.csv"
564,
565,"hEK^yHehaGHc[yGvoG1pO8kVCpiyK9HX^x9fXeA8NwX<[BIcJLW1:2f9@hNrsLX0_@?O@PW9G84?MtzdtYU4KsViObu5<UiRvg9WlTMUl_juS0SLX0U8lQTBR8JgaHDyo1=qtJCgJS1=[BtppwmIT;6k?szJCtu6uc3SgAdC1CAI7;wcqV^goahwuzWnC507qhM:R3aL"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,","
568,""""
570,
571,
569,1
592,0
599,1000
560,0
561,0
590,0
637,0
577,6
vElement
vShort
vLong
vQuarter
vPrior
vNext
578,6
2
2
2
2
2
2
579,6
1
2
3
4
5
6
580,6
0
0
0
0
0
0
581,6
0
0
0
0
0
0
582,6
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,89

#****Begin: Generated Statements***
#****End: Generated Statements****


#################################
# Creates Year Dimension
#################################
sYearDim = 'Year';
IF(DimensionExists(sYearDim)=1);
    DimensionDestroy(sYearDim);
    DimensionCreate(sYearDim);
    DimensionElementInsert(sYearDim,'','All Years','N');
ELSE;
    DimensionCreate(sYearDim); 
    DimensionElementInsert(sYearDim,'','All Years','N');
ENDIF;

BeginningYear = 2003;
EnddingYear = 2005;

WHILE(BeginningYear <= EnddingYear);
	sYear = NumberToString(BeginningYear); 
	DimensionElementComponentAdd(sYearDim, 'All Years', sYear, 1); 
	BeginningYear = BeginningYear + 1;
END;

#################################
# Creates Day Dimension
#################################
sDayDim = 'Day';
IF(DimensionExists(sDayDim)=1);
    DimensionDestroy(sDayDim);
    DimensionCreate(sDayDim);
    DimensionElementInsert(sDayDim,'','All Days','N');
ELSE;
    DimensionCreate(sDayDim); 
    DimensionElementInsert(sDayDim,'','All Days','N');
ENDIF;

nLoop = 1;
nMax = 31;

WHILE(nLoop <= nMax);
	IF(nLoop < 10);
		sElement = '0'| NumberToString(nLoop); 
	ELSE;
		sElement = NumberToString(nLoop); 
	ENDIF;
	DimensionElementComponentAdd(sDayDim, 'All Days', sElement,1); 
	nLoop = nLoop +1;
END;

#################################
# Creates Month Dimension
#################################
sMonthDim = 'Month';
IF(DimensionExists(sMonthDim)=1);
    DimensionDestroy(sMonthDim);
    DimensionCreate(sMonthDim);
    DimensionElementInsert(sMonthDim, '', 'Total Year', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q1', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q2', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q3', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q4', 'C');
    DimensionElementInsert(sMonthDim, '', 'YTDs', 'C');
    #DimensionElementInsert(sMonthDim, '', 'QTDs', 'C');

ELSE;
    DimensionCreate(sMonthDim); 
    DimensionElementInsert(sMonthDim, '', 'Total Year', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q1', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q2', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q3', 'C');
    DimensionElementInsert(sMonthDim, '', 'Q4', 'C');
    DimensionElementInsert(sMonthDim, '', 'YTDs', 'C');
    #DimensionElementInsert(sMonthDim, '', 'QTDs', 'C');
ENDIF;

##############
ATTRINSERT(sMonthDim, '', 'Short Name', 'S');
ATTRINSERT(sMonthDim, '', 'Full Name', 'S');
ATTRINSERT(sMonthDim, '', 'Previous Month', 'S');
ATTRINSERT(sMonthDim, '', 'Next Month', 'S');
ATTRINSERT(sMonthDim, '', 'Quarter', 'S');




573,5

#****Begin: Generated Statements***
#****End: Generated Statements****

DimensionElementInsert(sMonthDim, '', vElement, 'N');
574,10

#****Begin: Generated Statements***
#****End: Generated Statements****


ATTRPUTS(vShort, sMonthDim,vElement,'Short Name');
ATTRPUTS(vLong, sMonthDim,vElement,'Full Name');
ATTRPUTS(vPrior, sMonthDim,vElement,'Previous Month');
ATTRPUTS(vNext, sMonthDim,vElement,'Next Month');
ATTRPUTS(vQuarter, sMonthDim,vElement,'Quarter');
575,11

#****Begin: Generated Statements***
#****End: Generated Statements****


ExecuteProcess('sys-Build-Time Dimensions pt2'); 





576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
