;
;
;   Program written by Robert Livingston, 2002/01/07
;
;   RFLHor2Table is a routine for creating and alignment table from the currently defined RFL alignment
;
;
(defun RFL:HOR2TABLE2 (/ *error* ANGBASE ANGC ANGH ANGDIR AL ATTREQ C1 CCOUNT CHECKCURVE CLAYER CMDECHO CURVECOUNT CURVEPI
                         DIMZIN DIR ENT ENTLIST FLAG GETCODE GETCURVE GETDIR GETLENGTH GETRADIUS GETTANGENT
                         INSERTH INSERTC INSERTCURVE
                         NAMEC NAMEH NODE NODEPI NODENEXT NODEPREV OSMODE PH PIAHEAD PIBACK PINT PTMP
                         R RNEXT REPD RFLSTAPOS ROUND
                         S1 S2 SCALECX SCALECY SCALEHX SCALEHY SEARCH SIGN SPIRALPI STEPH STR1 STR2
                         TIN TMP TOL TOUT)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq CLAYER (getvar "CLAYER"))
 (setq DIMZIN (getvar "DIMZIN"))
 (setvar "DIMZIN" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 (setq ATTREQ (getvar "ATTREQ"))
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq TOL 1e-4)

 (command "._UNDO" "M")

 (command "._UCS" "W")

 (defun *error* (msg)
  (command "._UCS" "P")
  (setvar "CMDECHO" CMDECHO)
  (setvar "CLAYER" CLAYER)
  (setvar "DIMZIN" DIMZIN)
  (setvar "OSMODE" OSMODE)
  (setvar "ATTREQ" ATTREQ)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (alert msg)
  (setq *error* nil)
 )

 (setq TMP (getint "\nStation text '+' location <2> : "))
 (if (= nil TMP)
  (setq RFLSTAPOS 2)
  (setq RFLSTAPOS TMP)
 )

 (defun ROUND (X PREC / )
  (* (SIGN X) (/ (fix (+ (* (abs X) (EXPT 10.0 PREC)) 0.5)) (EXPT 10.0 PREC)))
 )
 
 (defun SIGN (X)
  (if (< X 0)
   (eval -1)
   (eval 1)
  )
 )

 (defun CHECKCURVE (NODE)
  (if (= nil NODE)
   (eval 0)
   (if (listp (last NODE))
    (eval 1) ; changed 0 to 1
    (if (< (abs (last NODE)) TOL)
     (eval 0)
     (eval 1)
    )
   )
  )
 )

 (defun GETCURVE (NODE / A2 ATOTAL BULGE CHORD D LO LS P1 P2 R THETA THETA2)
  (if (/= nil NODE)
   (progn
    (setq BULGE (last NODE))
    (setq P1 (nth 1 NODE))
    (setq P2 (nth 2 NODE))
    (if (listp BULGE)
     (progn
      (setq LS (RFL:GETSPIRALLS2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
      (if (listp (last BULGE))
       (setq LO 0.0)
       (setq LO (last BULGE))
      )
      (setq THETA (RFL:GETSPIRALTHETA2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
      (setq R (RFL:GETSPIRALR2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
      (setq A2 (* 2.0 R R THETA))
      (setq THETA2 (/ (* LO LO) A2 2.0))
      (setq THETA (- THETA THETA2))
      (if (= nil S1)
       (if (= nil C1)
        (setq S1 (list THETA LS LO R))
        (setq S2 (list THETA LS LO R))
       )
       (if (= nil S2)
        (progn
         (setq S2 (list THETA LS LO R))
        )
       )
      )
     )
     (if (< (abs BULGE) TOL)
      (progn
       (setq THETA (abs (- (angle (nth 0 TOUT) (nth 1 TOUT)) (angle (nth 0 TIN) (nth 1 TIN)))))
       (if (> THETA PI) (setq THETA (- (* 2.0 PI) THETA)))
       (setq C1 (list THETA 0.0 0.0 0.0))
      )
      (progn
       (setq ATOTAL (* 4.0 (atan (abs BULGE))))
;       (setq ATOTAL (* 4.0 (atan BULGE)))
       (setq CHORD (distance P1 P2))
       (setq R (/ CHORD (* 2 (sin (/ ATOTAL 2)))))
       (setq C1 (list ATOTAL R (* R ATOTAL) (distance P1 (CURVEPI NODE))))
      )
     )
    )
   )
  )
 )

 (defun GETCODE (NODE1 NODE2 / TMP)
  (if (or (= nil NODE1) (= nil NODE2))
   (setq TMP "NONE")
   (if (listp (last NODE1))
    (if (listp (last NODE2))
     (setq TMP "S.C./C.S.")
     (if (< (abs (last NODE2)) TOL)
      (setq TMP "S.T.")
      (setq TMP "S.C.")
     )
    )
    (if (< (abs (last NODE1)) TOL)
     (if (listp (last NODE2))
      (setq TMP "T.S.")
      (if (< (abs (last NODE2)) TOL)
       (setq TMP "P.I.")
       (setq TMP "B.C.")
      )
     )
     (if (listp (last NODE2))
      (setq TMP "C.S.")
      (if (< (abs (last NODE2)) TOL)
       (setq TMP "E.C.")
       (setq TMP "P.C.C.")
      )
     )
    )
   )
  )
  (eval TMP)
 )

 (defun GETDIR (NODE / BULGE P1 P2)
  (if (/= nil NODE)
   (progn
    (setq BULGE (cadddr NODE))
    (setq P1 (cadr NODE))
    (setq P2 (caddr NODE))
    (if (listp BULGE)
     (if (> (sin (- (angle (cadr BULGE) (caddr BULGE)) (angle (car BULGE) (cadr BULGE)))) 0.0)
      (if (< (distance P2 (caddr BULGE)) (distance P1 (caddr BULGE)))
       1
       -1
      )
      (if (< (distance P2 (caddr BULGE)) (distance P1 (caddr BULGE)))
       -1
       1
      )
     )
     (if (< (abs BULGE) TOL)
      0
      (if (< BULGE 0.0)
       -1
       1
      )
     )
    )
   )
  )
 )
 
 (defun CURVEPI (NODE / ANG ATOTAL BULGE CHORD D P1 P2 PINT)
  (setq P1 (nth 1 NODE))
  (setq P2 (nth 2 NODE))
  (setq BULGE (last NODE))
  (setq ATOTAL (* 4.0 (atan BULGE)))
  (setq CHORD (distance P1 P2))
  (setq D (/ CHORD (* 2.0 (cos (/ ATOTAL 2.0)))))
  (setq ANG (- (angle P1 P2) (/ ATOTAL 2.0)))
  (setq PINT (list (+ (nth 0 P1) (* D (cos ANG)))
                   (+ (nth 1 P1) (* D (sin ANG)))))
 )

 (defun SPIRALPI (NODE / A2 ANG BULGE DIR LO P P1 PINT R THETA THETA2)
  (setq BULGE (last NODE))
  (if (listp (setq LO (last BULGE)))
   (setq PINT (nth 1 BULGE))
   (if (< (abs LO) TOL)
    (setq PINT (nth 1 BULGE))
    (progn
     (setq DIR (SIGN (- (angle (nth 2 BULGE) (nth 1 BULGE))
                        (angle (nth 1 BULGE) (nth 0 BULGE)))))
     (setq THETA (RFL:GETSPIRALTHETA2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
     (setq R (RFL:GETSPIRALR2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
     (setq A2 (* 2.0 R R THETA))
     (setq THETA2 (/ (* LO LO) A2 2.0))
     (setq ANG (angle (nth 0 BULGE) (nth 1 BULGE)))
     (if (< (distance (nth 2 NODE) (nth 2 BULGE)) TOL)
      (setq P1 (nth 1 NODE))
      (setq P1 (nth 2 NODE))
     )
     (setq P (list (+ (nth 0 P1) (cos (+ ANG (* DIR THETA2))))
                   (+ (nth 1 P1) (sin (+ ANG (* DIR THETA2))))))
     (setq PINT (inters (nth 1 BULGE) (nth 2 BULGE) P1 P nil))
    )
   )
  )
 )

 (defun GETTANGENT (IO NODE / P1 P2)
  (if (= nil NODE)
   (setq P1 nil P2 nil)
   (if (listp (last NODE))
    (if (= IO "IN")
     (setq P1 (nth 1 NODE) P2 (SPIRALPI NODE))
     (setq P1 (SPIRALPI NODE) P2 (nth 2 NODE))
    )
    (if (< (abs (last NODE)) TOL)
     (setq P1 (nth 1 NODE) P2 (nth 2 NODE))
     (if (= IO "IN")
      (setq P1 (nth 1 NODE) P2 (CURVEPI NODE))
      (setq P1 (CURVEPI NODE) P2 (nth 2 NODE))
     )
    )
   )
  )
  (list P1 P2)
 )

 (defun GETRADIUS (NODE / ATOTAL BULGE CHORD DIR P1 P2 R)
  (if (= nil NODE)
   (setq R 0.0)
   (progn
    (setq P1 (nth 1 NODE))
    (setq P2 (nth 2 NODE))
    (setq BULGE (last NODE))
    (if (listp BULGE)
     (setq R (RFL:GETSPIRALR2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
     (if (< (abs BULGE) TOL)
      (setq R 0.0)
      (progn
       (setq ATOTAL (* 4.0 (atan (abs BULGE))))
;       (setq ATOTAL (* 4.0 (atan BULGE)))
       (setq CHORD (distance P1 P2))
       (setq R (/ CHORD (* 2 (sin (/ ATOTAL 2)))))
      )
     )
    )
   )
  )
  (eval R)
 )

 (defun GETLENGTH (NODE / ATOTAL BULGE CHORD L P1 P2 R)
  (if (= nil NODE)
   (setq L nil)
   (progn
    (setq P1 (nth 1 NODE))
    (setq P2 (nth 2 NODE))
    (setq BULGE (last NODE))
    (if (listp BULGE)
     (if (listp (last BULGE))
      (setq L (RFL:GETSPIRALLS2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)))
      (setq L (- (RFL:GETSPIRALLS2 (nth 0 BULGE) (nth 1 BULGE) (nth 2 BULGE)) (last BULGE)))
     )
     (if (< (abs BULGE) TOL)
      (setq L (distance P1 P2))
      (progn
       (setq ATOTAL (* 4.0 (atan (abs BULGE))))
;       (setq ATOTAL (* 4.0 (atan BULGE)))
       (setq CHORD (distance P1 P2))
       (setq R (/ CHORD (* 2 (sin (/ ATOTAL 2)))))
       (setq L (* R ATOTAL))
      )
     )
    )
   )
  )
  (eval L)
 )

 (defun REPD (S / TMP)
  (setq TMP (strcat (substr S 1 (- (SEARCH "d" S) 1)) "%%" (substr S (SEARCH "d" S))))
  (if (< (- (SEARCH "'" TMP) (SEARCH "d" TMP)) 3)
   (setq TMP (strcat (substr TMP 1 (SEARCH "d" TMP)) "0" (substr TMP (+ (SEARCH "d" TMP) 1))))
  )
  (if (< (- (SEARCH "." TMP) (SEARCH "'" TMP)) 3)
   (setq TMP (strcat (substr TMP 1 (SEARCH "'" TMP)) "0" (substr TMP (+ (SEARCH "'" TMP) 1))))
  )
  (setq TMP TMP)
 )

 (defun SEARCH (S L / C)
  (setq C 1)
  (while (and (/= (substr L C (strlen S)) S) (<= C (strlen L)))
   (setq C (+ C 1))
  )
  (if (> C (strlen L)) (setq C nil) (setq C C))
 )

 (defun INSERTCURVE ()
  (setq FLAG 1)
  (setq CCOUNT (+ CCOUNT 1))
  (if (= nil C1)
   (setq C1 (list 0.0 (if (/= nil S1) (last S1) (last S2)) 0.0 0.0 0.0))
  )
  (if (< 0 (sin (- (angle (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT))
                   (angle (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)))
                )
           )
      )
   (setq DIR " LT")
   (setq DIR " RT")
  )
  (if (and (= S1 nil) (= S2 nil))
   (INSERTC (strcat "CURVE " (itoa CCOUNT))
            (strcat (rtos (nth 1 C1) 2 3) DIR)
            ""
            (REPD (angtos (nth 0 C1) 1 6))
            (rtos (distance (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))) 2 3)
            (rtos (distance (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT)) 2 3)
            (rtos (nth 2 C1) 2 3)
            (rtos (abs (nth 1 (RFL:STAOFF (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))))) 2 3)
            "N/A"
            ""
            ""
            ""
            ""
            (RFL:STATXT (nth 1 PIAHEAD))
            (rtos (nth 2 PIAHEAD) 2 3)
            (rtos (nth 3 PIAHEAD) 2 3)
   )
   (if (and (/= S1 nil) (= S2 nil))
    (INSERTC (strcat "CURVE " (itoa CCOUNT))
             (strcat (rtos (nth 1 C1) 2 3) DIR)
             (REPD (angtos (+ (nth 0 C1) (nth 0 S1)) 1 6))
             (REPD (angtos (nth 0 C1) 1 6))
             (rtos (distance (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))) 2 3)
             (rtos (distance (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT)) 2 3)
             (rtos (nth 2 C1) 2 3)
             (rtos (abs (nth 1 (RFL:STAOFF (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))))) 2 3)
             "N/A"
             (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
             (REPD (angtos (nth 0 S1) 1 6))
             ""
             ""
             (RFL:STATXT (nth 1 PIAHEAD))
             (rtos (nth 2 PIAHEAD) 2 3)
             (rtos (nth 3 PIAHEAD) 2 3)
    )
    (if (and (= S1 nil) (/= S2 nil))
     (INSERTC (strcat "CURVE " (itoa CCOUNT))
              (strcat (rtos (nth 1 C1) 2 3) DIR)
              (REPD (angtos (+ (nth 0 C1) (nth 0 S2)) 1 6))
              (REPD (angtos (nth 0 C1) 1 6))
              (rtos (distance (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))) 2 3)
              (rtos (distance (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT)) 2 3)
              (rtos (nth 2 C1) 2 3)
              (rtos (abs (nth 1 (RFL:STAOFF (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))))) 2 3)
              "N/A"
              ""
              ""
              (rtos (- (nth 1 S2) (nth 2 S2)) 2 3)
              (REPD (angtos (nth 0 S2) 1 6))
              (RFL:STATXT (nth 1 PIAHEAD))
              (rtos (nth 2 PIAHEAD) 2 3)
              (rtos (nth 3 PIAHEAD) 2 3)
     )
     (if (and (< (abs (- (nth 0 S1) (nth 0 S2))) TOL)
              (< (abs (- (nth 1 S1) (nth 1 S2))) TOL)
              (< (abs (- (nth 2 S1) (nth 2 S2))) TOL))
      (INSERTC (strcat "CURVE " (itoa CCOUNT))
               (strcat (rtos (nth 1 C1) 2 3) DIR)
               (REPD (angtos (+ (nth 0 C1) (nth 0 S1) (nth 0 S2)) 1 6))
               (REPD (angtos (nth 0 C1) 1 6))
               (rtos (distance (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))) 2 3)
               (rtos (distance (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT)) 2 3)
               (rtos (nth 2 C1) 2 3)
               (rtos (abs (nth 1 (RFL:STAOFF (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))))) 2 3)
               "N/A"
               (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
               (REPD (angtos (nth 0 S1) 1 6))
               (rtos (- (nth 1 S2) (nth 2 S2)) 2 3)
               (REPD (angtos (nth 0 S2) 1 6))
               (RFL:STATXT (nth 1 PIAHEAD))
               (rtos (nth 2 PIAHEAD) 2 3)
               (rtos (nth 3 PIAHEAD) 2 3)
      )
      (INSERTC (strcat "CURVE " (itoa CCOUNT))
               (strcat (rtos (nth 1 C1) 2 3) DIR)
               (REPD (angtos (+ (nth 0 C1) (nth 0 S1) (nth 0 S2)) 1 6))
               (REPD (angtos (nth 0 C1) 1 6))
               (rtos (distance (nth 0 TIN) (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))) 2 3)
               (rtos (distance (list (nth 3 PIAHEAD) (nth 2 PIAHEAD)) (nth 1 TOUT)) 2 3)
               (rtos (nth 2 C1) 2 3)
               (rtos (abs (nth 1 (RFL:STAOFF (list (nth 3 PIAHEAD) (nth 2 PIAHEAD))))) 2 3)
               "N/A"
               (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
               (REPD (angtos (nth 0 S1) 1 6))
               (rtos (- (nth 1 S2) (nth 2 S2)) 2 3)
               (REPD (angtos (nth 0 S2) 1 6))
               (RFL:STATXT (nth 1 PIAHEAD))
               (rtos (nth 2 PIAHEAD) 2 3)
               (rtos (nth 3 PIAHEAD) 2 3)
      )
     )
    )
   )
  )
 )

 (defun INSERTC (LABEL CRADIUS DELTA CDELTA CTANGENT1 CTANGENT2 CLENGTH EXT
                 E LS1 THETA1 LS2 THETA2 PISTA PINORTHING PIEASTING
                 / ATTREQ ENT ENTLIST UPDATEFLAG)
  (setq ATTREQ (getvar "ATTREQ"))
  (setvar "ATTREQ" 0)

  (setq PC (list (+ (nth 0 PC) (* (cos ANGC) (* STEPC SCALECX)))
                 (+ (nth 1 PC) (* (sin ANGC) (* STEPC SCALECX)))
           )
  )
  (if (= nil (tblsearch "BLOCK" NAMEC)) (RFL:MAKEENT NAMEC))
  (command "._INSERT" NAMEC PC SCALECX SCALECY (* ANGC (/ 180.0 pi)))
  (setq ENT (entlast))
  (setq ENTLIST (entget ENT))
  (setq ANGC (cdr (assoc 50 ENTLIST)))
  (if (= (cdr (assoc 66 ENTLIST)) 1)
   (progn
    (setq ENT (entnext ENT))
    (setq ENTLIST (entget ENT))
    (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
     (setq UPDATEFLAG T)
     (cond ((= "STEP" (cdr (assoc 2 ENTLIST)))
            (progn
             (setq STEPC (atof (cdr (assoc 1 ENTLIST))))
             (setq UPDATEFLAG nil)
            )
           )
           ((= "LABEL" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 LABEL) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "CRADIUS" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 CRADIUS) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "DELTA" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 DELTA) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "CDELTA" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 CDELTA) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "CTANGENT1" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 CTANGENT1) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "CTANGENT2" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 CTANGENT2) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "CLENGTH" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 CLENGTH) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "EXT" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 EXT) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "E" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 E) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "LS1" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 LS1) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "THETA1" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 THETA1) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "LS2" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 LS2) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "THETA2" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 THETA2) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "PISTA" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 PISTA) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "PINORTHING" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 PINORTHING) (assoc 1 ENTLIST) ENTLIST))
           )
           ((= "PIEASTING" (cdr (assoc 2 ENTLIST)))
            (setq ENTLIST (subst (cons 1 PIEASTING) (assoc 1 ENTLIST) ENTLIST))
           )
           (T (setq UPDTAEFLAG nil))
     )
     (if UPDATEFLAG
      (progn
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (setq ENT (entnext ENT))
     (setq ENTLIST (entget ENT))
    )
   )
  )
  (setvar "ATTREQ" ATTREQ)
 )

 (defun INSERTH (PNT STA NORTHING EASTING / ATTREQ ENT ENTLIST)
  (setq ATTREQ (getvar "ATTREQ"))
  (setvar "ATTREQ" 0)

  (setq PH (list (+ (nth 0 PH) (* (sin ANGH) (* STEPH SCALEHY)))
                 (- (nth 1 PH) (* (cos ANGH) (* STEPH SCALEHY)))
           )
  )
  (if (= nil (tblsearch "BLOCK" NAMEH)) (RFL:MAKEENT NAMEH))
  (command "._INSERT" NAMEH PH SCALEHX SCALEHY (* ANGH (/ 180.0 pi)))
  (setq ENT (entlast))
  (setq ENTLIST (entget ENT))
  (setq ANGH (cdr (assoc 50 ENTLIST)))
  (if (= (cdr (assoc 66 ENTLIST)) 1)
   (progn
    (setq ENT (entnext ENT))
    (setq ENTLIST (entget ENT))
    (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
     (if (= (cdr (assoc 2 ENTLIST)) "STEP")
      (progn
       (setq STEPH (atof (cdr (assoc 1 ENTLIST))))
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "PNT")
      (progn
       (setq ENTLIST (subst (cons 1 PNT) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "STA")
      (progn
       (setq ENTLIST (subst (cons 1 STA) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "NORTHING")
      (progn
       (setq ENTLIST (subst (cons 1 NORTHING) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "EASTING")
      (progn
       (setq ENTLIST (subst (cons 1 EASTING) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (setq ENT (entnext ENT))
     (setq ENTLIST (entget ENT))
    )
   )
  )

  (setvar "ATTREQ" ATTREQ)
 )

 (if (= nil (tblsearch "BLOCK" "ALTABLE01"))
  (progn
   (RFL:MAKEENT "ALTABLE01")
   (princ "\nCreating block: ALTABLE01")
  )
 )
 (if (= nil (tblsearch "BLOCK" "CURVETABLE"))
  (progn
   (RFL:MAKEENT "CURVETABLE")
   (princ "\nCreating block: CURVETABLE")
  )
 )

 (if (= RFL:GETSPIRALR nil)
  (alert "Alignment utilities not loaded!")
  (if (= RFL:ALIGNLIST nil)
   (alert "No alignment defined!")
   (progn
    (setq TMP (fix (/ (car (car RFL:ALIGNLIST)) 1000.0)))
    (if (= (* (fix (/ (float TMP) 10.0)) 10) TMP) (setq TMP (+ TMP 1)))
    (setq CCOUNT (getint (strcat "\nEnter start curve number <" (itoa TMP) "> :")))
    (if (= CCOUNT nil) (setq CCOUNT TMP))
    (setq CCOUNT (- CCOUNT 1))
    (setq AL RFL:ALIGNLIST)
    (setq NODEPREV nil)
    (setq NODE (car AL))
    (setq NODENEXT (car (cdr AL)))
    (if (/= (setq ENT (car (entsel "\nSelect curve table : "))) nil)
     (progn
      (setq ENTLIST (entget ENT))
      (if (and (= (cdr (assoc 0 ENTLIST)) "INSERT") (= (cdr (assoc 66 ENTLIST)) 1))
       (progn
        (setq NAMEC (strcat (cdr (assoc 2 ENTLIST)) "DATA"))
        (setq SCALECX (cdr (assoc 41 ENTLIST)))
        (setq SCALECY (cdr (assoc 42 ENTLIST)))
        (setq PC (cdr (assoc 10 ENTLIST)))
        (setq ANGC (cdr (assoc 50 ENTLIST)))
        (setq STEPC nil)
        (setq ENT (entnext ENT))
        (setq ENTLIST (entget ENT))
        (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
         (if (= (cdr (assoc 2 ENTLIST)) "STEP") (setq STEPC (atof (cdr (assoc 1 ENTLIST)))))
         (setq ENT (entnext ENT))
         (setq ENTLIST (entget ENT))
        )
        (INSERTC "START"
                 ""
                 ""
                 ""
                 ""
                 ""
                 ""
                 ""
                 "N/A"
                 ""
                 ""
                 ""
                 ""
                 (RFL:STATXT (nth 0 NODE))
                 (rtos (nth 1 (nth 1 NODE)) 2 3)
                 (rtos (nth 0 (nth 1 NODE)) 2 3)
        )
        (while (/= NODE nil)
         (setq R (GETRADIUS NODE))
         (setq RNEXT (GETRADIUS NODENEXT))
         (if (and (= R 0.0) (= RNEXT 0.0) (/= NODENEXT nil))
          (progn
           (setq TIN (GETTANGENT "IN" NODE))
           (setq TOUT (GETTANGENT "OUT" NODENEXT))
           (setq CCOUNT (+ CCOUNT 1))
           (GETCURVE NODE)
           (INSERTC (strcat "CURVE " (itoa CCOUNT))
                    ""
                    (REPD (angtos (nth 0 C1) 1 6))
                    ""
                    ""
                    ""
                    ""
                    ""
                    "N/A"
                    ""
                    ""
                    ""
                    ""
                    (RFL:STATXT (+ (nth 0 NODE) (GETLENGTH NODE)))
                    (rtos (nth 1 (nth 2 NODE)) 2 3)
                    (rtos (nth 0 (nth 2 NODE)) 2 3)
           )
           (setq NODEPREV NODE)
           (setq AL (cdr AL))
           (setq NODE (car AL))
           (setq NODENEXT (car (cdr AL)))
          )
          (if (= R 0.0)
           (progn
            (setq NODEPREV NODE)
            (setq AL (cdr AL))
            (setq NODE (car AL))
            (setq NODENEXT (car (cdr AL)))
           )
           (progn
            (setq NODEPI nil)
            (setq TIN (GETTANGENT "IN" NODE))
            (setq TOUT (GETTANGENT "OUT" NODE))
            (setq S1 nil S2 nil C1 nil)
            (setq CURVECOUNT (CHECKCURVE NODE))
            (GETCURVE NODE)
            (setq NODEPI (append NODEPI (list (list (GETCODE NODEPREV NODE)
                                                    (nth 0 NODE)
                                                    (nth 1 (nth 1 NODE))
                                                    (nth 0 (nth 1 NODE))
                                              )
                                        )
                         )
            )
            (setq CURVECOUNT (+ CURVECOUNT (CHECKCURVE NODENEXT)))
            (while (and (< (abs (- R RNEXT)) TOL)
                        (= (GETDIR NODE) (GETDIR NODENEXT))
                        (< CURVECOUNT 4) ; changed 2 to 4
                   )
             (setq NODEPREV NODE)
             (setq AL (cdr AL))
             (setq NODE (car AL))
             (setq NODENEXT (car (cdr AL)))
             (setq TOUT (GETTANGENT "OUT" NODE))
             (setq R RNEXT)
             (setq RNEXT (GETRADIUS NODENEXT))
             (GETCURVE NODE)
             (setq NODEPI (append NODEPI (list (list (GETCODE NODEPREV NODE)
                                                     (nth 0 NODE)
                                                     (nth 1 (nth 1 NODE))
                                                     (nth 0 (nth 1 NODE))
                                               )
                                         )
                          )
             )
             (setq CURVECOUNT (+ CURVECOUNT (CHECKCURVE NODENEXT)))
            )
            (if (= RNEXT 0.0)
             (setq NODEPI (append NODEPI (list (list (GETCODE NODE NODENEXT)
                                                     (+ (nth 0 NODE) (GETLENGTH NODE))
                                                     (nth 1 (nth 2 NODE))
                                                     (nth 0 (nth 2 NODE))
                                               )
                                         )
                          )
             )
            )
            (setq PINT (inters (nth 0 TIN) (nth 1 TIN) (nth 0 TOUT) (nth 1 TOUT) nil))
            (setq PTMP (list (nth 1 (cdr (cdr (car NODEPI)))) (nth 0 (cdr (cdr (car NODEPI))))))
            (setq PIAHEAD (list "P.I."
                                (+ (nth 1 (car NODEPI)) (distance PTMP PINT))
                                (nth 1 PINT)
                                (nth 0 PINT)
                          )
            )
            (setq PTMP (list (nth 1 (cdr (cdr (last NODEPI)))) (nth 0 (cdr (cdr (last NODEPI))))))
            (setq PIBACK (list "P.I."
                               (- (+ (nth 0 NODE) (GETLENGTH NODE)) (distance PTMP PINT))
                               (nth 1 PINT)
                               (nth 0 PINT)
                         )
            )
            (setq FLAG 0)
            (while (/= nil NODEPI)
             (if (and (= FLAG 0) (> (nth 1 (car NODEPI)) (nth 1 PIAHEAD)))
              (INSERTCURVE)
             )
             (setq NODEPI (cdr NODEPI))
            )
            (if (= FLAG 0)
             (INSERTCURVE)
            )
            (setq NODEPREV NODE)
            (setq AL (cdr AL))
            (setq NODE (car AL))
            (setq NODENEXT (car (cdr AL)))
           )
          )
         )         
        )
        (if (= NODE nil) (setq NODE NODEPREV))
        (INSERTC "END"
                 ""
                 ""
                 ""
                 ""
                 ""
                 ""
                 ""
                 "N/A"
                 ""
                 ""
                 ""
                 ""
                 (RFL:STATXT (+ (nth 0 NODE) (GETLENGTH NODE)))
                 (rtos (nth 1 (nth 2 NODE)) 2 3)
                 (rtos (nth 0 (nth 2 NODE)) 2 3)
        )
       )
      )
     )
    )
   )
  )
 )

 (command "._UCS" "P")
 (setvar "CMDECHO" CMDECHO)
 (setvar "CLAYER" CLAYER)
 (setvar "DIMZIN" DIMZIN)
 (setvar "OSMODE" OSMODE)
 (setvar "ATTREQ" ATTREQ)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
)