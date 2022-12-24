601,100
602,"zSystem-Subset-Create-from-Dimension"
562,"SUBSET"
586,"Department:Department"
585,"Department:Department"
564,
565,"fS;e;0aal4Rv7n=hjO[^shJ>8H0dO@0do^ZpFESK70?lCgn=[WpV:0E^wwutw`Y@bj@lfaHB^1QCYRtksRLiu[iJQTE=VDCau4\f9T0ufmEThI92EvQVt^jW@SmTrtbis]:=bgyHs4l@xix?aQIEJk[P\b`B=LTzo5HUfV8WZoR<L]RYfdk[jS[dRw_IMOP<9p@=Gt6D"
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
571,All
569,0
592,0
599,1000
560,2
parBaseDim
parTargetDim
561,2
2
2
590,2
parBaseDim,""
parTargetDim,""
637,2
parBaseDim,"Enter Base Dimension:"
parTargetDim,"Enter Target Dimension:"
577,1
vElement
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,90
#****Begin: Generated Statements***
#****End: Generated Statements****
#########################################################################
# OPEN LOG: START
#########################################################################
timeStart = NOW; strFormat = '\M \d \Y \h:\i:\s';
numLine = 1; numRecordCount = 0;
NumericGlobalVariable( 'MetadataMinorErrorCount' ); NumericGlobalVariable( 'DataMinorErrorCount' );
MetadataMinorErrorCount = 0; DataMinorErrorCount = 0;
strEndMessage = 'Process Completed Successfully';

procName = GetProcessName();
cubeProcessLog = 'zSystem-TI-Log';

# TI Log Process
ExecuteProcess( 'zSystem-TI-Log-RollOver', 'parProcessName', procName );

strParameters = 'parBaseDim,parTargetDim';
WHILE( LONG( strParameters ) > 0 );
	numComma = SCAN( ',', strParameters | ',' );
	parCurrent = SUBST( strParameters, 1, numComma - 1 );
	strParameters = DELET( strParameters, 1, numComma );
	
	IF( Expand( '%' | parCurrent | '%' ) @<> '' );
		strMessage = parCurrent | ': ' | Expand( '%' | parCurrent | '%' );
		CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
		cubeProcessLog, procName, '1', NumberToString( numLine ) );
		numLine = numLine + 1;
	ENDIF;
END;
#########################################################################
# OPEN PROFILE: END
#########################################################################
TRUE = 1; FALSE = 0;
#****Begin: Generated Statements***
#****End: Generated Statements****

########################### DEFINE CONSTANTS ##############################

IF( parBaseDim @= '' );
	sBaseDim = 'Company';
ELSE;
	sBaseDim = parBaseDim;
ENDIF;

sSubsetPrefix = '}z' | sBaseDim | '_';

IF( parTargetDim @= '' );
	sTargetDim = 'Division';
ELSE;
	sTargetDim = parTargetDim;
ENDIF;

sSourceDim =  sBaseDim | '-' | sTargetDim;

sParameterCube = 'zSystem-Server-Parameter';
sDebugFilePath = CELLGETS( sParameterCube, 'Debug Directory', 'string' ) | sTargetDim | ' subset-create.csv';

subSource = GetProcessName | TIMST( NOW, '\Y\m\d\h\i\s' ) | NumberToString( RAND() * 1000000000 );
viewSource = subSource;


############## REMOVE CURRENT CLIENT SUBSETS FOR EACH COMPANY ##############
nElCount = DIMSIZ( sBaseDim );
n = 1;
WHILE ( n <= nElCount );
	sElement = DIMNM( sBaseDim, n );
	IF ( DTYPE( sBaseDim, sElement ) @= 'N' );
		sSubsetName = sSubsetPrefix | sElement;
		IF ( SubsetExists( sTargetDim, sSubsetName ) = 1 );
			SubsetDeleteAllElements( sTargetDim, sSubsetName );
			#SubsetDestroy( sTargetDim, sSubsetName );
		ENDIF;
	ENDIF;
	n = n + 1;
END;

#########################################################################
# BUILD SUBSETS FOR DIMENSION COPYING
#########################################################################

SubsetCreatebyMDX( subSource, '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sBaseDim | '] )}, 0 )}' );
SubsetMDXSet( sBaseDim, subSource, '' );

# Update Datasource
DatasourceNameForServer = sBaseDim;
DatasourceNameForClient = sBaseDim;
DataSourceType = 'SUBSET';
DatasourceDimensionSubset = subSource;

573,3
#****Begin: Generated Statements***
#****End: Generated Statements****

574,57
#****Begin: Generated Statements***
#****End: Generated Statements****
IF( Dimix( sSourceDim, vElement ) = 0 );
	ITEMSKIP;
ELSE;
	IF( SCAN( '\', vELEMENT ) >0 % SCAN( '/', vELEMENT ) >0 % SCAN( ',', vELEMENT ) >0 );
		ITEMSKIP;
	ENDIF;
	sSubsetName = sSubsetPrefix | vElement;
	sMDX = '{TM1SORT( {[' | sSourceDim | '].[' | vElement | '].Children }, ASC)}';
	SubsetCreatebyMDX( subSource, sMDX );
	SubsetMDXSet( sSourceDim, subSource, '' );

	nSubSize = SubsetGetSize( sSourceDim, subSource );
	n = 1;
	WHILE ( n <= nSubSize );
		sElement = SubsetGetElementName( sSourceDim, subSource, n );
		nIsDup = Scan( 'Dup_', sElement);
		IF( nIsDup > 0 );
			nLong = Long( sElement);
			sElement = Subst( sElement, 5, nLong ); 
		ENDIF;
		asciioutput( sDebugFilePath, sBaseDim, sSubsetName, vElement, sElement, NumbertoString( nSubSize) );
		IF ( SubsetExists( sTargetDim, sSubsetName ) = 0 );
			SubsetCreate( sTargetDim, sSubsetName );
			sAlias = 'Code-Description';
			IF ( DIMIX ('}ElementAttributes_' | sTargetDim, sAlias ) > 0 );
				SubsetAliasSet( sTargetDim, sSubsetName, sAlias );
			ENDIF;
			nPosition = 1;
		ELSE;
			nPosition = SubsetGetSize( sTargetDim, sSubsetName ) + 1;
		ENDIF;
		nExists = SubsetElementExists( sTargetDim, sSubsetName, sElement );
		IF( nExists = 0 );
			SubsetElementInsert( sTargetDim, sSubsetName, sElement, nPosition );
		ENDIF;
		n = n + 1;
	END;

		########### INSERT Top Element ELEMENT INTO ALL SUBSETS ##########
		SubsetElementInsert( sTargetDim, sSubsetName, 'All ' | sTargetDim, 1 );

		########### INSERT BZDV INTO Client SUBSETS ##########
# 		sElement = 'BZDV';
# 		IF( sTargetDim @= 'Client' );	
# 			nExists = SubsetElementExists( sTargetDim, sSubsetName, sElement );
# 			IF( nExists = 0 );
# 				SubsetElementInsert( sTargetDim, sSubsetName, sElement, 2 );
# 			ENDIF;
# 		ENDIF;

	IF( SubsetExists( sSourceDim, subSource ) = 1 ); 
    	SubsetDestroy( sSourceDim, subSource ); 
    ENDIF;

ENDIF;
575,40
#****Begin: Generated Statements***
#****End: Generated Statements****

IF( SubsetExists( sBaseDim, subSource ) = 1 ); 
	SubsetDestroy( sBaseDim, subSource ); 
ENDIF;




# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#########################################################################
# CLOSE PROFILE: START
#########################################################################
# Number of Data Errors
IF( DataMinorErrorCount > 0 );
	strMessage = 'Data Error Count = ' | NumberToString( DataMinorErrorCount );
	CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
	cubeProcessLog, procName, '1', 'Data Error Count' );
	strEndMessage = 'Process Completed with Errors';
ENDIF;

# Number of Records Processed
IF( numRecordCount > 0 );
	strMessage = 'Records Processed = ' | NumberToString( numRecordCount );
	CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
	cubeProcessLog, procName, '1', 'Records Processed' );
ENDIF;

# Calculate Runtime
strMessage = 'Total Runtime = ' | TIMST( NOW - timeStart, '\hh:\im:\ss' );
CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
cubeProcessLog, procName, '1', 'Runtime' );

CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strEndMessage,
cubeProcessLog, procName, '1', 'Completed' );
#########################################################################
# CLOSE PROFILE: END
#########################################################################

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
