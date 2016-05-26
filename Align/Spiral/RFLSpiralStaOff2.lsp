;
;
;    Program Written by Robert Livingston, 99/07/14
;    RFL:SPIRALSTAOFF2 returns the station and offset of a point for given data
;
;
(defun RFL:SPIRALSTAOFF2 (P PLT PLTST PST LO / A2 ALPHA F F1 F2 FCTN LS GETR OFFSET OFFSETDIRECTION P0 P1 PX PY
                                               R R1 R2 RMAX SPIRALDIRECTION SPIRALLIST STAOFFVAL STATION
                                               THETA THETA1 THETA2 THETAMAX THETAOLD TMP)
 (setq P (list (car P) (cadr P)))
 (defun GETR (VAL)
  (if (< (abs VAL) RFL:TOLFINE)
   (eval 0.0)
   (sqrt (/ A2 VAL 2.0))
  )
 )
 (defun FCTN (VAL)
  (if (< (abs VAL) RFL:TOLFINE)
   (progn
    (setq TMP PX)
   )
   (progn
    (setq TMP (+ (* (- PX (* (GETR VAL) (RFL:SPIRALFXR VAL))) (cos VAL))
                 (* SPIRALDIRECTION (- PY (* SPIRALDIRECTION (GETR VAL) (RFL:SPIRALFYR VAL))) (sin VAL))))
   )
  )
  (eval TMP)
 )
 (if (> (sin (- (angle PLTST PST) (angle PLT PLTST))) 0.0)
  (setq SPIRALDIRECTION 1.0)
  (setq SPIRALDIRECTION -1.0)
 )
 (setq ALPHA (angle PLT PLTST))
 (setq PX (+ (* (- (cadr P) (cadr PLT)) (sin ALPHA)) (* (- (car P) (car PLT)) (cos ALPHA))))
 (setq PY (- (* (- (cadr P) (cadr PLT)) (cos ALPHA)) (* (- (car P) (car PLT)) (sin ALPHA))))
 (setq THETAMAX (RFL:GETSPIRALTHETA2 PLT PLTST PST))
 (setq RMAX (RFL:GETSPIRALR2 PLT PLTST PST))
 (setq A2 (* 2.0 RMAX RMAX THETAMAX))
 (if (< (distance P PST) RFL:TOLFINE)
  (progn
   (setq THETA THETAMAX)
  )
  (progn
   (if (< (distance P PLT) RFL:TOLFINE)
    (progn
     (setq THETA 0.0)
    )
    (progn
     (setq THETA1 (/ (* LO LO) A2 2.0))
     (setq THETA2 THETAMAX)
     (setq THETA (/ (+ THETA1 THETA2) 2.0))
     (setq THETAOLD -1.0)
     (setq F1 (FCTN THETA1))
     (setq F2 (FCTN THETA2))
     (setq F (FCTN THETA))
     (while (> (abs (- THETA THETAOLD)) RFL:TOLFINE)
      (if (> (* F F2) 0.0)
       (setq THETA2 THETA)
       (setq THETA1 THETA)
      )
      (setq THETAOLD THETA)
      (setq THETA (/ (+ THETA1 THETA2) 2.0))
      (setq F1 (FCTN THETA1))
      (setq F2 (FCTN THETA2))
      (setq F (FCTN THETA))
     )
    )
   )
  )
 )
 (setq R (GETR THETA))
 (if (< (abs R) RFL:TOLFINE)
  (setq STATION 0.0)
  (setq STATION (/ A2 R))
 )
 (setq P0 (list (* R (RFL:SPIRALFXR THETA)) (* SPIRALDIRECTION R (RFL:SPIRALFYR THETA)) 0.0))
 (setq P1 (list PX PY 0.0))
 (if (> (sin (angle P0 P1)) 0.0)
  (setq OFFSETDIRECTION -1.0)
  (setq OFFSETDIRECTION 1.0)
 )
 (setq OFFSET (* OFFSETDIRECTION (distance P0 P1)))
 (setq STAOFFVAL (list STATION OFFSET))
 STAOFFVAL
)
