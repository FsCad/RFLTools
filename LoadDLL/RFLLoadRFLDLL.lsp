;
;
;     Program written by Robert Livingston, 2013-10-27
;
;     RFL:LOADRFLDLL searches for the Correct version of the RFLTools DLL and loads it.
;
;
(defun RFL:LOADRFLDLL (/ ACADVER ACADPROD IS INFILE)
 (if (= nil (vl-string-search "(x64)" (getvar "platform")))
  (setq IS64 nil)
  (setq IS64 T)
 )
 (setq ACADPROD (vlax-product-key))
 (cond ((vl-string-search "\\R19.0\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2013x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2013x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2013 ^^^
       ((vl-string-search "\\R19.1\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2014x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2014x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2014 ^^^
       ((vl-string-search "\\R20.0\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2015x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2015x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2015 ^^^
       ((vl-string-search "\\R20.1\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2016x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2016x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2016 ^^^
       ((vl-string-search "\\R21.0\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2017x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2017x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2017 ^^^
       ((vl-string-search "\\R22.0\\" ACADPROD)
        (if IS64
         (if (setq INFILE (findfile "RFLTools_ACAD2018x64.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
         (if (setq INFILE (findfile "RFLTools_ACAD2018x86.dll"))
          (command "NETLOAD" INFILE)
          (princ "\nRFLTOOLS support dll not found...")
         )
        )
       )
       ;;2018 ^^^
 )
)
(RFL:LOADRFLDLL)
