;
;
;    Program Written by Robert Livingston, 99/07/14
;    RFL:DRAWSPIRAL draws a reverse engineered DCA spiral
;
;
(defun RFL:DRAWSPIRAL (PLT PLTST PST LO OS / ANG BULGE C D DIR ENTLIST ENTLISTX H
                                             L LS PT PT2 PT3 R RMAX THETA THETAMAX V X Y)
 (if (= (tblsearch "APPID" "DCA_FIGURE_XENT") nil)
  (regapp "DCA_FIGURE_XENT")
 )
 (setq ANG (angle PLT PLTST))
 (if (> (sin (- (angle PLTST PST) (angle PLT PLTST))) 0.0)
  (setq DIR 1.0)
  (setq DIR -1.0)
 )
 (setq THETAMAX (RFL:GETSPIRALTHETA2 PLT PLTST PST))
 (setq LS (RFL:GETSPIRALLS2 PLT PLTST PST))
 (setq V 10.0)
 (setq ENTLISTX (list -3 (list "DCA_FIGURE_XENT"
                               (cons 1070 200)
                               (cons 1070 400)
                               (cons 1070 600)
                               (list 1011 (car PLT) (cadr PLT) 0.0)
                               (cons 1070 601)
                               (list 1011 (car PLTST) (cadr PLTST) 0.0)
                               (cons 1070 602)
                               (list 1011 (car PST) (cadr PST) 0.0)
                               (cons 1070 300)
                               (cons 1040 LO)
                         )
                )
 )
 (setq ENTLIST (list (cons 0 "LWPOLYLINE")
                     (cons 100 "AcDbEntity")
                     (cons 100 "AcDbPolyline")
                     (cons 90 (fix (+ V 1.0)))
                     (cons 43 0.0)
                     (cons 70 128)
               )
 )
 (setq RMAX (RFL:GETSPIRALR2 PLT PLTST PST))
 (setq C 0.0)
 (while (< C (+ V 1.0))
  (setq L (+ LO (* (/ C V) (- LS LO))))
  (if (= L 0.0)
   (progn
    (setq THETA 0.0)
    (setq R 0.0)
    (setq X 0.0)
    (setq Y 0.0)
   )
   (progn
    (setq THETA (* THETAMAX (expt (/ L LS) 2)))
    (setq R (* RMAX (/ LS L)))
    (setq X (* R (RFL:SPIRALFXR THETA)))
    (setq Y (* DIR R (RFL:SPIRALFYR THETA)))
   )
  )
  (setq X (+ X (* OS DIR (sin THETA))))
  (setq Y (- Y (* OS (cos THETA))))
  (setq PT (list (+ (car PLT) (* X (cos ANG)) (* -1.0 Y (sin ANG)))
                 (+ (cadr PLT) (* X (sin ANG)) (* Y (cos ANG)))
           )
  )
  (setq L (+ LO (* (/ (+ C 0.5) V) (- LS LO))))
  (if (= L 0.0)
   (progn
    (setq THETA 0.0)
    (setq R 0.0)
    (setq X 0.0)
    (setq Y 0.0)
   )
   (progn
    (setq THETA (* THETAMAX (expt (/ L LS) 2)))
    (setq R (* RMAX (/ LS L)))
    (setq X (* R (RFL:SPIRALFXR THETA)))
    (setq Y (* DIR R (RFL:SPIRALFYR THETA)))
   )
  )
  (setq X (+ X (* OS DIR (sin THETA))))
  (setq Y (- Y (* OS (cos THETA))))
  (setq PT2 (list (+ (car PLT) (* X (cos ANG)) (* -1.0 Y (sin ANG)))
                  (+ (cadr PLT) (* X (sin ANG)) (* Y (cos ANG)))
            )
  )
  (setq L (+ LO (* (/ (+ C 1.0) V) (- LS LO))))
  (if (= L 0.0)
   (progn
    (setq THETA 0.0)
    (setq R 0.0)
    (setq X 0.0)
    (setq Y 0.0)
   )
   (progn
    (setq THETA (* THETAMAX (expt (/ L LS) 2)))
    (setq R (* RMAX (/ LS L)))
    (setq X (* R (RFL:SPIRALFXR THETA)))
    (setq Y (* DIR R (RFL:SPIRALFYR THETA)))
   )
  )
  (setq X (+ X (* OS DIR (sin THETA))))
  (setq Y (- Y (* OS (cos THETA))))
  (setq PT3 (list (+ (car PLT) (* X (cos ANG)) (* -1.0 Y (sin ANG)))
                  (+ (cadr PLT) (* X (sin ANG)) (* Y (cos ANG)))
            )
  )
  (setq D (distance PT PT3))
  (setq H (distance PT2 (list (/ (+ (car PT) (car PT3)) 2.0) (/ (+ (cadr PT) (cadr PT3)) 2.0) 0.0)))
  (setq BULGE (* DIR 2.0 (/ H D)))
  (setq ENTLIST (append ENTLIST
                        (list (append (list 10) PT)
                        (cons 42 BULGE)
                        )
                )
  )
  (setq C (+ C 1.0))
 ) 
 (setq ENTLIST (append ENTLIST (list ENTLISTX)))
 (entmake ENTLIST)
)
