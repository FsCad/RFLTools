;
;
;     Program written by Robert Livingston, 99/06/21
;
;     C:ALIGN2PROF utilizes the (RFL:PROFPOINT) command to creat a profile from points along an alignment
;
;
(defun C:ALIGN2PROF (/ ATTREQ CMDECHO ELEV ENT ENTLIST OSMODE P1 P2 PPICK PT STATION)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq OSMODE (getvar "OSMODE"))

 (command "LINE")
 (princ "\nSelect spot elevation block :")
 (setq ENT (entsel))
 (setq PPICK (car (cdr ENT)))
 (setq PPICK (list (nth 0 PPICK) (nth 1 PPICK) 0.0))
 (setq ENT (car ENT))
 (while (/= ENT nil)
  (setq ENTLIST (entget ENT))
  (if (or (= "AECC_POINT" (cdr (assoc 0 ENTLIST)))
          (and (= 1 (cdr (assoc 66 ENTLIST)))
               (= "INSERT" (cdr (assoc 0 ENTLIST)))
          )
          (= "LINE" (cdr (assoc 0 ENTLIST)))
      )
   (progn
    (if (= "AECC_POINT" (cdr (assoc 0 ENTLIST)))
     (progn
      (setq PT (cdr (assoc 11 ENTLIST)))
      (setq ELEV (nth 2 PT))
     )
     (progn
      (if (= "LINE" (cdr (assoc 0 ENTLIST)))
       (progn
        (setq P1 (cdr (assoc 10 ENTLIST)))
        (setq P1 (list (nth 0 P1) (nth 1 P1) 0.0))
        (setq P2 (cdr (assoc 11 ENTLIST)))
        (setq P2 (list (nth 0 P2) (nth 1 P2) 0.0))
        (if (< (distance P1 PPICK) (distance P2 PPICK))
         (progn
          (setq PT P1)
          (setq ELEV (last (cdr (assoc 10 ENTLIST))))
         )
         (progn
          (setq PT P2)
          (setq ELEV (last (cdr (assoc 11 ENTLIST))))
         )
        )
       )
       (progn
        (setq PT (cdr (assoc 10 ENTLIST)))
        (setq ENT (entnext ENT))
        (setq ENTLIST (entget ENT))
        (setq ELEV nil)
        (while (/= "SEQEND" (cdr (assoc 0 ENTLIST)))
         (if (or (= "ELEV" (cdr (assoc 2 ENTLIST))) (= "ELEVATION" (cdr (assoc 2 ENTLIST))))
          (setq ELEV (atof (if (= (substr (cdr (assoc 1 ENTLIST)) 1 1) "(")
                            (substr (cdr (assoc 1 ENTLIST)) 2)
                            (cdr (assoc 1 ENTLIST))
                           )
                     )
          )
         )
         (setq ENT (entnext ENT))
         (setq ENTLIST (entget ENT))
        )
       )
      )
     )
    )
    (if (= ELEV nil)
     (princ "\n*** NO ELEVATION FOR THIS BLOCK ***")
     (progn
      (setq STATION nil)
      (setq STATION (car (RFL:STAOFF PT)))
      (if (= STATION nil)
       (princ "\n*** POINT NOT ON ALIGNMENT ***")
       (progn
        (command (RFL:PROFPOINT STATION ELEV))
       )
      )
     )
    )
   )
   (princ "\n*** NOT A VALID BLOCK ***")
  )
  (princ "\nSelect spot elevation block :")
  (setq ENT (car (entsel)))
 )
 (command "")

 (setvar "CMDECHO" CMDECHO)
 (setvar "OSMODE" OSMODE)
)