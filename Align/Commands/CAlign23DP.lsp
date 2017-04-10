;
;
;     Program written by Robert Livingston, 05-09-15
;
;     C:ALIGN23DP creats a 3D polyline based on an alignment and profile
;
;
(defun C:ALIGN23DP (/ *error* ANGDIR ANGBASE CMDECHO OSMODE P REGENMODE STEP STA STA1 STA2 STAMIN STAMAX Z1 Z2)
 (setq REGENMODE (getvar "REGENMODE"))
 (setvar "REGENMODE" 1)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 
 (command "._UNDO" "M")

 (defun *error* (msg)
  (setvar "REGENMODE" REGENMODE)
  (setvar "CMDECHO" CMDECHO)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (setvar "OSMODE" OSMODE)
  (setq *error* nil)
  (print msg)
 )

 (if (and (/= nil RFL:ALIGNLIST) (= nil RFL:PVILIST))
  (progn
   (princ "\nNo vertical alignment exists - setting up interpretation...")
   (setq STA1 (car (RFL:STAOFF (setq Z1 (getpoint "\nSelect point near start of alignment : ")))))
   (if (= nil STA1)
    (princ "Problem computing station...")
    (progn
     (setq Z1 (caddr Z1))
     (if (= Z1 0.0)
      (progn
       (setq Z1 (getreal "\n0.000 elevation found for start point, press <return> to accept or enter another value : "))
       (if (= nil Z1) (setq Z1 0.0))
      )
     )
     (setq STA2 (car (RFL:STAOFF (setq Z2 (getpoint "\nSelect point near end of alignment : ")))))
     (if (= nil STA2)
      (princ "Problem computing station...")
      (progn
       (setq Z2 (caddr Z2))
       (if (= Z2 0.0)
        (progn
         (setq Z2 (getreal "\n0.000 elevation found for end point, press <return> to accept or enter another value : "))
         (if (= nil Z2) (setq Z2 0.0))
        )
       )
       (setq RFL:PVILIST (list (list STA1 Z1 "L" 0.0) (list STA2 Z2 "L" 0.0)))
      )
     )
    )
   )
  )
 )

 (if (or (= nil RFL:ALIGNLIST) (= nil RFL:PVILIST))
  (alert "Profile and/or Alignment not defined")
  (progn
   (setq STEP 0.0)
   (while (= 0.0 STEP) (setq STEP (getdist "Enter step size (> zero) : ")))
   (setq STAMIN (max (caar RFL:ALIGNLIST) (caar RFL:PVILIST)))
   (setq STAMAX (min (+ (caar RFL:ALIGNLIST) (RFL:GETALIGNLENGTH)) (caar (reverse RFL:PVILIST))))
   (setq STA STAMIN)
   (command "._3DPOLY")
   (while (< STA STAMAX)
    (setq P (append (RFL:XY (list STA 0.0)) (list (RFL:ELEVATION STA))))
    (command P)
    (setq STA (+ STA STEP))
   )
   (if (/= STAEND (+ STA STEP))
    (progn
     (setq P (append (RFL:XY (list STAEND 0.0)) (list (RFL:ELEVATION STAEND))))
     (command P)
    )
   )
   (command "")
  )
 )

 (setvar "REGENMODE" REGENMODE)
 (setvar "CMDECHO" CMDECHO)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
)