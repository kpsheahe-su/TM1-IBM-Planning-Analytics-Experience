601,100
602,"Data Load - Sales"
562,"CHARACTERDELIMITED"
586,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\sales_data_sample.csv"
585,"C:\Users\michi\OneDrive\Documents\TM1\Test Environment\Data\sales_data_sample.csv"
564,
565,"h1lVF9\GaVUS`>zq_kZQAX@UhsPmCTjKm3;N=[wJuuCkbvcjrKIPbx_tySURv;dL0pFDt[OpH_L`uZzkvLtr[E?bnQ\U_ROkR3iX3ra_9cFD:GOIEM]iPGVzCoJ@TR]Pq5O\D0imXp;wiSLg0OrxI68;9`EX]=Ze8X05HOgU^_`L?luyFRJHP^@ygiXYK>cii\PhVD4p"
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
577,25
ORDERNUMBER
QUANTITYORDERED
PRICEEACH
ORDERLINENUMBER
SALES
ORDERDATE
STATUS
QTR_ID
MONTH_ID
YEAR_ID
PRODUCTLINE
MSRP
PRODUCTCODE
CUSTOMERNAME
PHONE
ADDRESSLINE1
ADDRESSLINE2
CITY
STATE
POSTALCODE
COUNTRY
TERRITORY
CONTACTLASTNAME
CONTACTFIRSTNAME
DEALSIZE
578,25
2
1
1
1
1
2
2
2
2
2
2
1
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
579,25
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
13
14
15
16
17
18
19
20
21
22
23
24
25
580,25
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
0
581,25
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
0
582,25
VarType=32ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,106

#****Begin: Generated Statements***
#****End: Generated Statements****

############
# Creates Order Numbers Dimension
############
sOrderNumbersDim = 'Order Numbers';
sOrderNumberParent = 'All Orders';
IF(DimensionExists(sOrderNumbersDim)=0);
    DimensionCreate(sOrderNumbersDim);
    DimensionElementInsert(sOrderNumbersDim,'',sOrderNumberParent,'S');
ENDIF;

############
# Creates Location Dimension
############
sLocationDim = 'Location';
sLocationParent = 'All Locations';
sLocationOther = 'Other';
IF(DimensionExists(sLocationDim)=0);
    DimensionCreate(sLocationDim);
    DimensionElementInsert(sLocationDim,'',sLocationParent,'S');
    DimensionElementComponentAdd(sLocationDim, sLocationParent, sLocationOther, 1);
    ATTRINSERT(sLocationDim, '', 'Postal Code', 'S');
    ATTRINSERT(sLocationDim, '', 'Currency', 'S');
ENDIF;

############
# Creates Measurement Dimension
############
sMeasurementDim = 'Measurement';
IF(DimensionExists(sMeasurementDim)=0);
    DimensionCreate(sMeasurementDim);
    DimensionElementInsert(sMeasurementDim,'','Quantity Ordered','N');
    DimensionElementInsert(sMeasurementDim,'','Difference','C');
    DimensionElementComponentAdd(sMeasurementDim, 'Difference', 'Price Each', -1);
    DimensionElementComponentAdd(sMeasurementDim, 'Difference', 'MSRP', 1);
    DimensionElementInsert(sMeasurementDim,'','Order Line Number','N');
    DimensionElementInsert(sMeasurementDim,'','Sales','N');
    DimensionElementInsert(sMeasurementDim,'','Status','S');
    DimensionElementInsert(sMeasurementDim,'','Size','S');
ENDIF;
############
# Creates Product Dimension
############
sProductDim = 'Product';
sProductParent = 'All Products';
IF(DimensionExists(sProductDim)=0);
    DimensionCreate(sProductDim);
    DimensionElementInsert(sProductDim,'',sProductParent ,'N');
    ATTRINSERT(sProductDim, '', 'Product Code', 'A');
ENDIF;

############
# Creates Customer Dimension
############
sCustomerDim = 'Customer';
sCustomerParent = 'All Customers';
IF(DimensionExists(sCustomerDim)=0);
    DimensionCreate(sCustomerDim );
    DimensionElementInsert(sCustomerDim ,'',sCustomerParent ,'C');
    ATTRINSERT(sCustomerDim , '', 'Phone Number', 'S');
    ATTRINSERT(sCustomerDim , '', 'First Name', 'S');
    ATTRINSERT(sCustomerDim , '', 'Last Name', 'S');
    ATTRINSERT(sCustomerDim , '', 'Full Name', 'A');
ENDIF;

############
# Creates Scenario Dimension
############
sScenarioDim = 'Scenario';
IF(DimensionExists(sScenarioDim)=0);
    DimensionCreate(sScenarioDim);
    DimensionElementInsert(sScenarioDim ,'','Current' ,'N');
    DimensionElementInsert(sScenarioDim ,'','Test' ,'N');
ENDIF;

############
# Creates Version Dimension
############
sVersionDim = 'Version';
IF(DimensionExists(sVersionDim)=0);
    DimensionCreate(sVersionDim);
    DimensionElementInsert(sVersionDim ,'','Actual','N');
    DimensionElementInsert(sVersionDim ,'','Forecast','N');
ENDIF;



############
# Creates Cube 
############
vCube = 'Sales Data';
IF(CubeExists(vCube)=1);
    CubeDestroy(vCube);
    CubeCreate(vCube, sScenarioDim, sVersionDim, 'Year','Month','Day', sLocationDim, 'Currency' ,sOrderNumbersDim,sProductDim, sCustomerDim, sMeasurementDim); 
ELSE;
    CubeCreate(vCube, sScenarioDim, sVersionDim, 'Year','Month','Day', sLocationDim, 'Currency', sOrderNumbersDim,sProductDim, sCustomerDim, sMeasurementDim); 
ENDIF;






573,49

#****Begin: Generated Statements***
#****End: Generated Statements****

##########
# Order Number Dimension
##########
IF(DimensionElementExists(sOrderNumbersDim, ORDERNUMBER)=0);
    DimensionElementComponentAdd(sOrderNumbersDim, sOrderNumberParent,ORDERNUMBER, 1);
ENDIF;

##########
# Location Dimension Heirarchy
##########
sTERRITORY = TERRITORY|' - TERRITORY';
IF((DimensionElementExists(sLocationDim, sTERRITORY)=0) & TERRITORY @<> '');
    DimensionElementComponentAdd(sLocationDim, sLocationParent, sTERRITORY, 1);
ENDIF;
IF((DimensionElementExists(sLocationDim, COUNTRY)=0) & COUNTRY @<> '');
    DimensionElementComponentAdd(sLocationDim, sTERRITORY,COUNTRY, 1);
ENDIF;
IF((DimensionElementExists(sLocationDim, STATE) = 0) & STATE @<>'');
    DimensionElementComponentAdd(sLocationDim, COUNTRY,STATE, 1);
ENDIF;
IF((DimensionElementExists(sLocationDim, CITY) = 0) & STATE @<>'');
    DimensionElementComponentAdd(sLocationDim, STATE, CITY, 1);
ELSEIF((DimensionElementExists(sLocationDim, CITY) = 0) & STATE @='');
    DimensionElementComponentAdd(sLocationDim, COUNTRY,CITY, 1);
ENDIF;
IF(DimensionElementExists(sLocationDim, ADDRESSLINE1 |' '|ADDRESSLINE2)=0);
    DimensionElementComponentAdd(sLocationDim, CITY, ADDRESSLINE1|' '|ADDRESSLINE2,1);
ENDIF;

##########
# Product Dimension
##########
IF(DimensionElementExists(sProductDim, PRODUCTLINE)=0);
    DimensionElementComponentAdd(sProductDim, sProductParent,PRODUCTLINE, 1);
ENDIF;

##########
# Customer Dimension
##########
IF(DimensionElementExists(sCustomerDim, CUSTOMERNAME)=0);
    DimensionElementComponentAdd(sCustomerDim, sCustomerParent,CUSTOMERNAME, 1);
ENDIF;



574,52

#****Begin: Generated Statements***
#****End: Generated Statements****

#######
#Adds postal code attribute
#######
ATTRPUTS(POSTALCODE, sLocationDim, CITY,'Postal Code');
#######
#Adds product code attribute
#######
ATTRPUTS(PRODUCTCODE, sProductDim, PRODUCTLINE,'Product Code');
#######
#Adds contact attributes
#######
ATTRPUTS(PHONE, sCustomerDim, CUSTOMERNAME,'Phone Number');
ATTRPUTS(CONTACTFIRSTNAME, sCustomerDim, CUSTOMERNAME,'First Name');
ATTRPUTS(CONTACTLASTNAME, sCustomerDim, CUSTOMERNAME,'Last Name');
ATTRPUTS(CONTACTFIRSTNAME |' '| CONTACTLASTNAME, sCustomerDim, CUSTOMERNAME,'Full Name');



#######
#Insert values for measurements 
#######
MONTH = SUBST(ORDERDATE, 1, SCAN('/', ORDERDATE)-1); 
sChopped  = SUBST(ORDERDATE, SCAN('/', ORDERDATE)+1, LONG(ORDERDATE));
DAY = SUBST(sChopped, 1, SCAN('/',sChopped)-1);
YEAR = SUBST(ORDERDATE, LONG(ORDERDATE) - 8, 4); 

IF(StringToNumber(DAY) < 10);
	DAY = '0'|DAY;
ENDIF;
IF(StringToNumber(MONTH)<10);
	MONTH = '0'|MONTH;
ENDIF;

CELLPUTN(QUANTITYORDERED, vCube,'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Quantity Ordered'); 
CELLPUTN(PRICEEACH, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Price Each'); 
CELLPUTN(MSRP, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'MSRP'); 
CELLPUTN(ORDERLINENUMBER, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Order Line Number'); 
CELLPUTN(SALES, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Sales'); 
CELLPUTS(STATUS, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Status');
CELLPUTS(DEALSIZE, vCube, 'Current','Actual', YEAR, MONTH,DAY, ADDRESSLINE1|' '|ADDRESSLINE2, 'USD', ORDERNUMBER,PRODUCTLINE, CUSTOMERNAME, 'Size'); 








575,14

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
