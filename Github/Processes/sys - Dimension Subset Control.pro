601,100
602,"sys - Dimension Subset Control"
562,"VIEW"
586,"sys - Subset Control"
585,"sys - Subset Control"
564,
565,"cB]a61F@^id7fQnzPA8\z^pLf\rOkH7hFsS_qKPsEc@5Pv]7WGnI@x2G;hEOlGFMTIuAvHQVz_hIs@ONBj]?L\pru0H<O^?oP0Jg<;vn`eMzDgfAoqebnlr=^ggWw0^@g3@cXNfJ3^\wbtwlTda_P;lAzOdP0nuG9=0`9aqz48e]\re7i\1I1eCR;8LnetqbqVlZlU=n"
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
570,View1
571,
569,0
592,0
599,1000
560,1
pDimension
561,1
2
590,1
pDimension,""
637,1
pDimension,"Dimension Name:"
577,7
vDimension
vLine
vMeasure
vValue
NVALUE
SVALUE
VALUE_IS_STRING
578,7
2
2
2
2
1
2
1
579,7
1
2
3
4
0
0
0
580,7
0
0
0
0
0
0
0
581,7
0
0
0
0
0
0
0
582,4
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,59

#****Begin: Generated Statements***
#****End: Generated Statements****

cCube = 'sys - Subset Control';
cTemp = 1;


sView = 'temp view';

IF(ViewExists(cCube, sView) = 1);
	ViewDestroy(cCube, sView);
ENDIF;

ViewCreate(cCube, sView, cTemp);
ViewExtractSkipZeroesSet(cCube, sView, 1);
ViewExtractSkipCalcsSet(cCube, sView, 1);
ViewExtractSkipRuleValuesSet(cCube, sView, 0);

nLoop = 1;
nMax = CubeDimensionCountGet(cCube);
WHILE(nLoop <= nMax);
	sDim = TABDIM(cCube, nLoop);
    
    IF(HierarchySubsetExists(sDim, sDim, sView) = 1);
    	HierarchySubsetDeleteAllElements(sDim, sDim, sView);
    ELSE;
    	HierarchySubsetCreate(sDim, sDim, sView, cTemp);
    ENDIF;
    
    IF(sDim @= '}Dimensions');
    	HierarchySubsetElementInsert(sDim, sDim, sView, pDimension, 1);
    ELSEIF(sDim @= 'sys - Subset Control');
    	HierarchySubsetElementInsert(sDim, sDim, sView, 'Subset Name', 1);
    ELSE;
    	nELem = 1;
        nElemMax = ElementCount(sDim, sDim);
        WHILE(nElem <= nElemMax);
        	sElement = ElementName(sDim, sDim, nElem);
            IF(ElementLevel(sDim, sDim, sElement) = 0);
            	HierarchySubsetElementInsert(sDim, sDim, sView, sElement, 0);
            ENDIF;
            nELem = nElem + 1;
        END;
    ENDIF;
    
    ViewSubsetAssign(cCube, sView, sDim, sView);
    nLoop = nLoop + 1;
END;
    
#----- Assign View to Process
DatasourceType = 'VIEW';
DatasourceNameForServer = cCube;
DatasourceCubeView = sView;





573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,37

#****Begin: Generated Statements***
#****End: Generated Statements****


#--------------- Variables ---------------#
sActive = CellGetS(cCube, pDimension, vLine, 'Active');
sAlias = CellGetS(cCube, pDimension, vLine, 'Alias Attribute');
sStaticFlag = CellGetS(cCube, pDimension, vLine, 'String or MDX');
sSubsetExpr = CellGetS(cCube, pDimension, vLine,'Subset Expression');
sConvert = CellGetS(cCube, pDimension, vLine,'Make Static');
sUseAlias = CellGetS(cCube, pDimension, vLine,'Use Alias');


IF(sActive @= 'Yes');
    IF(sStaticFlag @= 'String');
        ExecuteProcess('sys - Dimension Create Subset from Delimited String'
            , 'pDimension', pDimension
            , 'pSubset', vValue
            , 'pString', sSubsetExpr
            , 'pDelimiter', '+'
            , 'pUseAlias', sUseAlias
            , 'pAliasName', sAlias);
    ELSE;
    	ASCIIOutput('sAlias.txt', sActive, sAlias, sStaticFlag, sSubsetExpr, sConvert, sUseAlias, pDimension, vValue);
        iReturn = ExecuteProcess('sys - Dimension Create Subset from MDX'
            , 'pDimension', pDimension
            , 'pSubset', vValue
            , 'pMDXExpr', sSubsetExpr
            , 'pConvertToStatic', sConvert
            , 'pUseAlias', sUseAlias
            , 'pAliasName', sAlias);
        If(iReturn <> 0); 
	ASCIIOutput(pDimension | '_Debug.txt', sActive, sAlias, sStaticFlag, sSubsetExpr, sConvert, sUseAlias, pDimension, vValue);
        EndIf;
    ENDIF;
ENDIF;
575,4

#****Begin: Generated Statements***
#****End: Generated Statements****

576,CubeAction=1511DataAction=1503CubeLogChanges=0_ParameterConstraints=e30
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
