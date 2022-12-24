601,100
602,"zSystem-TI-Log-Rollover"
562,"VIEW"
586,"zSystem-TI-Log"
585,"zSystem-TI-Log"
564,
565,"zbN0if3o;Q7J:N_V7NKdK1AZqQaj<?5z6@I<0V:cg@]Y:lk41cvPf>Ux`w3Xd]_PHEqed7Dv9qnMmg5dJ8b[m=pNqJkwI`m@ztetawpNLx8Fi?e?xEYx1Yt4JQa`CNq[eVr_P5UueYIUJz9@hx4ffBjiukGBm`ex2H2:Vh7dCEfK;_\r3nzEZn\HWxIK]Xwr^:X9DW]t"
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
parProcessName
561,1
2
590,1
parProcessName,""
637,1
parProcessName,"Enter Process Name:"
577,7
varProcess
varRun
varLine
Value
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
572,69

#****Begin: Generated Statements***
#****End: Generated Statements****

sClientsDim = '}Clients';
sUser = TM1USER();

IF( Dimix( '}Clients', sUser ) = 0 );
	strClient = Subst( sUser, 3, Long( sUser) -3 );
ELSE;
	strClient = Subst( ATTRS( '}Clients', sUser, '}TM1_DefaultDisplayValue' ), 20, 50 );
ENDIF;

# Initializations
TRUE = 1; FALSE = 0;
cubeSource = 'zSystem-TI-Log';
subSource = GetProcessName | ' ' | strClient | ' ' | TIMST( NOW, '\Y\m\d\h\i\s' ) | NumberToString( RAND() * 1000000000 );
viewSource = subSource;

dimProcess = 'zSystem-TI-Process';
dimRun = 'zSystem-TI-Run';

IF( CubeGetLogChanges( cubeSource ) = TRUE );
	CubeSetLogChanges( cubeSource, FALSE );
ENDIF;

IF( DIMIX( dimProcess, parProcessName ) = 0 );
	DimensionElementInsertDirect( dimProcess, '', parProcessName, 'N' );
#	DimensionElementInsert( dimProcess, '', parProcessName, 'N' );
ENDIF;

#########################################################################
# BUILD SUBSETS FOR DIMENSION COPYING
#########################################################################
SubsetCreate( dimProcess, subSource );
SubsetElementInsert( dimProcess, subSource, parProcessName, 1 );

#########################################################################
# BUILD DATA COPY VIEW
#########################################################################
ViewCreate( cubeSource, viewSource );

# Setup View
numIndex = 1;
WHILE( TABDIM( cubeSource, numIndex ) @<> '' );
	dimCurrent = TABDIM( cubeSource, numIndex );
	IF( SubsetExists( dimCurrent, subSource ) = FALSE );
		strMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | dimCurrent | '] )}, 0 )}';
		SubsetCreatebyMDX( subSource, strMDX );
		SubsetMDXSet( dimCurrent, subSource, '' );
	ENDIF;
	ViewSubsetAssign( cubeSource, viewSource, dimCurrent, subSource );
	ViewRowDimensionSet( cubeSource, viewSource, dimCurrent, numIndex );
numIndex = numIndex + 1;
END;

# Set View Properties
ViewExtractSkipZeroesSet( cubeSource, viewSource, 0 );
ViewExtractSkipCalcsSet( cubeSource, viewSource, 1 );
ViewExtractSkipRuleValuesSet( cubeSource, viewSource, 1 );

numLogging = CubeGetLogChanges( cubeSource );
CubeSetLogChanges( cubeSource, 0 );

# Update Datasource
DatasourceNameForServer = cubeSource;
DatasourceCubeView = viewSource;


573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,11

#****Begin: Generated Statements***
#****End: Generated Statements****

# Skip final run to avoid errors
# The runs dimension is setup Upside Down with the oldest run as the first element. 
# This is because of how TM1 processes views, using the dimension order and not the Subset order.
IF( varRun @= '25'); ITEMSKIP; ENDIF;

CellPutS( Value, cubeSource, varProcess, NumberToString( StringToNumber( varRun ) + 1 ), varLine );
CellPutS( '', cubeSource, varProcess, varRun, varLine );
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****

DimensionUpdateDirect( dimProcess );

CubeSetLogChanges( cubeSource, numLogging );
CubeSaveData( cubeSource );

strFormat = '\M \d \Y \h:\i:\s';

strMessage = 'Process Started';
CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( 0, '\hh:\im:\ss' ) | ']  ' | strMessage,
cubeSource, parProcessName, '1', 'Started' );

strUser = TM1User();
IF( Dimix( '}Clients', strUser) = 0 );
	strMessage = strUser;
ELSE;
	strClient = ATTRS( '}Clients', strUser, '}TM1_DefaultDisplayValue' );
	strMessage = Subst( strClient, 20, 50 );
ENDIF;
CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( 0, '\hh:\im:\ss' ) | ']  ' | strMessage,
cubeSource, parProcessName, '1', 'Run By' );

# Cleanup
IF( ViewExists( cubeSource, viewSource ) = 1 ); ViewDestroy( cubeSource, viewSource ); ENDIF;

numIndex = 1;
WHILE( TABDIM( cubeSource, numIndex ) @<> '' );
	dimCurrent = TABDIM( cubeSource, numIndex );
	IF( SubsetExists( dimCurrent, subSource ) = 1 ); SubsetDestroy( dimCurrent, subSource ); ENDIF;
numIndex = numIndex + 1;
END;

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
