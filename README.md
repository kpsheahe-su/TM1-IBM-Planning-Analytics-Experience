# TM1-IBM-Planning-Analytics-Experience
A brief planning model showing some of the code, cubes and rules I would build in an OLAP system.  


This is fictitious company data and should not be interpreted to be a representation of any real financial data. 
The Github folder holds Cubes, Data, Dimensions, Processes, and Rules folders which have the respective objects that are used in a TM1 model. 
The png files are screenshots of how our csv data is finally loaded into TM1 and made into cubes. 
The main cubes Currency and Sales support data from two different CVSs and allow for drilling up or down on data. 
Subset Control allows for users to insert the necessary information into the cube and run a process that dynamically creates the subset by string or an MDX expression.
User Selection is a simple cube view of how adaptive subsets can be used to drive user selections and we can thus use those to drive user report views.
Lastly, are our auxillary cubes that help to provide documentation and general controls for the model environment. Giving documentation details about cubes, 
dimensions, process and general information (emails, current data, etc.). If you have any questions please feel free to email me at kpsheahe@syr.edu. 

Best,
Kevin Sheahen

