;
;
;     Program written by Robert Livingston, 2015/03/16
;
;     BESTARC is a utility for finding best fit arc along a selected polyline
;
;
(defun C:BESTARC (/ *error* ANG1 ANG2 ANGBASE ANGDIR ATTREQ C C1 C2 CMDECHO ENT ENTLIST ORTHOMODE OSMODE P P1 P2 PC PLIST R TMP)
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

 (setq PLIST nil)
 (setq ENT (car (entsel "\nSelect polyline : ")))
 (setq ENTLIST (entget ENT))
 (if (= "LWPOLYLINE" (cdr (assoc 0 ENTLIST)))
  (while (/= nil ENTLIST)
   (if (= 10 (caar ENTLIST))
     (setq PLIST (append PLIST (list (cdar ENTLIST))))
   )
   (setq ENTLIST (cdr ENTLIST))
  )
  (if (= "POLYLINE" (cdr (assoc 0 ENTLIST)))
   (progn
    (setq ENT (entnext ENT))
    (setq ENTLIST (entget ENT))
    (while (= "VERTEX" (cdr (assoc 0 ENTLIST)))
     (setq P (cdr (assoc 10 ENTLIST)))
     (setq PLIST (append PLIST (list (list (car P) (cadr P)))))
     (setq ENT (entnext ENT))
     (setq ENTLIST (entget ENT))
    )
   )
  )
 )
 (if (/= nil PLIST)
  (progn
   (setq P1 (getpoint "\nPick point near desired start vertex (<return> for entire polyline) : "))
   (if (/= P1 nil)
    (progn
     (setq P2 nil)
     (while (= nil P2) (setq P2 (getpoint "\nPick point near desired end vertex : ")))
     (setq C 0)
     (setq C1 0)
     (setq C2 0)
     (while (< C (length PLIST))
      (if (< (distance P1 (nth C PLIST)) (distance P1 (nth C1 PLIST))) (setq C1 C))
      (if (< (distance P2 (nth C PLIST)) (distance P2 (nth C2 PLIST))) (setq C2 C))
      (setq C (+ C 1))
     )
     (if (< C2 C1)
      (setq TMP C2 C2 C1 C1 TMP)
     )
     (setq TMP PLIST)
     (setq PLIST nil)
     (setq C C1)
     (while (< C C2)
      (setq PLIST (append PLIST (list (nth C TMP))))
      (setq C (+ C 1))
     )
    )
   )
   (if (>= (length PLIST) 2)
    (progn
     (setq TMP (BESTARC PLIST))
     ;(setq R (getreal (strcat "\nRadius <" (rtos (RFL:RADIUS (car TMP) (cadr TMP) (caddr TMP))) "> : ")))
     ;(if (/= nil R) (setq TMP (BESTARCR R PLIST)))
     (if (> (abs (last TMP)) TOL)
      (progn
       (setq PC (RFL:CENTER (car TMP) (cadr TMP) (caddr TMP)))
       (setq R (RFL:RADIUS (car TMP) (cadr TMP) (caddr TMP)))
       (if (> (last TMP) 0.0)
        (progn
         (setq ANG1 (angle PC (car TMP)))
         (setq ANG2 (angle PC (cadr TMP)))
        )
        (progn
         (setq ANG2 (angle PC (car TMP)))
         (setq ANG1 (angle PC (cadr TMP)))
        )
       )
       (setq ENTLIST (list (cons 0 "ARC")
                           (list 10 (car PC) (cadr PC) 0.0)
                           (cons 40 R)
                           (cons 50 ANG1)
                           (cons 51 ANG2)
                     )
       )
       (entmake ENTLIST)
      )
      (progn
       (setq ENTLIST (list (cons 0 "LINE")
                           (list 10 (caar TMP) (cadar TMP) 0.0)
                           (list 11 (caadr TMP) (cadadr TMP) 0.0)
                     )
       )
       (entmake ENTLIST)
      )
     )
    )
   )
  )
 )

 (setvar "ATTREQ" ATTREQ)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "CMDECHO" CMDECHO)
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
)
(defun BESTARC (PLIST / ANG BULGE COUNT D P P1 P2 SO TOL)
 (setq TOL 0.000000001)
 (defun SO (P P1 P2 BULGE / ANG ANG1 ANG2 CALCSUME2 D D1 D2 D11 D22 OFFSET PC R STA SUME2 SUME2T1 SUME2T2 SUME2T3 SUME2T4 SUME2T5 SUME2T6 TOL)
  (setq TOL 0.000000001)
  (if (< (abs BULGE) TOL)
   (progn
    (setq D (distance P1 P2))
    (setq D1 (distance P1 P))
    (setq D2 (distance P2 P))
    (setq D11 (/ (+ (* D D)
                    (- (* D1 D1)
                       (* D2 D2)
                    )
                 )
                 (* 2.0 D)
              )
    )
    (setq STA D11)
    (setq OFFSET (sqrt (abs (- (* D1 D1) (* D11 D11)))))
    (setq ANG (- (angle P1 P2) (angle P1 P)))
    (while (< ANG 0.0) (setq ANG (+ ANG (* 2.0 pi))))
    (if (> ANG (/ pi 2.0)) (setq OFFSET (* OFFSET -1.0)))
   )
   (progn
    (setq PC (RFL:CENTER P1 P2 BULGE))
    (if (< BULGE 0.0)
     (setq ANG1 (- (angle PC P1) (angle PC P)))
     (setq ANG1 (- (angle PC P) (angle PC P2)))
    )
    (while (< ANG1 0.0) (setq ANG1 (+ ANG1 (* 2.0 pi))))
    (setq R (RFL:RADIUS P1 P2 BULGE))
    (setq STA (* R ANG1))
    (setq OFFSET (- (distance PC P) R))
    (if (< BULGE 0.0) (setq OFFSET (* -1.0 OFFSET)))
   )
  )
  (list STA OFFSET)
 )
 (defun CALCSUME2 (P1 P2 BULGE PLIST / P SUME2)
  (setq SUME2 0.0)
  (foreach P PLIST
   (setq SUME2 (+ SUME2 (expt (cadr (SO P P1 P2 BULGE)) 2)))
  )
  (eval SUME2)
 )
 
 (setq P1 (car PLIST))
 (setq P2 (last PLIST))
 (setq ANG (angle P1 P2))
 (setq D (distance P1 P2))
 (setq BULGE 0.0)
 (setq SUME2 (CALCSUME2 P1 P2 BULGE PLIST))
 (setq COUNT 0)
 (while (> D TOL)
  (setq SUME2T1 (CALCSUME2 (list (+ (car P1) (* D (sin ANG))) (- (cadr P1) (* D (cos ANG)))) P2 BULGE PLIST))
  (setq SUME2T2 (CALCSUME2 (list (- (car P1) (* D (sin ANG))) (+ (cadr P1) (* D (cos ANG)))) P2 BULGE PLIST))
  (setq SUME2T3 (CALCSUME2 P1 (list (+ (car P2) (* D (sin ANG))) (- (cadr P2) (* D (cos ANG)))) BULGE PLIST))
  (setq SUME2T4 (CALCSUME2 P1 (list (- (car P2) (* D (sin ANG))) (+ (cadr P2) (* D (cos ANG)))) BULGE PLIST))
  (setq SUME2T5 (CALCSUME2 P1 P2 (+ BULGE (/ D 1000.0)) PLIST))
  (setq SUME2T6 (CALCSUME2 P1 P2 (- BULGE (/ D 1000.0)) PLIST))
  (setq SUME2 (min SUME2 SUME2T1 SUME2T2 SUME2T3 SUME2T4 SUME2T5 SUME2T6))
  (cond ((= SUME2 SUME2T1) (setq P1 (list (+ (car P1) (* D (sin ANG))) (- (cadr P1) (* D (cos ANG))))))
        ((= SUME2 SUME2T2) (setq P1 (list (- (car P1) (* D (sin ANG))) (+ (cadr P1) (* D (cos ANG))))))
        ((= SUME2 SUME2T3) (setq P2 (list (+ (car P2) (* D (sin ANG))) (- (cadr P2) (* D (cos ANG))))))
        ((= SUME2 SUME2T4) (setq P2 (list (- (car P2) (* D (sin ANG))) (+ (cadr P2) (* D (cos ANG))))))
        ((= SUME2 SUME2T5) (setq BULGE (+ BULGE (/ D 1000.0))))
        ((= SUME2 SUME2T6) (setq BULGE (- BULGE (/ D 1000.0))))
        (T (setq D (/ D 2.0)))
  )
  (setq COUNT (+ COUNT 1))(if (= 10000 COUNT) (exit))
 )
 
 (list P1 P2 BULGE)
)
