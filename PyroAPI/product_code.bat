::@ECHO OFF
SET cdir=%cd%
SET sfolder=product@code
SET sdir=%cdir%\%sfolder%
SET dfolder=product_code
SET ddir=%cdir%\%dfolder%
 
FOR /f %%x in ('dir /b %sdir%') DO (
	SET spath=%sdir%\%%x
	echo %spath%
	)
set /p DUMMY=Hit ENTER to continue...