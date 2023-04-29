@ECHO OFF
SET cdir=%cd%
SET sfolder=product@code
SET sdir=%cdir%\%sfolder%
SET dfolder=product_code
SET ddir=%cdir%\%dfolder%
SET selector=""
SET htmlpage=""

SET path=%path%;E:\fos\webdev\bin;
 
FOR /f %%x in ('dir /b %sdir%') DO (
	SET htmlpath=%sdir%\%%x

	:: title
	:: Elleven A5 Zip-Around Tech Folder
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	echo. title: type "%htmlpath%" | pup -c %selector%
	
	:: handle
	echo. handle: elleven-a5-zip-around-tech-folder
	
	:: bodyhtml
	:: Out:
	:: <span id="ctl00_Main_lblProductDetailDescription">
	:: This exclusive &amp; unique folder  has a Zippered closure. Techtrap elastic interior organizer. Holds an iPad. Front cover with organiser under flap. Interior organizational panel includes five business card holders and one USB port. Pen
	:: loop. Document folder. Includes 5&#34; x 8&#34;  elleven™ series writing pad. dobby nylon with scuba trim
	:: 28 ( l ) x 21.5 ( w ) x 3.5 ( h ) , looking for something slightly bigger, then look out for our 11-007 in an A4 size.
	:: </span>
	::set selector="#ctl00_Main_lblProductDetailDescription"
	set selector="#ctl00_Main_lblProductDetailDescription text{}"
	echo. type "%htmlpath%" | pup -c %selector%


	:: Vendor
	ECHO. Vendor: "Macma"
	
	:: Type
	:: Corporate Gifts
	set selector="#ctl00_Main_rptrBreadCrumbs_ctl01_lnkCrumb text{}"
	echo. type "%htmlpath%" | pup -c %selector%

	:: Tags
	:: <meta name="keywords" content="Corporate Clothing,Promotional Clothing,Corporate Gifts,gifts,promotional,printing,Promotional Gifts,Branding,Clothing,Corporate,Catalogue,Products,Toolbox,Caps,marketing">
	set selector="head > meta:nth-child(6)"
	type "%htmlpath%" | pup -c %selector%

	:: Published
	:: FALSE
	ECHO. Published: "FALSE"

	:: GiftCard
	ECHO. Published: "FALSE"

	:: Option1 > Name
	:: Engraved
	ECHO. Option1 > Name:  "Engraved"

	:: Option1 > Value
	:: Engraved
	ECHO. Option1 > Value: "No"

	:: Option2 > Name
	:: 
	ECHO. Option2 > Name: ""

	:: Option2 > Value
	:: 
	ECHO. Option2 > Value: ""

	:: Option3 > Name
	:: 
	ECHO. Option3 > Name: ""

	:: Option3 > Value
	:: 
	ECHO. Option3 > Value: ""

	:: Variant > SKU
	:: 11-006
	set selector="#ctl00_Main_lblProductDetailCode text{}"
	type "%htmlpath%" | pup -c %selector%

	:: Variant > Grams
	::
	ECHO. Variant > Grams: ""

	:: Variant > InventoryTracker
	:: shopify
	ECHO "shopify"	


	:: Variant > InventoryQty
	::
	ECHO ""

	:: Variant > InventoryPolicy
	:: deny
	ECHO "deny"


	:: Variant > FulfillmentService
	:: manual
	ECHO "manual"


	:: Variant > Price
	:: R199.99	
	set selector="#lblMyGroupPrice text{}"
	type "%htmlpath%" | pup -c %selector%


	:: Variant > CompareAtPrice
	::
	ECHO ""


	:: Variant > RequiresShipping
	:: TRUE
	ECHO TRUE


	:: Variant > Taxable
	:: TRUE
	ECHO TRUE


	:: Variant > Barcode
	::
	ECHO ""


	:: Variant > Image
	:: ""
	ECHO ""


	:: Variant > WeightUnit
	:: g
	ECHO "g"



	:: Variant > TaxCode
	::
	ECHO ""
		

	:: Image > Src
	:: 
	ECHO ""


	:: Image > Position
	:: 1
	ECHO 1


	:: Image > AltText
	:: Elleven A5 Zip-Around Tech Folder
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	type "%htmlpath%" | pup -c %selector%

	
	:: SEO > Title
	:: Elleven A5 Zip-Around Tech Folder
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	type "%htmlpath%" | pup -c %selector%

	
	:: SEO > Description
	:: <meta name="description" content="Read more about 11-006 in our A5 Folders range and order from South Africa&#39;s leading importer and brander of Corporate Clothing and Gifts">
	set selector="head > meta:nth-child(5)"
	type "%htmlpath%" | pup -c %selector%
	
	
	:: Google Shopping > Google Product Category	
	set selector=""
	type "%htmlpath%" | pup -c %selector%

	
	:: Google Shopping > Gender
	:: ""
	ECHO ""

	
	:: Google Shopping > Age Group
	:: ""
	ECHO ""

	
	:: Google Shopping > MPN
	:: ""
	ECHO ""

	:: Google Shopping > AdWords Grouping
	:: ""
	ECHO ""

	:: Google Shopping > AdWords Labels
	:: ""
	ECHO ""

	:: Google Shopping > Condition
	:: ""
	ECHO ""
	
	:: Google Shopping > Custom Product
	:: ""
	ECHO ""


	:: Google Shopping > Custom Label 0
	:: ""
	ECHO ""


	:: Google Shopping > Custom Label 1
	:: ""
	ECHO ""

	:: Google Shopping > Custom Label 2
	:: "
	ECHO ""


	:: Google Shopping > Custom Label 3
	:: ""
	ECHO ""


	:: Google Shopping > Custom Label 4
	:: ""
	ECHO ""

	:: adwords group
	ECHO ; >> test.txt
	
	

)





set /p DUMMY=Hit ENTER to continue...