@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadRFLAlign.lsp del LoadRFLAlign.lsp
rem
COPY ".\Align\RFL*.lsp" + ^
     ".\Spiral\RFL*.lsp" + ^
     ".\Profile\RFL*.lsp" + ^
     ".\Super\RFL*.lsp" + ^
     ".\Commands\C*.lsp" ^
     ".\LoadRFLAlign.lsp"
