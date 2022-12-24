601,100
602,"sys - Dimension Create Subset from MDX"
562,"NULL"
586,
585,
564,
565,"swrvKTz<]y8RS7aP72UaouGnHqZ>0E_AU@8Fa^BX^54aPgOp@=g08U:?Sa1v_OAOY^vOnM\yt;f93[^`e`uc=?GCsAFpuL:M1]zv_xTg4bjJ9t^fLexE_?_m\VCOFIjsQ4bgip0[0QoIORt\4DKtw3PlHr0GPqBok=XOmyd_VzO6GA4Y]SG::5D[GOXcEl4I]3IotL@J"
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
560,6
pDimension
pSubset
pMDXExpr
pConvertToStatic
pUseAlias
pAliasName
561,6
2
2
2
2
2
2
590,6
pDimension,""
pSubset,""
pMDXExpr,""
pConvertToStatic,"Yes"
pUseAlias,"No"
pAliasName,""
637,6
pDimension,"Dimension Name:"
pSubset,"Subset Name:"
pMDXExpr,"MDX Expression:"
pConvertToStatic,"Convert to Static (Yes/No):"
pUseAlias,"Use Alias (Yes/No):"
pAliasName,"Alias Name:"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,25
#****Begin: Generated Statements***
#****End: Generated Statements****


IF(HierarchySubsetExists(pDimension, pDimension, pSubset) = 1);
	HierarchySubsetDeleteAllElements(pDimension, pDimension, pSubset);
ELSE;
	HierarchySubsetCreate(pDimension, pDimension, pSubset);
ENDIF;
HierarchySubsetMDXSet(pDimension, pDimension, pSubset, pMDXExpr);

IF(pConvertToStatic @= 'Yes');
	sElement = ELementName(pDimension, pDimension, 1);
    HierarchySubsetElementInsert(pDimension, pDimension, pSubset, sElement, 1);
    HierarchySubsetElementDelete(pDimension,  pDimension, pSubset, 1);
ENDIF;

IF(pUseAlias @= 'Yes');
	HierarchySubsetAliasSet(pDimension, pDimension, pSubset, pAliasName);
ENDIF;





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
