601,100
602,"zSystem-Server-Hierarchy-Check-V1"
562,"ODBC"
586,"PROD OSSC_A"
585,"PROD OSSC_A"
564,"PlanningAnalyticsReader"
565,"eLE:Gu[;d2avgzGytSO4ilX8pzjfXaTmqtSO0BphAUiHDMy[j03]lR<`b[CVe2}up6\6MndEF\ja87`U9H2f=Vl8NNB3xc@9YFQdmAK^M?nikC[`<>8Ea1BWC^zJoj2WvCR2xuOKKOY<gR=t`AM2iFa?z=Cs2SHRC^eBWdMQS_S8-ae9ZJy>8NnpG;If7<}rCf<Iv;ip"
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
566,33
select DISTINCT 
	co.BusinessUnitCode  as  vCompanyCode,
       div.DivisionCode as vDivisionCode, 
       dept.DepartmentCode as vDepartmentCode, 
       mc.MasterClientCode as vMasterClientCode, 
	cli.ClientFinancialCode as vClientFinancialCode,
	br.ProductCode as vProductCode,
	proj.ProjectCode as vProjectCode
 from 
	GLDataMart.d_Project proj
       LEFT JOIN GLDataMart.d_BusinessUnit co on co.BusinessUnitSKey = proj.BusinessUnitSKey
       LEFT JOIN GLDataMart.d_Division div on div.DivisionSKey = proj.DivisionSKey
       LEFT JOIN GLDataMart.d_Department dept on dept.DepartmentSKey = proj.DepartmentSKey
       LEFT JOIN GLDataMart.d_MasterClient mc on mc.MasterCLientSKey = proj.MasterClientSKey
       LEFT JOIN GLDataMart.d_ClientFinancial cli on cli.ClientFinancialSKey = proj.ClientFinancialSKey
      LEFT JOIN GLDataMart.d_Product br on br.ProductSKey = proj.ProductSKey	

where 
	co.BusinessUnitCode = 'GSPA' and 
 div.DivisionCOde Like '%' and
dept.DepartmentCode Like '%' and 
 mc.MasterClientCOde Like '%' and
cli.ClientFinancialCode Like '%' and 
br.ProductCode Like '%' and 
proj.ProjectGroup Like '%'
group by 
co.BusinessUnitCode,
       div.DivisionCode, 
       dept.DepartmentCode, 
       mc.MasterClientCode, 
	cli.ClientFinancialCode,
	br.ProductCode,
	proj.ProjectCode
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
577,7
vCompanyCode
vDivisionCode
vDepartmentCode
vMasterClientCode
vClientFinancialCode
vProductCode
vProjectCode
578,7
2
2
2
2
2
2
2
579,7
1
2
3
4
5
6
7
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
582,7
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,170
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

strParameters = '';
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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
TRUE = 1; FALSE = 0;
#****Begin: Generated Statements***
#****End: Generated Statements****

# Check ODBC Connection
nReturnCode = ExecuteProcess ( 'zSystem-Server-ODBC-Check' );
IF ( nReturnCode <> ProcessExitNormal());
	strErrorMessage = 'Source DB is not available via ODBC';
	CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strErrorMessage,
	cubeProcessLog, procName, '1', 'Error Message' );
	ProcessBreak;
ENDIF;

sParameterCube = 'zSystem-Server-Parameter';
sCurrentActualPeriod = CELLGETS( sParameterCube, 'Current Actual Load Period', 'string' );
nCurrentActualPeriod = CELLGETN( sParameterCube, 'Current Actual Load Period', 'Number' );

sDebugFilePath = CELLGETS( sParameterCube, 'Debug Directory', 'string' );
sSourceFilePath = CELLGETS( sParameterCube, 'Import Directory', 'string' ) | '\Data Files\';

sCubeName = 'zSystem-Hierarchy-Check';

sCompanyDim = 'Company';
sNoCompany = 'No Company';

sDivisionDim = 'Division';
sNoDivision = 'No Division';

sMasterClientDim = 'Master Client';
sNoMasterClient = 'No Master Client';

sClientDim = 'Client';
sNoClient = 'No Client';

sProductDim = 'Product';
sNoProduct = 'zNoProduct';

sProjectDim = 'Project';
sNoProject = 'zNoProject';


sCompanyDivisionDim = sCompanyDim | '-' | sDivisionDim;
IF( DimensionExists ( sCompanyDivisionDim ) = 0 );
	DimensionCreate( sCompanyDivisionDim );
	AttrInsert( sCompanyDivisionDim, '', 'Code-Description', 'A' );
ELSE;
	DIMENSIONDELETEALLELEMENTS( sCompanyDivisionDim );
ENDIF;

sDivisionClientDim = sDivisionDim | '-' | sClientDim;
IF( DimensionExists ( sDivisionClientDim ) = 0 );
	DimensionCreate( sDivisionClientDim );
	AttrInsert(sDivisionClientDim, '', 'Code-Description', 'A' );
ELSE;
	DIMENSIONDELETEALLELEMENTS( sDivisionClientDim);
ENDIF;

# sMasterClientClientDim = sMasterClientDim | '-' | sClientDim;
# IF( DimensionExists ( sMasterClientClientDim ) = 0 );
# 	DimensionCreate(sMasterClientClientDim  );
# 	AttrInsert(sMasterClientClientDim, '', 'Code-Description', 'A' );
# ELSE;
# 	DIMENSIONDELETEALLELEMENTS(sMasterClientClientDim);
# ENDIF;


sClientProjectDim = sClientDim | '-' | sProjectDim;
IF( DimensionExists ( sClientProjectDim ) = 0 );
	DimensionCreate( sClientProjectDim );
	AttrInsert(sClientProjectDim, '', 'Code-Description', 'A' );
ELSE;
	DIMENSIONDELETEALLELEMENTS(sClientProjectDim);
ENDIF;

# sProductProjectDim = sProductDim | '-' | sProjectDim;
# IF( DimensionExists ( sProductProjectDim ) = 0 );
# 	DimensionCreate( sProductProjectDim );
# 	AttrInsert(sProductProjectDim, '', 'Code-Description', 'A' );
# ELSE;
# 	DIMENSIONDELETEALLELEMENTS(sProductProjectDim);
# ENDIF;

sProjectDim = 'Project';
sProject = 'All Project';

sMeasureDim = 'zSystem-Measure';
sMeasure = 'Number';

numLogging = CubeGetLogChanges( sCubeName );
CubeSetLogChanges( sCubeName, 0 );

# zSystem-Hierarchy-Check
strMessage = 'Clearing Data for ' | sCubeName;
CellPutS( '[' | TIMST( NOW, strFormat ) | ' T+' | TIMST( NOW - timeStart, '\hh:\im:\ss' ) | ']  ' | strMessage,
cubeProcessLog, procName, '1', NumberToString( numLine ) );
numLine = numLine + 1;
# CLEAR DATA TARGET
##############################
ExecuteProcess( 'zSystem-Cube-DataClear', 
	'parTargetCube', sCubeName );


# vElementDivision = 'Select a Company';
# DivisionSub = '}zCompany_Blank';
# IF(DimensionElementExists( sDivisionDim, vElementDivision)=0);
# 	DimensionElementInsert( sDivisionDim,'', vElementDivision, 'N');
# ENDIF;

# vElementClient = 'Select a Division';
# ClientSub = '}zDivision_Blank';
# IF(DimensionElementExists( sClientDim, vElementClient)=0);
# 	DimensionElementInsert( sClientDim,'', vElementClient, 'N');
# ENDIF;

# vElementClient = 'Select a Master Client';
# ClientSub = '}zMasterClient_Blank';
# IF(DimensionElementExists( sClientDim, vElementClient)=0);
# 	DimensionElementInsert( sClientDim,'', vElementClient, 'N');
# ENDIF;

# vElementProduct = 'Select a Client';
# ProductSub = '}zClient_Blank';
# IF(DimensionElementExists( sProductDim, vElementProduct)=0);
# 	DimensionElementInsert( sProductDim,'', vElementProduct, 'N');
# ENDIF;

# vElementProject = 'Select a Product';
# ProjectSub = '}zProduct_Blank';
# IF(DimensionElementExists( sProjectDim, vElementProject)=0);
# 	DimensionElementInsert( sProjectDim,'', vElementProject, 'N');
# ENDIF;

n=1;

573,163
#****Begin: Generated Statements***
#****End: Generated Statements****

#===========================================================
#Ignore records where the Project does not exist in the Project dimension
#===========================================================
IF( DimensionElementExists(sProjectDim,vProjectCode) = 0 );
	ITEMSKIP;
ENDIF;

IF( vClientFinancialCode @= '' );
	ITEMSKIP;
ENDIF;

#===========================================================
#Ignore records where the Exclude attribute is said to Y
#===========================================================
#sExclude = ATTRS( sClientDim, vClientFinancialCode, 'Exclude from Subset Build' );
#IF( sExclude @= 'Y' );
#	ITEMSKIP;
#ENDIF;

#===========================================================
#Create a Hiearchy dimension for Company / Division
#===========================================================
sParentDim = 'Company';
vParent = vCompanyCode;
sChildDim = 'Division';
vChild = vDivisionCode;
sParentChildDim = sCompanyDivisionDim;
IF(vChild @= vParent % vChild @= '' % Dimix( sChildDim,  vChild ) = 0 % vParent @= '' % Dimix( sParentDim, vParent ) = 0  );
	asciioutput( sDebugFilePath | sParentDim | ' ' | sChildDim|  'Invalid.csv', vChild, vParent );
ELSE;
#=================================================
#
#	IF the child also exists in the Parent dimension
#	Add "Dup_" in front of the child element

	IF( Dimix( sParentDim, vChild) >0 );
		vChild = 'Dup_' | vChild;
	ENDIF;
#=================================================
	IF( Dimix( sParentChildDim, vChild ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vChild, 'N' );
	ENDIF;
	IF( Dimix( sParentChildDim, vParent ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vParent, 'N' );
	ENDIF;
	IF(vParent @<> vChild);
		DIMENSIONELEMENTCOMPONENTADD( sParentChildDim, vParent, vChild, 1 );
    ENDIF;
ENDIF;

#===========================================================
#Create a Hiearchy dimension for Division / Client
#===========================================================
sParentDim = 'Division';
vParent = vDivisionCode;
sChildDim = 'Client';
vChild = vCLientFinancialCode;
sParentChildDim = sDivisionClientDim;
IF(vChild @= vParent % vChild @= '' % Dimix( sChildDim,  vChild ) = 0 % vParent @= '' % Dimix( sParentDim, vParent ) = 0  );
	asciioutput( sDebugFilePath | sParentDim | ' ' | sChildDim|  'Invalid.csv', vChild, vParent );
ELSE;
#=================================================
#
#	IF the child also exists in the Parent dimension
#	Add "Dup_" in front of the child element

	IF( Dimix( sParentDim, vChild) >0 );
		vChild = 'Dup_' | vChild;
	ENDIF;
#=================================================
	IF( Dimix( sParentChildDim, vChild ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vChild, 'N' );
	ENDIF;
	IF( Dimix( sParentChildDim, vParent ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vParent, 'N' );
	ENDIF;
	IF(vParent @<> vChild);
		DIMENSIONELEMENTCOMPONENTADD( sParentChildDim, vParent, vChild, 1 );
    ENDIF;
    
     IF(ELISPAR(sParentChildDim,vParent, 'NEW')=0);
         DimensionElementComponentAdd( sParentChildDim, vParent, 'NEW', 1 );
     ENDIF; 
ENDIF;


#===========================================================
#Create a Hiearchy dimension for Client / Project
#===========================================================
sParentDim = 'Client';
vParent = vClientFinancialCode;
sChildDim = 'Project';
vChild = vProjectCode;
sParentChildDim = sClientProjectDim;
IF(vChild @= vParent % vChild @= '' % Dimix( sChildDim,  vChild ) = 0 % vParent @= '' % Dimix( sParentDim, vParent ) = 0  );
	asciioutput( sDebugFilePath | sParentDim | ' ' | sChildDim|  'Invalid.csv', vChild, vParent );
ELSE;
#=================================================
#
#	IF the child also exists in the Parent dimension
#	Add "Dup_" in front of the child element

	IF( Dimix( sParentDim, vChild) >0 );
		vChild = 'Dup_' | vChild;
	ENDIF;
#=================================================
	IF( Dimix( sParentChildDim, vChild ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vChild, 'N' );
	ENDIF;
	IF( Dimix( sParentChildDim, vParent ) =0 );
		DIMENSIONELEMENTINSERT( sParentChildDim, '', vParent, 'N' );
	ENDIF;
    IF(vParent @<> vChild);
		DIMENSIONELEMENTCOMPONENTADD( sParentChildDim, vParent, vChild, 1 );
    ENDIF;
   
     
     IF(ELISPAR(sParentChildDim,vParent, 'GSPA No Project')=0);
        DimensionElementComponentAdd( sParentChildDim, vParent, 'GSPA No Project', 1 );
     ENDIF;
ENDIF;


#===========================================================
#Create a Hiearchy dimension for Product / Project
#===========================================================
# sParentDim = 'Product';
# vParent = vProductCode;
# sChildDim = 'Project';
# vChild = vProjectCode;
# sParentChildDim = sProductProjectDim;
# IF(vChild @= vParent % vChild @= '' % Dimix( sChildDim,  vChild ) = 0 % vParent @= '' % Dimix( sParentDim, vParent ) = 0  );
# 	asciioutput( sDebugFilePath | sParentDim | ' ' | sChildDim|  'Invalid.csv', vChild, vParent );
# ELSE;
# #=================================================
# #
# #	IF the child also exists in the Parent dimension
# #	Add "Dup_" in front of the child element

# 	IF( Dimix( sParentDim, vChild) >0 );
# 		vChild = 'Dup_' | vChild;
# 	ENDIF;
# #=================================================
# 	IF( Dimix( sParentChildDim, vChild ) =0 );
# 		DIMENSIONELEMENTINSERT( sParentChildDim, '', vChild, 'N' );
# 	ENDIF;
# 	IF( Dimix( sParentChildDim, vParent ) =0 );
# 		DIMENSIONELEMENTINSERT( sParentChildDim, '', vParent, 'N' );
# 	ENDIF;
# 	IF(vParent @<> vChild);
# 		DIMENSIONELEMENTCOMPONENTADD( sParentChildDim, vParent, vChild, 1 );
#     ENDIF;  
    
#     IF(ELISPAR(sParentChildDim,vParent, 'GSPA No Project')=0);
#         DimensionElementComponentAdd( sParentChildDim, vParent, 'GSPA No Project', 1 );
#     ENDIF;
    
# ENDIF;


574,40
#****Begin: Generated Statements***
#****End: Generated Statements****

IF( vCompanyCode @= 'No Company' );
	vCompanyCode = 'zNoCompany';
ENDIF;

IF(vDivisionCode @= 'No Division' );
	ITEMSKIP;
ENDIF;

IF(vMasterCLientCode @= 'No Master Client' );
	ITEMSKIP;
ENDIF;

IF(vClientFinancialCode @= 'No Client' );
	ITEMSKIP;
ENDIF;

IF(vProductCode @= 'No Product');
	ITEMSKIP;
ENDIF;

IF(vProjectCode @= 'No Project');
	ITEMSKIP;
ENDIF;


IF( DimensionElementExists(sProjectDim,vProjectCode) = 0 );
	ITEMSKIP;
ENDIF;

nGetCell = CellGetN(sCubeName, vCompanyCode, vDivisionCode,vClientFinancialCode,vProjectCode, sMeasure );

IF(nGetCell = 0);
	CellPutN(1, sCubeName, vCompanyCode, vDivisionCode,vClientFinancialCode,vProjectCode, sMeasure );
ENDIF;



575,88
#****Begin: Generated Statements***
#****End: Generated Statements****

CubeSetLogChanges( sCubeName, numLogging );
CubeSaveData( sCubeName );
###
ExecuteProcess( 'zSystem-Subset-Create-from-Dimension', 'parBaseDim', 'Company', 'parTargetDim', 'Division' );
ExecuteProcess( 'zSystem-Subset-Create-from-Dimension', 'parBaseDim', 'Division', 'parTargetDim', 'Client' );
ExecuteProcess( 'zSystem-Subset-Create-from-Dimension', 'parBaseDim', 'Client', 'parTargetDim', 'Project' );
###
ExecuteProcess( 'zSystem-Server-Client-Project Manual Update');


# vElementDivision = 'Select a Company';
# DivisionSub = '}zCompany_Blank';
# IF(SubsetExists( sDivisionDIm, DivisionSub )=1);
# 	SubsetDestroy( sDivisionDIm, DivisionSub );
# ENDIF;
# SubsetCreate( sDivisionDim, DivisionSub, 0 );
# SubsetElementInsert( sDivisionDim, DivisionSub, vElementDivision, 1);

# vElementMasterClient = 'Select a Division';
# MasterClientSub = '}zDivision_Blank';
# IF(SubsetExists( sMasterClientDIm, MasterClientSUb )=1);
# 	SubsetDestroy( sMasterClientDIm, MasterClientSub );
# ENDIF;
# SubsetCreate( sMasterClientDim, MasterClientSub, 0 );
# SubsetElementInsert( sMasterClientDim, MasterClientSub, vElementMasterClient, 1);


# vElementClient = 'Select a Division';
# ClientSub = '}zDivision_Blank';
# IF(SubsetExists( sClientDIm, ClientSUb )=1);
# 	SubsetDestroy( sClientDIm, ClientSub );
# ENDIF;
# SubsetCreate( sClientDim, ClientSub, 0 );
# SubsetElementInsert( sClientDim, ClientSub, vElementClient, 1);


# vElementProduct = 'Select a Client';
# ProductSub = '}zClient_Blank';
# IF(SubsetExists( sProductDIm, ProductSUb )=1);
# 	SubsetDestroy( sProductDim, ProductSUb );
# ENDIF;
# SubsetCreate( sProductDIm, ProductSub, 0 );
# SubsetElementInsert( sProductDim, ProductSub, vElementProduct, 1);

# vElementProject = 'Select a Product';
# ProjectSub = '}zProduct_Blank';
# IF(SubsetExists( sProjectDim, Projectsub )=1);
# 	SubsetDestroy( sProjectDIm, ProjectSub );
# ENDIF;
# SubsetCreate( sProjectDIm, ProjectSub, 0 );
# SubsetElementInsert( sProjectDim, ProjectSub, vElementProject, 1);




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
