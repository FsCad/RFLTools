;
;
;    Program Written by Robert Livingston 99/08/10
;    RFL:ELEVFIX is a utility for revising the elevations of polylines
;
;
(defun RFL:ELEVFIX (ENT Z / CLAYER ENT2 ENTLIST OSMODE ORTHOMODE P PLINETYPE)
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 (setq ORTHOMODE (getvar "ORTHOMODE"))
 (setvar "ORTHOMODE" 0)
 (setq PLINETYPE (getvar "PLINETYPE"))
 (setvar "PLINETYPE" 2)
 (setq CLAYER (getvar "CLAYER"))
 (setq ENTLIST (entget ENT))
 (setvar "CLAYER" (cdr (assoc 8 ENTLIST)))
 (cond ((= (cdr (assoc 0 ENTLIST)) "LINE")
        (progn
         (setq P (cdr (assoc 10 ENTLIST)))
         (setq ENTLIST (subst (list 10 (nth 0 P) (nth 1 P) Z) (assoc 10 ENTLIST) ENTLIST))
         (setq P (cdr (assoc 11 ENTLIST)))
         (setq ENTLIST (subst (list 11 (nth 0 P) (nth 1 P) Z) (assoc 11 ENTLIST) ENTLIST))
         (setq ENTLIST (subst (list 210 0.0 0.0 1.0) (assoc 210 ENTLIST) ENTLIST))
         (entmod ENTLIST)
         (entupd ENT)
         (command "._PEDIT" ENT "Y" "X")
         (setq ENT (entlast))
        )
       )
       ((= (cdr (assoc 0 ENTLIST)) "ARC")
        (progn
         (setq P (cdr (assoc 10 ENTLIST)))
         (setq ENTLIST (subst (list 10 (nth 0 P) (nth 1 P) Z) (assoc 10 ENTLIST) ENTLIST))
         (setq ENTLIST (subst (list 210 0.0 0.0 1.0) (assoc 210 ENTLIST) ENTLIST))
         (entmod ENTLIST)
         (entupd ENT)
         (command "._PEDIT" ENT "Y" "X")
         (setq ENT (entlast))
        )
       )
       ((= (cdr (assoc 0 ENTLIST)) "LWPOLYLINE")
        (progn
         (setq ENTLIST (subst (cons 38 Z) (assoc 38 ENTLIST) ENTLIST))
         (setq ENTLIST (subst (list 210 0.0 0.0 1.0) (assoc 210 ENTLIST) ENTLIST))
         (entmod ENTLIST)
         (entupd ENT)
        )
       )
       ((= (cdr (assoc 0 ENTLIST)) "POLYLINE")
        (progn
         (if (/= (float (/ (cdr (assoc 70 ENTLIST)) 2 2 2 2))
                 (/ (cdr (assoc 70 ENTLIST)) 16.0))
          (progn
           (setq ENT2 (entnext ENT))
           (setq ENTLIST (entget ENT2))
           (command "._PLINE")
           (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
            (setq P (cdr (assoc 10 ENTLIST)))
            (command (list (nth 0 P) (nth 1 P) Z))
            (setq ENT2 (entnext ENT2))
            (setq ENTLIST (entget ENT2))
           )
           (command "")
           (command "._ERASE" ENT "")
           (setq ENT (entlast))
          )
          (progn
           (setq ENTLIST (subst (list 10 0.0 0.0 0.0) (assoc 10 ENTLIST) ENTLIST))
           (setq ENTLIST (subst (cons 38 Z) (assoc 70 ENTLIST) ENTLIST))
           (entmod ENTLIST)
           (entupd ENT)
;           (command "._PEDIT" ENT "X")
           (command "._CONVERT" "P" "S" ENT "")
;           (setq ENTLIST (entget ENT))
;           (if (= (cdr (assoc 0 ENTLIST)) "POLYLINE") (setq ENT nil))
          )
         )
        )
       )
 )
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
 (setvar "PLINETYPE" PLINETYPE)
 (setvar "CLAYER" CLAYER)
 ENT
)
