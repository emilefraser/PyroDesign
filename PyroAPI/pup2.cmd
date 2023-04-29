@ECHO OFF
::SET path=%path%;E:\fos\webdev\bin;
SETLOCAL EnableDelayedExpansion

SET cdir=%cd%
SET sfolder=product@code
SET sdir=%cdir%\%sfolder%
SET dfolder=product_code
SET ddir=%cdir%\%dfolder%
SET selector=""
SET htmlpage=""

ECHO > test.txt 

FOR /f %%x in ('dir /b %sdir%') DO (
	SET htmlpath="%sdir%\%%x"
	ECHO !htmlpath! >> test.txt 
	:: title
	SET selector="#ctl00_Main_lblProductDetailName text{}"	
	type !htmlpath! | pup -c !selector!  >> test.txt
	
	:: handle
	SET selector="#ctl00_Main_lblProductDetailName text{}"	
	type !htmlpath! | pup -c !selector! >> test.txt

	:: description
	set selector="#ctl00_Main_lblProductDetailDescription text{}"
	type !htmlpath! | pup -c !selector! >> test.txt

	:: Vendor
	ECHO Amrod >> test.txt
	
	:: Type
	set selector="#ctl00_Main_rptrBreadCrumbs_ctl01_lnkCrumb text{}"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: Tags
	set selector="head > meta:nth-child(6)"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: Published; Giftcard;
	ECHO FALSE; FALSE; >> test.txt
	
	:: Option 1 > Value & Name
	ECHO Engraved; No; >> test.txt
	
	:: Option 2 > Value & Name
	ECHO ; ; >> test.txt
	
	:: Option 3 > Value & Name
	ECHO ; ; >> test.txt
	
	:: sku
	set selector="#ctl00_Main_lblProductDetailCode text{}"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: grams
	ECHO ; >> test.txt
	
	:: inv
	ECHO shopify; >> test.txt
	
	:: inv
	ECHO ; >> test.txt
	
	:: inv 0
	ECHO deny; >> test.txt
	
	:: inv management
	ECHO manual; >> test.txt	
	
	:: price R199.99	
	set selector="#lblMyGroupPrice text{}"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: CompareAtPrice
	ECHO ; >> test.txt
	
	:: required shipping
	ECHO TRUE; >> test.txt
	
	:: Taxable
	ECHO TRUE; >> test.txt	
	
	:: Barcode
	ECHO ; >> test.txt	
	
	:: Image
	ECHO ; >> test.txt		
	
	:: WeightUnit
	ECHO g; >> test.txt		
	
	:: TaxCode
	ECHO ; >> test.txt	
	
	:: Image > Src
	ECHO ; >> test.txt	
	
	:: Image > Position
	ECHO 1; >> test.txt

	:: alttext
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: seo title
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: description
	set selector="head > meta:nth-child(5)"
	type !htmlpath! | pup -c !selector! >> test.txt
	
	:: prod category
	ECHO ; >> test.txt
	
	:: prod gender
	ECHO ; >> test.txt
	
	:: prod age group 
	ECHO ; >> test.txt
	
	:: prod mpn
	ECHO ; >> test.txt
	
	:: adwords group
	ECHO ; >> test.txt
	
	:: AdWords Labels
	ECHO ; >> test.txt
	
	:: condition 
	ECHO ; >> test.txt
	
	:: custom product 
	ECHO ; >> test.txt
	
	:: custom label 0
	ECHO ; >> test.txt
	
	:: custom label 1
	ECHO ; >> test.txt
	
	:: custom label 2
	ECHO ; >> test.txt	
	
	:: custom label 3
	ECHO ; >> test.txt
	
	:: custom label 4
	ECHO ; >> test.txt
	
	
	
	
)

set /p DUMMY=Hit ENTER to continue...