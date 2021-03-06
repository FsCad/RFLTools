;
;
;     Program written by Robert Livingston, 2015-02-20
;
;     C:PPGRADE is a routine for finding a polyline with constant grade along a surface between two selected points
;
;
(defun C:PPGRADE (/ *error* ALSAVE ANG ANGBASE ANGDIR C CMDECHO D GETL GETOS INC L NODE NSEGS OBSURFACE OGLIST OS OSLIST OSMAX OSMODE P1 P2 REP SLOPE SWATH TMP TOL Z Z1 Z2)
;(defun C:PPGRADE ()
 (command "._UNDO" "M")
 (command "._UCS" "W")
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq ALSAVE RFL:ALIGNLIST)

 (defun *error* (msg)
  (command "._UCS" "P")
  (setvar "CMDECHO" CMDECHO)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (setvar "OSMODE" OSMODE)
  (setq RFL:ALIGNLIST ALSAVE)
  (setq *error* nil)
  (print msg)
 )

 (defun GETOS (Z PLIST OS / C OSBEST P1 P2 TMP)
  (setq OSBEST nil)
  (setq P1 (list (/ SWATH -2.0) Z))
  (setq P2 (list (/ SWATH 2.0) Z))
  (setq C 0)
  (while (< (+ C 1) (length PLIST))
   (setq TMP (inters P1 P2 (nth C PLIST) (nth (+ C 1) PLIST)))
   (if (/= nil TMP)
    (if (= nil OSBEST)
     (setq OSBEST (car TMP))
     (if (< (abs (- (car TMP) OS)) (abs OSBEST))
      (setq OSBEST (car TMP))
     )
    )
   )
   (setq C (+ C 1))
  )
  (eval OSBEST)
 )
 
 (defun GETL (/ C L)
  (setq L 0.0)
  (setq C 1)
  (while (< C (length OSLIST))
   (setq L (+ L (sqrt (+ (expt INC 2) (expt (- (nth C OSLIST) (nth (- C 1) OSLIST)) 2)))))
   (setq C (+ C 1))
  )
  (setq L (+ L (sqrt (+ (expt INC 2) (expt (nth (- C 1) OSLIST) 2)))))
 )
 
 (setq TOL 0.1)
 (setq MAXOS (* 2.0 TOL))
 
 (if (/= nil (setq P1 (getpoint "\nFirst point : ")))
  (if (/= nil (setq P2 (getpoint "\nSecond point : ")))
   (if (/= nil (setq OBSURFACE (RFL:GETC3DSURFACE)))
    (progn
     (setq P1 (list (car P1) (cadr P1)))
     (setq Z1 (RFL:GETSURFACEPOINT P1 OBSURFACE))
     (setq P2 (list (car P2) (cadr P2)))
     (setq Z2 (RFL:GETSURFACEPOINT P2 OBSURFACE))
     (setvar "OSMODE" 0)
     (setq D (distance P1 P2))
     (setq NSEGS 0)
     (while (< NSEGS 2)
      (setq NSEGS (getint "\nNumber of segments (2 minimum) <10> : "))
      (if (= nil NSEGS) (setq NSEGS 10))
     )
     (setq INC (/ D NSEGS))
     (setq NSEGS (- NSEGS 1))
     (setq SWATH (float (fix (/ D NSEGS))))
     (setq SWATH 500.0)
     (setq REP (getdist (strcat "\nEnter swath width : <" (rtos SWATH) "> : ")))
     (if (/= nil REP) (setq SWATH REP))
     (setq RFL:ALIGNLIST (list (list 0.0 P1 P2 0.0)))
     (setq TMP (RFL:GETSECTIONSET INC
                                  (* INC NSEGS)
                                  SWATH
                                  INC
                                  OBSURFACE
                                  RFL:ALIGNLIST
               )
     )
     (setq OSLIST (list 0.0))
     (setq OGLIST nil)
     (setq C 0)
     (while (< C NSEGS)
      (setq OGLIST (append OGLIST (list (cadr (nth C TMP)))))
      (setq OSLIST (append OSLIST (list 0.0)))
      (setq C (+ C 1))
     )
     (while (> MAXOS TOL)
      (setq MAXOS nil)
      (setq TMP (list 0.0))
      (setq SLOPE (/ (- Z2 Z1) (GETL)))
      (setq L 0.0)
      (setq Z Z1)
      (setq C 1)
      (while (< C (length OSLIST))
       (setq L (sqrt (+ (expt INC 2) (expt (- (nth C OSLIST) (nth (- C 1) OSLIST)) 2))))
       (setq Z (+ Z (* SLOPE L)))
       (setq OS (GETOS Z (nth (- C 1) OGLIST) (nth C OSLIST)))
       (setq TMP (append TMP (list OS)))
       (if (= nil MAXOS)
        (setq MAXOS (abs (- OS (nth C OSLIST))))
        (if (> (abs (- OS (nth C OSLIST))) MAXOS)
         (setq MAXOS (abs (- OS (nth C OSLIST))))
        )
       )
       (setq C (+ C 1))
      )
      (setq OSLIST TMP)
     )
     (princ (strcat "\nFinal slope = " (rtos (* SLOPE 100.0)) "%"))
     (command "._PLINE" P1)
     (setq C 1)
     (while (< C (length OSLIST))
      (command (RFL:XY (list (* C INC) (nth C OSLIST))))
      (setq C (+ C 1))
     )
     (command P2 "")
    )
   )
  )
 )

 (command "._UCS" "P")
 (setvar "CMDECHO" CMDECHO)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
 (setq RFL:ALIGNLIST ALSAVE)
 (eval nil)
)
