@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadRFLAlign.lsp del LoadRFLAlign.lsp
rem
COPY ".\Align\RFLAlignCommon.lsp" + ^
     ".\Align\RFLAlignDef.lsp" + ^
     ".\Align\RFLArcLength.lsp" + ^
     ".\Align\RFLAXY.lsp" + ^
     ".\Align\RFLGetRadius.lsp" + ^
     ".\Align\RFLIntersA.lsp" + ^
     ".\Spiral\CDSpiral.lsp" + ^
     ".\Spiral\CFitSpiral.lsp" + ^
     ".\Spiral\RFLDrawSpiral.lsp" + ^
     ".\Spiral\RFLFitSpiralAA.lsp" + ^
     ".\Spiral\RFLFitSpiralLA.lsp" + ^
     ".\Spiral\RFLFitSpiralLL.lsp" + ^
     ".\Spiral\RFLGetSpiralA.lsp" + ^
     ".\Spiral\RFLGetSpiralA2.lsp" + ^
     ".\Spiral\RFLGetSpiralData.lsp" + ^
     ".\Spiral\RFLGetSpiralLS.lsp" + ^
     ".\Spiral\RFLGetSpiralLS2.lsp" + ^
     ".\Spiral\RFLGetSpiralPI2.lsp" + ^
     ".\Spiral\RFLGetSpiralR.lsp" + ^
     ".\Spiral\RFLGetSpiralR2.lsp" + ^
     ".\Spiral\RFLGetSpiralRadius.lsp" + ^
     ".\Spiral\RFLGetSpiralTheta.lsp" + ^
     ".\Spiral\RFLGetSpiralTheta2.lsp" + ^
     ".\Spiral\RFLSpiralFXR.lsp" + ^
     ".\Spiral\RFLSpiralFYR.lsp" + ^
     ".\Spiral\RFLSpiralK.lsp" + ^
     ".\Spiral\RFLSpiralKR.lsp" + ^
     ".\Spiral\RFLSpiralOffset.lsp" + ^
     ".\Spiral\RFLSpiralOffset2.lsp" + ^
     ".\Spiral\RFLSpiralP.lsp" + ^
     ".\Spiral\RFLSpiralPointOn.lsp" + ^
     ".\Spiral\RFLSpiralPR.lsp" + ^
     ".\Spiral\RFLSpiralStaOff.lsp" + ^
     ".\Spiral\RFLSpiralStaOff2.lsp" + ^
     ".\Spiral\RFLSpiralXY.lsp" + ^
     ".\Spiral\RFLSpiralXY2.lsp" ^
     ".\LoadRFLAlign.lsp"
pause