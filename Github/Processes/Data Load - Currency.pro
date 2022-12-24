601,100
602,"Data Load - Currency"
562,"CHARACTERDELIMITED"
586,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\Currency.csv"
585,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\Currency.csv"
564,
565,"gd]juYqarIqJ1SjO3vUkcojcoU:zhxiOPYc5][PNO[78CEO5NL2lB7I3`lXx=JRF2`=TPWhP<MRu6NtEVktI;x\xHaV<rJ3pDmYgbJb_JuLYhz[iIIzfBz<:A2WaVNH9dbfOBFHlX\yaM4oTO6Cf<\POhHS3uR95KHefBHGSEQ]L1[^_wgcmWx:VEy;cFtDGguRNEJl?"
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
577,12
vDate
vDay
vMonth
vYear
USD
EURO
CAD
GBP
JPY
AUD
PHP
SGA
578,12
2
2
2
2
1
1
1
1
1
1
1
1
579,12
1
2
3
4
5
6
7
8
9
10
11
12
580,12
0
0
0
0
0
0
0
0
0
0
0
0
581,12
0
0
0
0
0
0
0
0
0
0
0
0
582,12
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
603,0
572,24

#****Begin: Generated Statements***
#****End: Generated Statements****

sCurrencyDim = 'Currency'; 
IF(DimensionExists(sCurrencyDim)=0);
	DimensionCreate(sCurrencyDim);
	DimensionElementInsert(sCurrencyDim, '', 'USD','N');
	DimensionElementInsert(sCurrencyDim, '', 'CAD','N');
	DimensionElementInsert(sCurrencyDim, '', 'EURO','N');
	DimensionElementInsert(sCurrencyDim, '', 'GBP','N');
	DimensionElementInsert(sCurrencyDim, '', 'JPY','N');
	DimensionElementInsert(sCurrencyDim, '', 'AUD','N');
	DimensionElementInsert(sCurrencyDim, '', 'PHP','N');
	DimensionElementInsert(sCurrencyDim, '', 'SGA','N');
	DimensionElementInsert(sCurrencyDim, '', 'LCY','N');
ENDIF;

vCube = 'Currency';
IF(CubeExists(vCube)=1);
	CubeDestroy(vCube); 
ENDIF;
CubeCreate(vCube, 'Scenario', 'Version', 'Year','Month','Day','Currency'); 

573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,19

#****Begin: Generated Statements***
#****End: Generated Statements****

IF(StringToNumber(vDay) <10);
	vDay ='0'|vDay;
ENDIF;
IF(StringToNumber(vMonth) <10);
	vMonth = '0'|vMonth;
ENDIF; 

CELLPUTN(USD, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'USD');
CELLPUTN(EURO, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'EURO');
CELLPUTN(CAD, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'CAD');
CELLPUTN(GBP, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'GBP');
CELLPUTN(JPY, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'JPY');
CELLPUTN(AUD, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'AUD');
CELLPUTN(PHP, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'PHP');
CELLPUTN(SGA, vCube, 'Current', 'Actual', vYear, vMonth, vDay, 'SGA');
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
