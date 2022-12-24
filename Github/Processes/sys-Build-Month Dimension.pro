601,100
602,"sys-Build-Month Dimension"
562,"NULL"
586,
585,
564,
565,"yjt9\Wt`MZ`9BFnkmuz@ZOVadaFaRvjFQX[Fa[xXR9@4J@UZUqzlKn^:MxLCO5YscQ=ZDvnz`^E5O<0ukYgYwI:YQ;?`wz3d9K4ttZZV:EBCH5oMqGq@9E24CGicOV2=OmlU4Dkt[f1Ll^VbV;p<r@U2?EoX63WM[IhgcQA@Z9MCNGyIfuR5pB>JfZFzm@^?vNDKRo@8"
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
569,0
592,0
599,1000
560,0
561,0
590,0
637,0
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,65

#****Begin: Generated Statements***
#****End: Generated Statements****


############
# Creates Time Dimensions
############
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

######
######

sMonthDim = 'Month';
IF(DimensionExists(sMonthDim)=1);
    DimensionDestroy(sMonthDim);
    DimensionCreate(sMonthDim);
    DimensionElementInsert(sMonthDim, '', 'Total Year', 'C');
    DimensionElementInsert(sMonthDim, '', 'YTDs', 'C');
    DimensionElementInsert(sMonthDim, '', 'QTDs', 'C');
ELSE;
    DimensionCreate(sMonthDim); 
    DimensionElementInsert(sMonthDim, '', 'Total Year', 'C');
    DimensionElementInsert(sMonthDim, '', 'YTDs', 'C');
    DimensionElementInsert(sMonthDim, '', 'QTDs', 'C');
ENDIF;

nLoop = 1;
nMax = 12;

WHILE(nLoop <= nMax); 
	IF(nLoop <= 9);
		sMonth = '0' | NumberToString(nLoop);
	ELSE;
		sMonth = NumberToString(nLoop);
	ENDIF;
	DimensionElementInsert(sMonthDim, '', sMonth, 'N');
	nLoop = nLoop +1;
END;
##############
ATTRINSERT(sMonthDim, '', 'Short Name', 'S');
ATTRINSERT(sMonthDim, '', 'Full Name', 'S');
ATTRINSERT(sMonthDim, '', 'Previous Month', 'N');
ATTRINSERT(sMonthDim, '', 'Next Month', 'S');




573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,50

#****Begin: Generated Statements***
#****End: Generated Statements****


#####
ATTRPUTS('Jan', sMonthDim, '01','Short Name');
ATTRPUTS('Feb', sMonthDim, '02','Short Name');
ATTRPUTS('Mar', sMonthDim, '03','Short Name');
ATTRPUTS('Apr', sMonthDim, '04','Short Name');
ATTRPUTS('May', sMonthDim, '05','Short Name');
ATTRPUTS('Jun', sMonthDim, '06','Short Name');
ATTRPUTS('Jul', sMonthDim, '07','Short Name');
ATTRPUTS('Aug', sMonthDim, '08','Short Name');
ATTRPUTS('Sep', sMonthDim, '09','Short Name');
ATTRPUTS('Oct', sMonthDim, '10','Short Name');
ATTRPUTS('Nov', sMonthDim, '11','Short Name');
ATTRPUTS('Dec', sMonthDim, '12','Short Name');
######
ATTRPUTS('January', sMonthDim, '01','Full Name');
ATTRPUTS('February', sMonthDim, '02','Full Name');
ATTRPUTS('March', sMonthDim, '03','Full Name');
ATTRPUTS('April', sMonthDim, '04','Full Name');
ATTRPUTS('May', sMonthDim, '05','Full Name');
ATTRPUTS('June', sMonthDim, '06','Full Name');
ATTRPUTS('July', sMonthDim, '07','Full Name');
ATTRPUTS('August', sMonthDim, '08','Full Name');
ATTRPUTS('September', sMonthDim, '09','Full Name');
ATTRPUTS('October', sMonthDim, '10','Full Name');
ATTRPUTS('November', sMonthDim, '11','Full Name');
ATTRPUTS('December', sMonthDim, '12','Full Name');
################



nSize = DIMSIZ(sMonthDim); 
nLoop = 1;

WHILE(nLoop <= nSize);
	sElement = DIMNM(sMonthDim, nLoop);
	IF(ELLEV(sMonthDim, sElement)=0);
		sYTD = ATTRS(sMonthDim, sElement, 'Short Name') | ' YTD';
		sQTD = ATTRS(sMonthDim, sElement, 'Short Name') | ' QTD';
		DimensionElementComponentAdd(sMonthDim, 'YTDs', sYTD, 1);
		DimensionElementComponentAdd(sMonthDim, 'QTDs', sQTD, 1);
		ASCIIOutput('text.txt', sQTD);
	ENDIF;
	nLoop = nLoop +1;
END;

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
