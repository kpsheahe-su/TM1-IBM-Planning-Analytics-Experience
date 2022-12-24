601,100
602,"zSystem-Cube-DataClear"
562,"NULL"
586,
585,
564,
565,"l\40g8EJaOUyamsETSYX_GtKGGUw_h8lJG=DLQ`]x9k=Lp2JlsuzE9cZf@5>y61;s47P8QNJyXR\7;2b]5;]NDx<;VPpQzVCDF]VuDu=6YnJnauZJ3\@ME1_@Dg`myLRV[kfcir^8ACO0LlBuY>TfaP`lW`8jg[PRvF?_fGvVD\<:qywV3A7AMeE7C73Rvx<;KuOAsD>"
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
560,13
parTargetCube
parGroup1
parGroup2
parGroup3
parGroup4
parGroup5
parGroup6
parGroup7
parGroup8
parGroup9
parGroup10
parGroup11
parGroup12
561,13
2
2
2
2
2
2
2
2
2
2
2
2
2
590,13
parTargetCube,""
parGroup1,""
parGroup2,""
parGroup3,""
parGroup4,""
parGroup5,""
parGroup6,""
parGroup7,""
parGroup8,""
parGroup9,""
parGroup10,""
parGroup11,""
parGroup12,""
637,13
parTargetCube,""
parGroup1,""
parGroup2,""
parGroup3,""
parGroup4,""
parGroup5,""
parGroup6,""
parGroup7,""
parGroup8,""
parGroup9,""
parGroup10,""
parGroup11,""
parGroup12,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,187
#****Begin: Generated Statements***
#****End: Generated Statements****
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
TRUE = 1; FALSE = 0;
# IF( CubeExists( parTargetCube ) = FALSE );
# 	strMessage = 'Cube ' | parTargetCube | ' does not exist, Exiting.';
# 	CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 	cubeProcessLog, procName, '1', 'Error Message' );
# 	strEndMessage = 'Process Completed with Errors';
	
# 	ProcessBreak();
# ENDIF;

strDims = ';';
numIndex = 1;
WHILE( TABDIM( parTargetCube, numIndex ) @<> '' );
	dimCurrent = TABDIM( parTargetCube, numIndex );
	strDims = strDims | dimCurrent | ';';
numIndex = numIndex + 1;
END;

subTarget = GetProcessName | TIMST( NOW, '\Y\m\d\h\i\s' ) | NumberToString( RAND() * 1000000000 );
viewTarget = subTarget;

strGroups = 'parGroup1,parGroup2,parGroup3,parGroup4,parGroup5,parGroup6,parGroup7,parGroup8,parGroup9,parGroup10,parGroup11,parGroup12';
WHILE( LONG( strGroups ) > 0 );
	numComma = SCAN( ',', strGroups | ',' );
	strCurrent = SUBST( strGroups, 1, numComma - 1 );
	strGroups = DELET( strGroups, 1, numComma );
	
	strCommand = Expand( '%' | strCurrent | '%' );
	IF( strCommand @<> '' );
		# If any commands are unable to be processed, don't delete anything.
		# The Default should be to Leave Data intact.
		numColon = SCAN( ':', strCommand );
		IF( numColon = 0 );
			strMessage = 'Improperly formatted command, Exiting: ' | strCurrent;
# 			CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 			cubeProcessLog, procName, '1', 'Error Message' );
# 			strEndMessage = 'Process Completed with Errors';
			
			ProcessBreak();
		ENDIF;
		
		dimCurrent = SUBST( strCommand, 1, numColon - 1 );
		strSyntax = SUBST( strCommand, numColon + 1, LONG( strCommand ) );
		
		# If this dimension is not par of the Target Cube, something is off, Abort.
		IF( SCAN( ';' | dimCurrent | ';', strDims ) = 0 );
			strMessage = 'Dimension not in Target Cube, Exiting: ' | dimCurrent;
# 			CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 			cubeProcessLog, procName, '1', 'Error Message' );
			strEndMessage = 'Process Completed with Errors';
			
			ProcessBreak();
		ENDIF;
		
		# A [ following the : character indicates that we will be getting a list of elements
		IF( SUBST( strSyntax, 1, 1 ) @= '[' );
			strMessage = strCurrent | ' is an Element List for dimension ' | dimCurrent;
# 			CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 			cubeProcessLog, procName, '1', NumberToString( numLine ) );
#			numLine = numLine + 1;
			
			SubsetCreate( dimCurrent, subTarget );
			
			strSyntax = SUBST( strSyntax, 2, LONG( strSyntax ) - 2 );
			WHILE( LONG( strSyntax ) > 0 );
				numComma = SCAN( ',', strSyntax | ',' );
				elemCurrent = SUBST( strSyntax, 1, numComma - 1 );
				strSyntax = DELET( strSyntax, 1, numComma );
				
				# If an element is missing, report it, but continue.
				IF( DIMIX( dimCurrent, elemCurrent ) = 0 );
# 					strMessage = 'Element "' | elemCurrent | '" not found in Dimension ' | dimCurrent | ', Skipping';
# 					CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 					cubeProcessLog, procName, '1', NumberToString( numLine ) );
#					numLine = numLine + 1;
				ELSE;
					SubsetElementInsert( dimCurrent, subTarget, elemCurrent, SubsetGetSize( dimCurrent, subTarget ) + 1 );
				ENDIF;
				
				# If the subset is empty, no valid elements were passed in, Abort.
				IF( SubsetGetSize( dimCurrent, subTarget ) = 0 );
					strMessage = 'Subset sized Zero, Bad Syntax, Exiting: ' | strCommand;
# 					CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 					cubeProcessLog, procName, '1', 'Error Message' );
					strEndMessage = 'Process Completed with Errors';
					
					ProcessBreak;
				ENDIF;
			END;
		# A { following the : character indicates that we will be getting an MDX function to execute
		ELSEIF( SUBST( strSyntax, 1, 1 ) @= '{' );
			strMessage = strCurrent | ' is a MDX Command for dimension ' | dimCurrent;
# 			CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 			cubeProcessLog, procName, '1', NumberToString( numLine ) );
#			numLine = numLine + 1;
			
			strSyntax = SUBST( strSyntax, 2, LONG( strSyntax ) - 2 );
			
			# If the MDX is bad, the process will abort on it's own
			SubsetCreatebyMDX( subTarget, strSyntax );
			# Make the subset Static
			SubsetMDXSet( dimCurrent, subTarget, '' );
			
			# If the subset is empty, no valid elements returned, Abort.
			IF( SubsetGetSize( dimCurrent, subTarget ) = 0 );
				strMessage = 'Subset sized Zero, Bad Syntax, Exiting: ' | strCommand;
# 				CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 				cubeProcessLog, procName, '1', 'Error Message' );
				strEndMessage = 'Process Completed with Errors';
				
				ProcessBreak;
			ENDIF;
		# Any other input after the : will indicate that a Subset Name is being passed in.
		# This subset will be copied, element for element, to a new Static Subset
		ELSE;
			strMessage = strCurrent | ' is a Subset for dimension ' | dimCurrent;
# 			CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 			cubeProcessLog, procName, '1', NumberToString( numLine ) );
#			numLine = numLine + 1;
			
			# If the Subset doesn't exist for the current dimension, Abort
			IF( SubsetExists( dimCurrent, strSyntax ) = FALSE );
				strMessage = 'Subset does not exist for dimension, Exiting: ' | strCommand;
# 				CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 				cubeProcessLog, procName, '1', 'Error Message' );
				strEndMessage = 'Process Completed with Errors';
				
				ProcessBreak;
			ENDIF;
			
			SubsetCreate( dimCurrent, subTarget );
			
			numIndex = 1;
			numControl = SubsetGetSize( dimCurrent, strSyntax );
			WHILE( numIndex <= numControl );
				elemCurrent = SubsetGetElementName( dimCurrent, strSyntax, numIndex );
				SubsetElementInsert( dimCurrent, subTarget, elemCurrent, numIndex );
			numIndex = numIndex + 1;
			END;
			
			# If the source subset was empty, Abort
			IF( SubsetGetSize( dimCurrent, subTarget ) = 0 );
				strMessage = 'Subset sized Zero, Bad Syntax, Exiting: ' | strCommand;
# 				CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
# 				cubeProcessLog, procName, '1', 'Error Message' );
				strEndMessage = 'Process Completed with Errors';
				
				ProcessBreak;
			ENDIF;
		ENDIF;
	ENDIF;
numIndex = numIndex + 1;
END;

#########################################################################
# BUILD DATA ZERO VIEW
#########################################################################
ViewCreate( parTargetCube, viewTarget );

# Setup View
numIndex = 1;
WHILE( TABDIM( parTargetCube, numIndex ) @<> '' );
	dimCurrent = TABDIM( parTargetCube, numIndex );
	IF( SubsetExists( dimCurrent, subTarget ) = FALSE );
    	SubsetCreate( dimCurrent, subTarget);
		strMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | dimCurrent | '] )}, 0 )}';
		#SubsetCreatebyMDX( subTarget, strMDX );
        SubsetMDXSet( dimCurrent, subTarget, strMDX );
		SubsetMDXSet( dimCurrent, subTarget, '' );
	ENDIF; 
	ViewSubsetAssign( parTargetCube, viewTarget, dimCurrent, subTarget );
	ViewRowDimensionSet( parTargetCube, viewTarget, dimCurrent, numIndex );
numIndex = numIndex + 1;
END;

numLogging = CubeGetLogChanges( parTargetCube );
CubeSetLogChanges( parTargetCube, 0 );

ViewZeroOut( parTargetCube, viewTarget );

CubeSetLogChanges( parTargetCube, numLogging );
#CubeSaveData( parTargetCube );


573,3
#****Begin: Generated Statements***
#****End: Generated Statements****

574,3
#****Begin: Generated Statements***
#****End: Generated Statements****

575,12
#****Begin: Generated Statements***
#****End: Generated Statements****
# Cleanup
IF( ViewExists( parTargetCube, viewTarget ) = 1 ); ViewDestroy( parTargetCube, viewTarget ); ENDIF;

numIndex = 1;
WHILE( TABDIM( parTargetCube, numIndex ) @<> '' );
	dimCurrent = TABDIM( parTargetCube, numIndex );
	IF( SubsetExists( dimCurrent, subTarget ) = 1 ); SubsetDestroy( dimCurrent, subTarget ); ENDIF;
numIndex = numIndex + 1;
END;

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
