::@ECHO OFF
SETLOCAL EnableDelayedExpansion

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
	ECHO htmlpath: %htmlpath%
	ECHO htmlpath: !htmlpath!

	:: title
	:: Elleven A5 Zip-Around Tech Folder
	SET selector="#ctl00_Main_lblProductDetailName text{}"
	SET title=type "%htmlpath%" | pup -c %selector%
	ECHO title %: %title%
	ECHO title !: !title!
	
)

set /p DUMMY=Hit ENTER to continue...