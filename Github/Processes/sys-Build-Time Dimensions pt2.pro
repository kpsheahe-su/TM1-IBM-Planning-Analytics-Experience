601,100
602,"sys-Build-Time Dimensions pt2"
562,"NULL"
586,
585,
564,
565,"i^H67oUt=am_BlXmoRkb9JnMAmA59lS\Zwyp67<OlWSJO:Qoj5]p<dy=:3]T`HJe[hlNmVIIGsYdGRrNs[SaTM?yDOC]H1rqy<>G=]wU\:8Dl;gtZF`?m@wgM5lEKs0xodGV?r3HMdTdVmz;;\T_7<JfJSSGQk\c]>i=S4NZc=awu:pTWCVzE?];>KHfdok=I`[li`Un"
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
572,84

#****Begin: Generated Statements***
#****End: Generated Statements****

####
# Insert YTDS and QTDS
####
sMonthDim = 'Month';
nSize = DIMSIZ(sMonthDim); 
nLoop = 1;
WHILE(nLoop <= nSize);
	sElement = DIMNM(sMonthDim, nLoop);
	IF(ELLEV(sMonthDim, sElement)=0);
		sYTD = ATTRS(sMonthDim, sElement, 'Short Name') | ' YTD';
		#sQTD = ATTRS(sMonthDim, sElement, 'Short Name') | ' QTD';
		#DimensionElementInsert(sMonthDim, '', sQTD, 'C');
		DimensionElementInsert(sMonthDim, '', sYTD, 'C');
		DimensionElementComponentAdd(sMonthDim, 'YTDs', sYTD, 1);
		#DimensionElementComponentAdd(sMonthDim, 'QTDs', sQTD, 1);	
	ENDIF;
	nLoop = nLoop +1;
END;

####
# Insert Quarters in Total Year
####
n =1;
nmax = 4;
WHILE(n <= nmax);
	sElement = 'Q'|NumberToString(n);
	DimensionElementComponentAdd(sMonthDim, 'Total Year', sElement, 1);
	ncounter =1;
	WHILE(ncounter <= nSize);
		sChild = DIMNM(sMonthDim, ncounter); 
		nQuarter = StringToNumber(ATTRS(sMonthDim, sChild, 'Quarter'));
		IF(ELLEV(sMonthDim, sChild)=0 & n = nQuarter);
			DimensionElementComponentAdd(sMonthDim, sElement, sChild, 1); 
		ENDIF;
		ncounter = ncounter + 1;
	END;
	n = n+1;
END;


####
# Add appropriate YTD children
####
nLoop = 1;
WHILE(nLoop <= nSize);
	sElement = DIMNM(sMonthDim, nLoop);
	IF(ELLEV(sMonthDim, sElement)=0);
		sYTD = ATTRS(sMonthDim, sElement, 'Short Name') | ' YTD';	
		SecondLoop = nLoop;
		nCounter = 1;
		WHILE(nCounter <= SecondLoop );
			sMonth = dimnm(sMonthDim, nCounter);
			IF(ELLEV(sMonthDim,sMonth)=0);
				DimensionElementComponentAdd(sMonthDim, sYTD, sMonth, 1); 
			ENDIF;
			nCounter = nCounter+1; 
		END;	
	ENDIF;
	nLoop = nLoop +1;
END;




















573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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
