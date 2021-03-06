;
;
;     Program written by Robert Livingston, 2013-05-01
;
;     C:SPOT2SECTION draws a rail section by selecting a N/E/Z block
;
;
(defun C:SPOT2SECTION (/ *error* ANGBASE ANGDIR ATTREQ CMDECHO ENT ENTLIST ORTHOMODE OSMODE P X Y Z)
 (command "._UNDO" "M")
 (setq ATTREQ (getvar "ATTREQ"))
 (setvar "ATTREQ" 0)
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 1)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 (setq ORTHOMODE (getvar "ORTHOMODE"))
 (setvar "ORTHOMODE" 0)

 (defun *error* (msg)
  (setvar "ATTREQ" ATTREQ)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (setvar "CMDECHO" CMDECHO)
  (setvar "OSMODE" OSMODE)
  (setvar "ORTHOMODE" ORTHOMODE)
  (print msg)
 )

 (if (= nil RFL:QUICKTRAINDEF) (RFL:SETQUICKTRAINDEF))

 (setq ENT (car (entsel "Select point reference block : ")))
 (setq ENTLIST (entget ENT))
 (if (or (/= "INSERT" (cdr (assoc 0 ENTLIST)))
         (/= 1 (cdr (assoc 66 ENTLIST)))
         (/= (strcase (cdr (assoc "REFSECTION" RFL:QUICKTRAINDEF))) (strcase (cdr (assoc 2 ENTLIST))))
     )
  (princ "\n*** Not a valid Point Reference Block ***")
  (progn
   (setq P (cdr (assoc 10 ENTLIST)))
   (setq ENT (entnext ENT))
   (setq ENTLIST (entget ENT))
   (while (= "ATTRIB" (cdr (assoc 0 ENTLIST)))
    (cond ((= "E" (cdr (assoc 2 ENTLIST)))
           (setq X (atof (cdr (assoc 1 ENTLIST))))
          )
          ((= "N" (cdr (assoc 2 ENTLIST)))
           (setq Y (atof (cdr (assoc 1 ENTLIST))))
          )
          ((= "Z" (cdr (assoc 2 ENTLIST)))
           (setq Z (atof (cdr (assoc 1 ENTLIST))))
          )
    )
   (setq ENT (entnext ENT))
   (setq ENTLIST (entget ENT))
   )
   (RFL:SPOT2SECTION P X Y Z)
  )
 )
 (setvar "ATTREQ" ATTREQ)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "CMDECHO" CMDECHO)
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
)
