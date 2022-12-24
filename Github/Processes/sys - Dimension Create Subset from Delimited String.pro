601,100
602,"sys - Dimension Create Subset from Delimited String"
562,"NULL"
586,
585,
564,
565,"aapUI`tEu:qW08n6_D4RHy@?<rvG5XFQxmtwelS4v>wkx=WTs5Zw5s?]1Jg1:G\=m3FXuQN9q;AxketAkORK3Zan1phmEC_Lz^U62w2Uy4yWDvKIx_=rL4G4RnWw;Q:y5O;Nz_O^^BF0IuSwfyJEoq3]o[hkGAnrzeJNS6Xpodc]w1RzKBVP9kNRqEgcSv?a@e1>P9Q:"
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
560,9
pDimension
pSubset
pString
pDelimiter
pUseAlias
pAliasName
P6
P7
P8
561,9
2
2
2
2
2
2
2
1
1
590,9
pDimension,""
pSubset,""
pString,""
pDelimiter,"+"
pUseAlias,"No"
pAliasName,""
P6,""
P7,0
P8,0
637,9
pDimension,"Dimension Name:"
pSubset,"Subset Name:"
pString,"Delimited String:"
pDelimiter,"Delimited Character:"
pUseAlias,"Use Alias (Yes/No):"
pAliasName,"Alias Name:"
P6,""
P7,""
P8,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,32
#****Begin: Generated Statements***
#****End: Generated Statements****

#--------------- Variables ---------------#
nDelimIndex = 1;
sElems = pString;

IF(HierarchySubsetExists(pDimension, pDimension, pSubset) = 1);
	HierarchySubsetDeleteAllElements(pDimension, pDimension, pSubset);
ELSE;
	HierarchySubsetCreate(pDimension, pDimension, pSubset, 0);
ENDIF;

WHILE(nDelimIndex <> 0 & LONG(sElems) > 0);
	nDelimIndex = SCAN(pDelimiter, sElems);
    IF(nDelimIndex <> 0);
    	sElem = TRIM(SUBST(sElems, 1, nDelimIndex - 1));
        sElems = TRIM(SUBST(sElems, nDelimIndex + LONG(pDelimiter), LONG(sElems)));
    ELSE;
    	sElem = TRIM(sElems);
    ENDIF;
    
    HierarchySubsetElementInsert(pDimension, pDimension, pSubset, sElem, HierarchySubsetGetSize(pDimension, pDimension, pSubset) + 1);
    
    IF(pUseAlias @= 'Yes');
    	HierarchySubsetAliasSet(pDimension, pDimension, pSubset, pAliasName);
    ENDIF;
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

576,_ParameterConstraints=e30=
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
