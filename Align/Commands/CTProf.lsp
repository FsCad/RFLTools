;
;
;   Program written by Robert Livingston, 2000/08/01
;
;   C:TPROF is a utility for drawing drawing one alignments profile onto another
;
;
(defun C:TPROF (/ ALIGNLISTFROM ALIGNLISTTO CMDECHO INC P PROFDEFTO PVILISTFROM STA STAFROM STATO Z)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)

 (command "._UNDO" "M")

 (princ "\nSelect 'FROM' alignment :\n")
 (C:RALIGN)
 (if (/= RFL:ALIGNLIST nil)
  (progn
   (setq ALIGNLISTFROM RFL:ALIGNLIST)
   (princ "\nSelect 'FROM' profile :\n")
   (C:RPROF)
   (if (/= RFL:PVILIST nil)
    (progn
     (setq PVILISTFROM RFL:PVILIST)
     (princ "\nSelect 'TO' alignment :\n")
     (C:RALIGN)
     (if (/= RFL:ALIGNLIST nil)
      (progn
       (setq ALIGNLISTTO RFL:ALIGNLIST)
       (princ "\nSelect 'TO' profile :\n")
       (RFL:PROFDEF)
       (if (/= RFL:PROFDEFLIST nil)
        (progn
         (setq PROFDEFTO RFL:PROFDEFLIST)
         (setq STAFROM (getreal "\nEnter start station ('FROM' alignment, <return> for alignment start) :"))
         (if (= STAFROM nil)
          (setq STAFROM (max (car (car ALIGNLISTFROM)) (car (car PVILISTFROM))))
         )
         (setq STATO (getreal "\nEnter end station ('FROM' alignment, <return> for alignment end) :"))
         (if (= STATO nil)
          (progn
           (setq RFL:ALIGNLIST ALIGNLISTFROM)
           (setq STATO (min (+ (car (car ALIGNLISTFROM)) (RFL:GETALIGNLENGTH)) (car (last PVILISTFROM))))
          )
         )
         (setq INC (getreal "\nEnter incrament :"))
         (setq STA STAFROM)
         (command "._PLINE")
         (while (<= STA STATO)
          (setq RFL:ALIGNLIST ALIGNLISTFROM)
          (setq P (RFL:XY (list STA 0.0)))
          (if (/= P nil)
           (progn
            (setq RFL:PVILIST PVILISTFROM)
            (setq Z (RFL:ELEVATION STA))
            (if (/= Z nil)
             (progn
              (setq RFL:ALIGNLIST ALIGNLISTTO)
              (setq P (RFL:STAOFF P))
              (if (/= P nil)
               (progn
                (setq RFL:PROFDEFLIST PROFDEFTO)
                (command "_NON" (RFL:PROFPOINT (nth 0 P) Z))
               )
              )
             )
            )
           )
          )
          (setq STA (+ STA INC))
         )
         (command "")
        )
       )
      )
     )
    )
   )
  )
 )
 (setvar "CMDECHO" CMDECHO)
)