#===========================================================================================
# Retain Shop Common Functions
#
# The functions in this library should be used extensively
# to ensure that the correct information for each case is always returned. This would
# include all exiting Testcases. 
#===========================================================================================

#########################################################################
# This Function is to Find Valid User and Discount Eligible to the user #
#########################################################################

 function Find-Valid-Discount
 {
	param 
	(
		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$User_Name
	)	
    # Check if the User is new User or existing user
  	invoke-sqlcmd -Query {
	if exists (select name from sys.database_principals where name=$User_Name) 
	Write-Host $("User Account exists in Database") 
	User_Discount -User $User_Name
	
	else 
	Write-Host $("User Account does not exists in Database Please Set up the User Account") 
	} 
	
	# Write a Function to Add new User
   #Runs a query on SQL Server to find the User
}
 
 #####################################################################
 # This Function to Calculate the Various Discounts available to User#
 #####################################################################
 
 function User_Discount
 {
    param 
	(
		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$User,
		[Parameter(Position=0, Mandatory=$false)]
		[ValidateNotNullOrEmpty()]
		[System.double]
		$Initial_Bill
	)	
   
    switch ($User)
	{	
		"Emp_Of_Store"
		{
			# discount = 30%	
			$discount = "30"            		
		}
		
		"Aff_To_Store"
		{
		   # discount = 10
		   $discount = "10"		  	
		}
        
		# This is for 2 years Loyalty but we can add more refined conditions for this
		"Loyal_to_Store"
		{
		  # discount = 5
		  $discount = "5"		  	
		}		
      default
		{
		  throw $("User '{0}' has no discounts" -f $User)
		}	
   }
   if ( User buying groceries)
   { write-host" No discount" }
  else
   {	
     if ( Initial_Bill -gt $100 )
	 {
          $discount = $discount + 5
	  Get-discount -$Discount $discount -Total $Initial_Bill
	 }
    } 
 }
 ######################################################
 # This function Calculates the Discount for the User #
 ######################################################
 Get-discount 
 {
   param 
	(
		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.double]
		$Discount,
		
		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.int]
		$Total
		)	
	# Calculate the Final Price to be paid by User	
	$Actual_Discount = 100 * $Discount
		 $Final_Discount = $Actual_Discount / 100
         $Final_Price = $Total - $Final_Discount 
 }


  
  
