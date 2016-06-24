;
;
;     Program written by Robert Livingston
;
;     COMMON.LSP is a subset of the master project which creates a standalone utility
;
;     RFL:STATXT is a utility for converting numbers to station text (i.e 1234.567 => "1+234.567")
;     RFL:STAPOS is the number of digits between the '+' and the '.'
;     RFL:SIGN returns -1 for -ve and +1 for +ve
;     RFL:MAKEENT subset of MakeEnt.lsp for creating DrawGridDef block
;
;
(setq RFL:STAPOS nil)
(defun RFL:SIGN (X)
 (if (< X 0)
  (eval -1)
  (eval 1)
 )
)
(defun RFL:STATXT (STA / C DIMZIN S STAH STAL)
 (if (= nil RFL:STAPOS) (if (= nil (setq RFL:STAPOS (getint "\nStation label '+' location <3> : "))) (setq RFL:STAPOS 3)))
 (setq DIMZIN (getvar "DIMZIN"))
 (setvar "DIMZIN" 8)
 (if (< RFL:STAPOS 1)
  (rtos STA)
  (progn
   (if (< STA 0.0)
    (setq S "-")
    (setq S "")
   )
   (setq STAH (fix (/ (abs STA) (expt 10 RFL:STAPOS))))
   (setq STAL (- (abs STA) (* STAH (expt 10 RFL:STAPOS))))
   (if (= (substr (rtos STAL) 1 (+ RFL:STAPOS 1)) (itoa (expt 10 RFL:STAPOS)))
    (progn
     (setq STAL 0.0)
     (setq STAH (+ STAH (RFL:SIGN STAH)))
    )
   )
   (setq STAH (itoa STAH))
   (setq C (- RFL:STAPOS (strlen (itoa (fix STAL)))))
   (setq STAL (rtos STAL 2 (getvar "LUPREC")))
   (while (> C 0)
    (setq STAL (strcat "0" STAL))
    (setq C (- C 1))
   )
   (setvar "DIMZIN" DIMZIN)
   (setq RFLSTAHTXT (strcat S STAH) RFLSTALTXT STAL)
   (strcat S STAH "+" STAL)
  )
 )
)
(defun RFL:MAKEENT (BLKNAME / BLOCKLIST NODE)
 (setq BLOCKLIST (RFL:GETBLOCKLIST BLKNAME))
 (if (/= nil BLOCKLIST)
  (progn
   (entmake)
   (foreach NODE BLOCKLIST
    (entmake NODE)
   )
  )
  nil
 )
)
(defun RFL:GETBLOCKLIST (BLKNAME)
 (cond
       ((= (strcase BLKNAME) "DRAWGRIDDEF")
        (list
         (list
          (cons 0 "BLOCK")
          (cons 2 "DrawGridDef")
          (cons 70  2)
          (list 10 0.00000000 0.00000000 0.00000000)
         )
         (list
          (cons 0 "CIRCLE")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbCircle")
          (list 10 0.00000000 0.00000000 0.00000000)
          (cons 40  1.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.35714286 -1.50000000 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Title Text : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -1.50000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.77380952 -1.90476190 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Title Text Height : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -1.90476190 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.71428571 -2.30952381 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Title Text Offset : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -2.30952381 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.42857143 -2.71428571 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Base Point 'X' : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -2.71428571 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.40476190 -3.11904762 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Base Point 'Y' : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -3.11904762 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.57142857 -3.52380952 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Grid Width : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -3.52380952 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.76190476 -3.92857143 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Grid Height : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -3.92857143 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -4.39285714 -4.33333333 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Vertical Exageration : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -4.33333333 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.78571429 -4.73809524 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Text Height : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -4.73809524 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.72619048 -5.14285714 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Text Offset : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -5.14285714 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -5.15476190 -5.54761905 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Horizontal Grid Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -5.54761905 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -6.15476190 -5.95238095 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Horizontal Fine Grid Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -5.95238095 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -6.15476190 -6.35714286 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Horizontal Grid Text Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -6.35714286 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -4.65476190 -6.76190476 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Vertical Grid Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -6.76190476 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -5.65476190 -7.16666667 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Vertical Fine Grid Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -7.16666667 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -5.65476190 -7.57142857 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Vertical Grid Text Spacing : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -7.57142857 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.58333333 -7.97619048 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Grid Layer : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -7.97619048 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.58333333 -8.38095238 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Fine Grid Layer : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -8.38095238 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -2.60714286 -8.78571429 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Text Layer : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -8.78571429 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -8.25000000 -9.19047619 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Station Text Label Flag (1 = Use '+') : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -9.19047619 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -3.08333333 -9.59523810 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Master Scale : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -9.59523810 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "TEXT")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 -10.61904762 -10.00000001 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Direction (1 = Left to Right, -1 = Right to Left) : ")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 2)
          (list 11 0.00000000 -10.00000001 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbText")
          (cons 73 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -1.50000000 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "Grid Title")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Title Text")
          (cons 2 "TITLE")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -1.90476190 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "5.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Title Text Height")
          (cons 2 "TITLEHEIGHT")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -2.30952381 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "5.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Title Text Offset")
          (cons 2 "TITLEOFFSET")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -2.71428571 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "0.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Base Point 'X'")
          (cons 2 "BX")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -3.11904762 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "0.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Base Point 'Y'")
          (cons 2 "BY")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -3.52380952 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "500.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Grid Width")
          (cons 2 "W")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -3.92857143 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "200.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Grid Height")
          (cons 2 "H")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -4.33333333 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "10.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Vertical Exageration")
          (cons 2 "VEXAG")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -4.73809524 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "2.5")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Text Height")
          (cons 2 "THEIGHT")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -5.14285714 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "2.5")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Text Offset")
          (cons 2 "TOFFSET")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -5.54761905 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "100.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Horizontal Grid Spacing")
          (cons 2 "HINC")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -5.95238095 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "20.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Horizontal Fine Grid Spacing")
          (cons 2 "HINCFINE")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -6.35714286 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "100.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Horizontal Grid Text Spacing")
          (cons 2 "HINCTEXT")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -6.76190476 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "10.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Vertical Grid Spacing")
          (cons 2 "VINC")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -7.16666667 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "1.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Vertical Fine Grid Spacing")
          (cons 2 "VINCFINE")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -7.57142857 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "10.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Vertical Grid Text Spacing")
          (cons 2 "VINCTEXT")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -7.97619048 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "PR-GRID")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Grid Layer")
          (cons 2 "LAY")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -8.38095238 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "PR-GRID-MIN")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Fine Grid Layer")
          (cons 2 "LAYFINE")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -8.78571429 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "PR-GRID-TXT")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Text Layer")
          (cons 2 "LAYTEXT")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -9.19047619 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Station Text Label Flag (1 = Use '+')")
          (cons 2 "TFLAG")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -9.59523810 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "1.0")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Master Scale")
          (cons 2 "MASTER")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list
          (cons 0 "ATTDEF")
          (cons 100 "AcDbEntity")
          (cons 67 0)
          (cons 8 "0")
          (cons 100 "AcDbText")
          (list 10 0.00000000 -10.00000001 0.00000000)
          (cons 40  0.25000000)
          (cons 1 "1")
          (cons 50  0.00000000)
          (cons 41  1.00000000)
          (cons 51  0.00000000)
          (cons 7 "Standard")
          (cons 71 0)
          (cons 72 0)
          (list 11 0.00000000 0.00000000 0.00000000)
          (list 210 0.00000000 0.00000000 1.00000000)
          (cons 100 "AcDbAttributeDefinition")
          (cons 280 0)
          (cons 3 "Direction")
          (cons 2 "DIRECTION")
          (cons 70 0)
          (cons 73 0)
          (cons 74 0)
          (cons 280 0)
         )
         (list (cons 0 "ENDBLK"))
        )
       )
       (T
        (progn
         (alert (strcat "!!! BLOCK DOES NOT EXIST - " BLKNAME " !!!"))
         nil
        )
       )
 )
)
