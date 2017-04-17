;
;
;     Program written by Robert Livingston, 2015-10-02
;
;     C:SIGHTDIST2CSV outputs a CSV file with the forward and back calculated maximum sight distance
;
;
(defun C:SIGHTDIST2CSV (/ *error* D1 D2 EYE INC INC2 F G GETF GETSSD MAXDIST OUTFILE R REACTION STA STAEND TARGET VDES)
 (defun *error* (msg)
  (close OUTFILE)
  (print msg)
  (setq *error* nil)
 )
 (defun GETF (VDES / )
  (cond ((<= VDES 30.0) 0.40)
        ((<= VDES 40.0) 0.38)
        ((<= VDES 50.0) 0.35)
        ((<= VDES 60.0) 0.33)
        ((<= VDES 70.0) 0.31)
        ((<= VDES 80.0) 0.30)
        ((<= VDES 90.0) 0.30)
        ((<= VDES 100.0) 0.29)
        ((<= VDES 110.0) 0.28)
        ((<= VDES 120.0) 0.28)
        ((<= VDES 130.0) 0.28)
        (T 0.28)
  )
 )
 (defun GETSSD (G / )
  (+ (* (/ 1.0 3.6) VDES REACTION)
     (/ (* VDES VDES) (* 2.0 9.81 3.6 3.6 (+ F G)))
  )
 )
 (if (= nil RFL:PVILIST)
  (princ "\n!!! NO PROFILE DEFINED !!!\n")
  (progn
   (setq VDES nil)
   (while (= (setq VDES (getdist "\nDesign speed (km/h) : ")) nil))
   (setq F (GETF VDES))
   (setq REACTION 0.0)
   (while (= REACTION 0.0)
    (setq REACTION (getdist "\nStation increment (seconds) <2.5> : "))
    (if (= REACTION nil) (setq REACTION 2.5))
   )
   (setq INC 0.0)
   (while (= INC 0.0)
    (setq INC (getdist "\nStation increment <10.0> : "))
    (if (= INC nil) (setq INC 10.0))
   )
   (setq INC2 0.0)
   (while (= INC2 0.0)
    (setq INC2 (getdist "\nSight increment <1.0> : "))
    (if (= INC2 nil) (setq INC2 1.0))
   )
   (setq TMP (+ INC (* INC (fix (/ (caar RFL:PVILIST) INC)))))
   (setq STA (getreal (strcat "\nStart Station <" (rtos TMP 2 3) "> : ")))
   (if (= nil STA) (setq STA TMP))
   (setq TMP (* INC (fix (/ (car (last RFL:PVILIST)) INC))))
   (setq STAEND (getreal (strcat "\nEnd Station <" (rtos TMP 2 3) "> : ")))
   (if (= nil STAEND) (setq STAEND TMP))
   (setq TMP 1.05)
   (setq EYE (getreal (strcat "\nEye Height <" (rtos TMP 2 3) "> : ")))
   (if (= nil EYE) (setq EYE TMP))
   (setq TMP 0.38)
   (setq TARGET (getreal (strcat "\nTarget Height <" (rtos TMP 2 3) "> : ")))
   (if (= nil TARGET) (setq TARGET TMP))
   (setq TMP 250.0)
   (setq MAXDIST (getreal (strcat "\nMaximum Sight Distance <" (rtos TMP 2 3) "> : ")))
   (if (= nil MAXDIST) (setq MAXDIST TMP))
   (princ (strcat "\nDistances stored in : " (getenv "UserProfile") "\\Documents\\" "SightDist.CSV\n"))
   (setq OUTFILE (open (strcat (getenv "UserProfile") "\\Documents\\" "SightDist.CSV") "w"))
   (princ (strcat "VDES =," (rtos VDES 2 8) "\n") OUTFILE)
   (princ (strcat "REACTION TIME =," (rtos REACTION 2 8) "\n") OUTFILE)
   (princ (strcat "F =," (rtos F 2 8) "\n") OUTFILE)
   (princ "STA,GRADE,SSD CALC AHEAD,SSD CALC BACK,SSD ACTUAL AHEAD,SSD ACTUAL BACK\n" OUTFILE)
   (while (<= STA STAEND)
    (grread T)
    (setq D1 (RFL:SIGHTDISTPROF STA 1.0 EYE TARGET INC2 MAXDIST))
    (setq D2 (RFL:SIGHTDISTPROF STA -1.0 EYE TARGET INC2 MAXDIST))
    (setq G (RFL:SLOPE STA))
    (princ (strcat (RFL:STATXT STA)
                   ", Grade = " (rtos (* G 100.0)) "%"
                   ", Calc Ahead = " (rtos (GETSSD G))
                   ", Calc Back = " (rtos (GETSSD (* -1.0 G)))
                   ", Actual Ahead = " (rtos D1)
                   ", Actual Back = " (rtos D2)
                   "\n"
           )
    )
    (princ (strcat (rtos STA 2 8) ","
                   (rtos G 2 8) ","
                   (rtos (GETSSD G) 2 8) ","
                   (rtos (GETSSD (* -1.0 G)) 2 8) ","
                   (rtos D1 2 8) ","
                   (rtos D2 2 8) "\n"
           )
           OUTFILE
    )
    (setq STA (+ STA INC))
   )
   (close OUTFILE)
  )
 )
  
 T
 )