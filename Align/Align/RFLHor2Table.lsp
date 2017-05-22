;
;
;   Program written by Robert Livingston, 2002/01/07
;
;   RFL:Hor2Table is a routine for creating and alignment table from the currently defined RFL alignment
;
;
(defun RFL:HOR2TABLE (/ *error* ANGBASE ANGC ANGH ANGDIR AL ATTREQ C1 CCOUNT CHECKCURVE CLAYER CMDECHO CURVECOUNT CURVEPI
                        DIMZIN ENT ENTLIST FLAG GETCODE GETCURVE GETLENGTH GETRADIUS GETTANGENT
                        INSERTH INSERTC INSERTCURVE
                        NAMEC NAMEH NODE NODEPI NODENEXT NODEPREV OSMODE PH PIAHEAD PIBACK PINT PTMP
                        R RNEXT REPD
                        S1 S2 SCALECX SCALECY SCALEHX SCALEHY SEARCH SIGN SPIRALPI STATXT STEPH STR1 STR2
                        TIN TMP TOL TOUT)
;(defun C:RFLHOR2TABLE ()
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
 (setq TOL 5e-12)

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
    (eval 0)
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

 (defun GETRADIUS (NODE / ATOTAL BULGE CHORD P1 P2 R)
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

 (defun STATXT (STA / DIMZIN SIGN STAH STAL)
  (setq STA (/ (fix (+ (* STA 1000.0) 0.5)) 1000.0))
  (setq DIMZIN (getvar "DIMZIN"))
  (setvar "DIMZIN" 0)
  (if (< STA 0.0)
   (setq SIGN "-")
   (setq SIGN "")
  )
  (setq STAH (fix (/ (abs STA) 1000.0)))
  (setq STAL (- (abs STA) (* STAH 1000.0)))
  (if (= (substr (rtos STAL) 1 4) "1000")
   (progn
    (setq STAL 0.0)
    (setq STAH (+ STAH (SIGN STAH)))
   )
  )
  (setq STAH (itoa STAH))
  (if (< STAL 10.0)
   (setq STAL (strcat "00" (rtos STAL 2 3)))
   (if (< STAL 100.0)
    (setq STAL (strcat "0" (rtos STAL 2 3)))
    (setq STAL (rtos STAL 2 3))
   )
  )
  (setvar "DIMZIN" DIMZIN)
  (strcat SIGN STAH "+" STAL)
 )

 (defun INSERTCURVE ()
  (setq FLAG 1)
  (setq CCOUNT (+ CCOUNT 1))
  (if (= nil C1)
   (setq C1 (list 0.0 (if (/= nil S1) (last S1) (last S2)) 0.0 0.0 0.0))
  )
  (if (and (= S1 nil) (= S2 nil))
   (INSERTC (itoa CCOUNT)
            (REPD (angtos (nth 0 C1) 1 6))
            (rtos (nth 1 C1) 2 3)
            (rtos (nth 2 C1) 2 3)
            (rtos (nth 3 C1) 2 3)
            ""
            ""
            ""
            ""
            ""
            ""
   )
   (if (and (/= S1 nil) (= S2 nil))
    (INSERTC (itoa CCOUNT)
             (REPD (angtos (nth 0 C1) 1 6))
             (rtos (nth 1 C1) 2 3)
             (rtos (nth 2 C1) 2 3)
             (rtos (nth 3 C1) 2 3)
             (strcat (if (< (abs (nth 2 S1)) TOL) "" "C") "SPIRAL IN")
             (REPD (angtos (nth 0 S1) 1 6))
             (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
             ""
             ""
             ""
    )
    (if (and (= S1 nil) (/= S2 nil))
     (INSERTC (itoa CCOUNT)
              (REPD (angtos (nth 0 C1) 1 6))
              (rtos (nth 1 C1) 2 3)
              (rtos (nth 2 C1) 2 3)
              (rtos (nth 3 C1) 2 3)
              (strcat (if (< (abs (nth 2 S2)) TOL) "" "C") "SPIRAL OUT")
              (REPD (angtos (nth 0 S2) 1 6))
              (rtos (- (nth 1 S2) (nth 2 S2)) 2 3)
              ""
              ""
              ""
     )
     (if (and (< (abs (- (nth 0 S1) (nth 0 S2))) TOL)
              (< (abs (- (nth 1 S1) (nth 1 S2))) TOL)
              (< (abs (- (nth 2 S1) (nth 2 S2))) TOL))
      (INSERTC (itoa CCOUNT)
               (REPD (angtos (nth 0 C1) 1 6))
               (rtos (nth 1 C1) 2 3)
               (rtos (nth 2 C1) 2 3)
               (rtos (nth 3 C1) 2 3)
               (strcat (if (< (abs (nth 2 S1)) TOL) "" "C") "SPIRAL DATA")
               (REPD (angtos (nth 0 S1) 1 6))
               (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
               ""
               ""
               ""
      )
      (INSERTC (itoa CCOUNT)
               (REPD (angtos (nth 0 C1) 1 6))
               (rtos (nth 1 C1) 2 3)
               (rtos (nth 2 C1) 2 3)
               (rtos (nth 3 C1) 2 3)
               (strcat (if (< (abs (nth 2 S1)) TOL) "" "C") "SPIRAL IN")
               (REPD (angtos (nth 0 S1) 1 6))
               (rtos (- (nth 1 S1) (nth 2 S1)) 2 3)
               (strcat (if (< (abs (nth 2 S2)) TOL) "" "C") "SPIRAL OUT")
               (REPD (angtos (nth 0 S2) 1 6))
               (rtos (- (nth 1 S2) (nth 2 S2)) 2 3)
      )
     )
    )
   )
  )
  (INSERTH (strcat (nth 0 PIAHEAD) "" (itoa CCOUNT) " AH")
           (RFL:STATXT (nth 1 PIAHEAD))
           (rtos (nth 2 PIAHEAD) 2 3)
           (rtos (nth 3 PIAHEAD) 2 3)
  )
  (INSERTH (strcat (nth 0 PIBACK) "" (itoa CCOUNT) " BK")
           (RFL:STATXT (nth 1 PIBACK))
           (rtos (nth 2 PIBACK) 2 3)
           (rtos (nth 3 PIBACK) 2 3)
  )
 )

 (defun INSERTC (LABEL CDELTA CRADIUS CLENGTH CTANGENT
                 SB SBTHETA SBLENGTH SA SATHETA SALENGTH / ATTREQ ENT ENTLIST)
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
     (if (= (cdr (assoc 2 ENTLIST)) "STEP")
      (progn
       (setq STEPC (atof (cdr (assoc 1 ENTLIST))))
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "LABEL")
      (progn
       (setq ENTLIST (subst (cons 1 LABEL) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "CDELTA")
      (progn
       (setq ENTLIST (subst (cons 1 CDELTA) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "CRADIUS")
      (progn
       (setq ENTLIST (subst (cons 1 CRADIUS) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "CLENGTH")
      (progn
       (setq ENTLIST (subst (cons 1 CLENGTH) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "CTANGENT")
      (progn
       (setq ENTLIST (subst (cons 1 CTANGENT) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SB")
      (progn
       (setq ENTLIST (subst (cons 1 SB) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SBTHETA")
      (progn
       (setq ENTLIST (subst (cons 1 SBTHETA) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SBLENGTH")
      (progn
       (setq ENTLIST (subst (cons 1 SBLENGTH) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SA")
      (progn
       (setq ENTLIST (subst (cons 1 SA) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SATHETA")
      (progn
       (setq ENTLIST (subst (cons 1 SATHETA) (assoc 1 ENTLIST) ENTLIST))
       (entmod ENTLIST)
       (entupd ENT)
      )
     )
     (if (= (cdr (assoc 2 ENTLIST)) "SALENGTH")
      (progn
       (setq ENTLIST (subst (cons 1 SALENGTH) (assoc 1 ENTLIST) ENTLIST))
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
    (if (/= (setq ENT (car (entsel "\nSelect point table : "))) nil)
     (progn
      (setq ENTLIST (entget ENT))
      (if (and (= (cdr (assoc 0 ENTLIST)) "INSERT") (= (cdr (assoc 66 ENTLIST)) 1))
       (progn
        (setq NAMEH (strcat (cdr (assoc 2 ENTLIST)) "DATA"))
        (setq SCALEHX (cdr (assoc 41 ENTLIST)))
        (setq SCALEHY (cdr (assoc 42 ENTLIST)))
        (setq PH (cdr (assoc 10 ENTLIST)))
        (setq ANGH (cdr (assoc 50 ENTLIST)))
        (setq STEPH nil)
        (setq ENT (entnext ENT))
        (setq ENTLIST (entget ENT))
        (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
         (if (= (cdr (assoc 2 ENTLIST)) "STEP") (setq STEPH (atof (cdr (assoc 1 ENTLIST)))))
         (setq ENT (entnext ENT))
         (setq ENTLIST (entget ENT))
        )
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
            (if (listp (last NODE))
             (INSERTH "P.O.S."
                      (RFL:STATXT (nth 0 NODE))
                      (rtos (nth 1 (nth 1 NODE)) 2 3)
                      (rtos (nth 0 (nth 1 NODE)) 2 3)
             )
             (if (< (abs (last NODE)) TOL)
              (INSERTH "P.O.T."
                       (RFL:STATXT (nth 0 NODE))
                       (rtos (nth 1 (nth 1 NODE)) 2 3)
                       (rtos (nth 0 (nth 1 NODE)) 2 3)
              )
              (INSERTH "P.O.C."
                       (RFL:STATXT (nth 0 NODE))
                       (rtos (nth 1 (nth 1 NODE)) 2 3)
                       (rtos (nth 0 (nth 1 NODE)) 2 3)
              )
             )
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
               (INSERTC (itoa CCOUNT)
                        (REPD (angtos (nth 0 C1) 1 6))
                        (rtos (nth 1 C1) 2 3)
                        (rtos (nth 2 C1) 2 3)
                        (rtos (nth 3 C1) 2 3)
                        ""
                        ""
                        ""
                        ""
                        ""
                        ""
               )
               (INSERTH (strcat "P.I. " (itoa CCOUNT))
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
                            (< CURVECOUNT 2)
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
                 (if (/= "NONE" (nth 0 (car NODEPI)))
                  (INSERTH (nth 0 (car NODEPI))
                           (RFL:STATXT (nth 1 (car NODEPI)))
                           (rtos (nth 2 (car NODEPI)) 2 3)
                           (rtos (nth 3 (car NODEPI)) 2 3)
                  )
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
            (if (listp (last NODE))
             (INSERTH "P.O.S."
                      (RFL:STATXT (+ (nth 0 NODE) (GETLENGTH NODE)))
                      (rtos (nth 1 (nth 2 NODE)) 2 3)
                      (rtos (nth 0 (nth 2 NODE)) 2 3)
             )
             (if (< (abs (last NODE)) TOL)
              (INSERTH "P.O.T."
                       (RFL:STATXT (+ (nth 0 NODE) (GETLENGTH NODE)))
                       (rtos (nth 1 (nth 2 NODE)) 2 3)
                       (rtos (nth 0 (nth 2 NODE)) 2 3)
              )
              (INSERTH "P.O.C."
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