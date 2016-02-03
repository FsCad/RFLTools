;
;
;     Program written by Robert Livingston, 2014-04-30
;
;     TRIG is a collection of basic functions
;
;
(defun RFL:TAN (ANG)
 (eval (/ (sin ANG) (cos ANG)))
)
(defun RFL:SIGN (X)
 (if (< X 0)
  (eval -1.0)
  (eval 1.0)
 )
)
(defun RFL:ANGLE3P (P1 P2 P3 / ANG)
 (if (> (setq ANG (abs (- (angle P2 P1) (angle P2 P3)))) pi)
  (- (* 2.0 pi) ANG)
  ANG
 )
)
(defun RFL:ACOS (X)
 (/ 1.0 (sqrt (+ 1.0 (expt (atan X) 2.0))))
)
(defun RFL:ASIN (X)
 (- (/ pi 2.0) (/ 1.0 (sqrt (+ 1.0 (expt (atan X) 2.0)))))
)
(defun RFL:RADIUS3P (P1 P2 P3 / DEN NUM TOL X1 X2 X3 Y1 Y2 Y3)
 (setq TOL 1e-10)
 (setq X1 (car P1))
 (setq Y1 (cadr P1))
 (setq X2 (car P2))
 (setq Y2 (cadr P2))
 (setq X3 (car P3))
 (setq Y3 (cadr P3))
 (setq NUM (sqrt (* (+ (expt (- X2 X1) 2)
                       (expt (- Y2 Y1) 2)
                    )
                    (+ (expt (- X2 X3) 2)
                       (expt (- Y2 Y3) 2)
                    )
                    (+ (expt (- X3 X1) 2)
                       (expt (- Y3 Y1) 2)
                    )
                 )
           )
 )
 (setq DEN (* 2.0 (abs (+ (* X1 Y2)
                          (* X2 Y3)
                          (* X3 Y1)
                          (* -1.0 X1 Y3)
                          (* -1.0 X2 Y1)
                          (* -1.0 X3 Y2)
                       )
                  )
           )
 )
 (if (< DEN TOL)
  (setq R nil)
  (setq R (/ NUM DEN))
 )
)
(defun RFL:CIRCLE3P (P1 P2 P3 / CALCC3P TOL X1 X2 X3 Y1 Y2 Y3)
 
 (defun CALCC3P (X1 Y1 X2 Y2 X3 Y3 / DEN M12 M23 NUM R RES XC YC)
  (setq M12 (/ (- Y2 Y1) (- X2 X1)))
  (setq M23 (/ (- Y3 Y2) (- X3 X2)))
  (setq NUM (- (+ (* M12 M23 (- Y1 Y3)) (* M23 (+ X1 X2))) (* M12 (+ X2 X3))))
  (setq DEN (* 2.0 (- M23 M12)))
  (setq XC (/ NUM DEN))
  (setq YC (- (/ (+ Y1 Y2) 2.0) (* (/ 1.0 M12) (- XC (/ (+ X1 X2) 2.0)))))
  (setq R (sqrt (+ (expt (- X1 XC) 2.0) (expt (- Y1 YC) 2.0))))
  (list (list XC YC) R)
 )
 
 (setq TOL 1e-10)
 (setq X1 (car P1))
 (setq Y1 (cadr P1))
 (setq X2 (car P2))
 (setq Y2 (cadr P2))
 (setq X3 (car P3))
 (setq Y3 (cadr P3))
 
 (setq RES (vl-catch-all-apply 'CALCC3P (list X1 Y1 X2 Y2 X3 Y3)))
 (if (vl-catch-all-error-p RES)
  (progn
   (setq RES (vl-catch-all-apply 'CALCC3P (list X2 Y2 X3 Y3 X1 Y1)))
   (if (vl-catch-all-error-p RES)
    (progn
     (setq RES (vl-catch-all-apply 'CALCC3P (list X3 Y3 X1 Y1 X2 Y2)))
     (if (vl-catch-all-error-p RES)
      (eval nil)
      (setq RES RES)
     )
    )
    (setq RES RES)
   )
  )
  (setq RES RES)
 )
)
(defun RFL:RADIUS (P1 P2 BULGE / ATOTAL CHORD)
 (setq ATOTAL (* 4.0 (atan (abs BULGE))))
 (setq CHORD (distance P1 P2))
 (if (< (abs BULGE) TOL)
  (progn
   (eval nil)
  )
  (progn
   ;(setq R (/ CHORD (* 2 (sin (/ ATOTAL 2)))))
   (/ CHORD (* 2 (sin (/ ATOTAL 2))))
  )
 )
)
(defun RFL:CENTER (P1 P2 BULGE / ANG ATOTAL CHORD D R X Y)
 (setq ATOTAL (* 4.0 (atan (abs BULGE))))
 (setq CHORD (distance P1 P2))
 (if (< (abs BULGE) TOL)
  (progn
   (eval nil)
  )
  (progn
   (setq R (/ CHORD (* 2 (sin (/ ATOTAL 2)))))
   (setq ANG (angle P1 P2))
   (setq D (distance P1 P2))
   (setq X (/ D 2.0))
   (setq Y (* (sqrt (- (* R R) (* X X))) (SIGN BULGE) (SIGN (- (abs BULGE) 1.0))))
   (list (+ (+ (car P1) (* X (cos ANG))) (* Y (sin ANG)))
         (- (+ (cadr P1) (* X (sin ANG))) (* Y (cos ANG)))
   )
  )
 )
)
(defun RFL:COMB3 (N / A B C RES TMP)
 (setq RES nil)
 (if (>= N 3)
  (progn
   (setq A 1)
   (while (<= A (- N 2))
    (setq B (+ A 1))
    (while (<= B (- N 1))
     (setq C (+ B 1))
     (while (<= C N)
      (setq TMP (list A B C))
      (setq RES (append RES (list TMP)))
      (setq C (+ C 1))
     )
     (setq B (+ B 1))
    )
    (setq A (+ A 1))
   )
  )
 )
 (setq RES RES)
)
