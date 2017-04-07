;
;
;     Program written by Robert Livingston, 2013-05-01
;
;     RFL:SPOT2SECTION draws a rail section by selecting a N/E/Z block
;
;
(defun RFL:SPOT2SECTION (P X Y Z / ANG DX DY ELEV ENT ENTLIST LR OS PS R S STA)
 (if (= nil RFL:QUICKTRAINDEF) (RFL:SETQUICKTRAINDEF))
 (if (/= nil RFL:QUICKTRAINDEF)
  (progn
   (setq STA (RFL:STAOFF (list X Y)))
   (if (/= nil STA)
    (progn
     (setq OS (cadr STA))
     (setq STA (car STA))
     (if (= nil (setq ELEV (RFL:ELEVATION STA)))
      (setq ELEV 0.0)
     )
     (if (= nil (setq S (RFL:SUPER STA)))
      (setq S (list 0.0 0.0))
     )
     (setq DX (* -1.0 OS))
     (setq DY (+ (- ELEV Z) (/ (+ (car S) (cadr S)) 2000.0)))
     (setq ANG (atan (/ (/ (+ (* -1.0 (car S)) (cadr S)) 2.0) (/ (cdr (assoc "RAILCL" RFL:QUICKTRAINDEF)) 2.0))))
     (setq PS (list (+ (car P) DX) (+ (cadr P) DY)))
     (command "._INSERT" (cdr (assoc "SECTION" RFL:QUICKTRAINDEF)) PS 1.0 1.0 (* (/ -180.0 pi) ANG))
     (setq ENT (entlast))
     (setq ENTLIST (entget ENT))
     (setq ENTLIST (subst (cons 8 (strcat (cdr (assoc 8 ENTLIST)) (cdr (assoc "LLAYERS" RFL:QUICKTRAINDEF)))) (assoc 8 ENTLIST) ENTLIST))
     (entmod ENTLIST)
     (entupd ENT)
     (setq R (RFL:GETRADIUS STA))
     (if (> (abs R) TOL)
      (if (< R 0.0)
       (progn
        (setq OS (RFL:INSWING (cdr (assoc "WB" RFL:QUICKTRAINDEF)) (abs R)))
        (command "._INSERT"
                 (cdr (assoc "RSECTION" RFL:QUICKTRAINDEF))
                 (list (+ (car PS) (* OS (cos ANG))) (+ (cadr PS) (* OS (sin ANG))))
                 1.0 1.0 (* (/ -180.0 pi) ANG))
        (setq ENT (entlast))
        (setq ENTLIST (entget ENT))
        (setq ENTLIST (subst (cons 8 (strcat (cdr (assoc 8 ENTLIST)) (cdr (assoc "LLAYERS" RFL:QUICKTRAINDEF)))) (assoc 8 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (entupd ENT)
        (setq OS (RFL:OUTSWING (cdr (assoc "WB" RFL:QUICKTRAINDEF)) (cdr (assoc "OH" RFL:QUICKTRAINDEF)) (abs R)))
        (command "._INSERT"
                 (cdr (assoc "LSECTION" RFL:QUICKTRAINDEF))
                 (list (- (car PS) (* OS (cos ANG))) (- (cadr PS) (* OS (sin ANG))))
                 1.0 1.0 (* (/ -180.0 pi) ANG))
        (setq ENT (entlast))
        (setq ENTLIST (entget ENT))
        (setq ENTLIST (subst (cons 8 (strcat (cdr (assoc 8 ENTLIST)) (cdr (assoc "LLAYERS" RFL:QUICKTRAINDEF)))) (assoc 8 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (entupd ENT)
       )
       (progn
        (setq OS (RFL:OUTSWING (cdr (assoc "WB" RFL:QUICKTRAINDEF)) (cdr (assoc "OH" RFL:QUICKTRAINDEF)) (abs R)))
        (command "._INSERT"
                 (cdr (assoc "RSECTION" RFL:QUICKTRAINDEF))
                 (list (+ (car PS) (* OS (cos ANG))) (+ (cadr PS) (* OS (sin ANG))))
                 1.0 1.0 (* (/ -180.0 pi) ANG))
        (setq ENT (entlast))
        (setq ENTLIST (entget ENT))
        (setq ENTLIST (subst (cons 8 (strcat (cdr (assoc 8 ENTLIST)) (cdr (assoc "LLAYERS" RFL:QUICKTRAINDEF)))) (assoc 8 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (entupd ENT)
        (setq OS (RFL:INSWING (cdr (assoc "WB" RFL:QUICKTRAINDEF)) (abs R)))
        (command "._INSERT"
                 (cdr (assoc "LSECTION" RFL:QUICKTRAINDEF))
                 (list (- (car PS) (* OS (cos ANG))) (- (cadr PS) (* OS (sin ANG))))
                 1.0 1.0 (* (/ -180.0 pi) ANG))
        (setq ENT (entlast))
        (setq ENTLIST (entget ENT))
        (setq ENTLIST (subst (cons 8 (strcat (cdr (assoc 8 ENTLIST)) (cdr (assoc "LLAYERS" RFL:QUICKTRAINDEF)))) (assoc 8 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (entupd ENT)
       )
      )
     )
    )
   )
  )
 )
)