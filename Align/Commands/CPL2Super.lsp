;
;
;     Program written by Robert Livingston, 2015-10-09
;
;     PL2SUPER estimates superelevations based on selected 3D polylines
;
;
(defun C:PL2SUPER (/ *error* ALPLALPLLIST ALSAVE C ENT ENTLIST INC MP:Echo NODE ORTHOMODE OS OSMODE P P1 P2 P3 PC PL PR PLISTCENTER PLISTLEFT PLISTRIGHT PLIST PVIPL PVIPLLIST PVISAVE S STA STAEND SWATH TMP TOL Z Z1 Z2 ZLIST ZMAX)
;(defun C:PL2SUPER ()
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 (setq ORTHOMODE (getvar "ORTHOMODE"))
 (setvar "ORTHOMODE" 0)
 
 (setq TOL 0.00001)
 
 (defun *error* (msg)
  (setq RFL:ALIGNLIST ALSAVE)
  (setq PVISAVE RFL:PVILIST)
  (setvar "OSMODE" OSMODE)
  (setvar "ORTHOMODE" ORTHOMODE)
  (print msg)
  (setq *error* nil)
 )

 (defun MP:Echo ( x / cmdecho millisecs ceiling )

     (cond
         (   (null (setq ceiling 2000 millisecs (getvar 'millisecs)))
         )
         (   (/= 'int (type *MP:Echo:MilliSecs*))
             (setq *MP:Echo:MilliSecs* millisecs)
         )
         (   (< ceiling (- millisecs *MP:Echo:MilliSecs*))
             (setq cmdecho (getvar 'cmdecho))
             (setvar 'cmdecho 0)
             (vl-cmdf ".delay" 0)
             (setvar 'cmdecho cmdecho)
             (setq *MP:Echo:MilliSecs* millisecs)
         )
     )

     (if (eq 'str (type x)) 
         (setvar 'modemacro (vl-string-trim "\n\r\t" x))
     )

     (princ x)

     (princ)

 ) 

 
 (setq ALSAVE RFL:ALIGNLIST)
 (setq PVISAVE RFL:PVILIST)
 (if (= nil RFL:ALIGNLIST)
  (princ "\n!!! NO ALIGNMENT DEFINED !!!\n")
  (progn
   (setq INC 0.0)
   (while (= INC 0.0)
    (setq INC (getdist "\nStation increment <10.0> : "))
    (if (= INC nil) (setq INC 10.0))
   )
   (setq TMP (+ INC (* INC (fix (/ (caar RFL:ALIGNLIST) INC)))))
   (setq STA (getreal (strcat "\nStart Station <" (rtos TMP 2 3) "> : ")))
   (if (= nil STA) (setq STA TMP))
   (setq TMP (* INC (fix (/ (+ (caar RFL:ALIGNLIST) (RFL:GETALIGNLENGTH)) INC))))
   (setq STAEND (getreal (strcat "\nEnd Station <" (rtos TMP 2 3) "> : ")))
   (if (= nil STAEND) (setq STAEND TMP))
   (setq ALPLLIST nil)
   (setq PVIPLLIST nil)
   (while (/= nil (setq ENT (car (entsel "\nSelect Polyline : "))))
    (setq ENTLIST (entget ENT))
    (if (= (cdr (assoc 0 ENTLIST)) "POLYLINE")
     (if (/= (float (/ (cdr (assoc 70 ENTLIST)) 2 2 2 2))
                    (/ (cdr (assoc 70 ENTLIST)) 16.0))
      (progn
       (setq ALPL nil)
       (setq PVIPL nil)
       (setq ENT (entnext ENT))
       (setq ENTLIST (entget ENT))
       (setq P1 nil)
       (setq Z1 nil)
       (while (/= (cdr (assoc 0 ENTLIST)) "SEQEND")
        (setq P2 (cdr (assoc 10 ENTLIST)))
        (setq Z2 (caddr P2))
        (if (= Z2 nil) (setq Z2 0.0))
        (setq P2 (list (car P2) (cadr P2)))
        (if (/= P1 nil)
         (if (= nil ALPL)
          (setq ALPL (list (list 0.0 P1 P2 0.0)))
          (setq ALPL (append ALPL (list (list (+ (car (last ALPL)) (distance (cadr (last ALPL)) (caddr (last ALPL)))) P1 P2 0.0))))
         )
        )
        (if (= nil PVIPL)
         (setq PVIPL (list (list 0.0 Z2 "L" 0.0)))
         (setq PVIPL (append PVIPL (list (list (+ (car (last ALPL)) (distance P1 P2)) Z2 "L" 0.0))))
        )
        (setq P1 P2)
        (setq ENT (entnext ENT))
        (setq ENTLIST (entget ENT))
       )
       (setq ALPLLIST (append ALPLLIST (list ALPL)))
       (setq PVIPLLIST (append PVIPLLIST (list PVIPL)))
      )
      (princ "\n!!! NOT a 3D POLYLINE !!!\n")
     )
    )
   )
   (if (/= nil ALPLLIST)
    (progn
     (setq SWATH (getdist "\nSwath with <100.0> : "))
     (if (= nil SWATH) (setq SWATH 100.0))
     (setq RFL:SUPERLIST nil)
     (while (<= STA STAEND)
      (setq RFL:ALIGNLIST ALSAVE)
      (setq P1 (RFL:XY (list STA (/ SWATH -2.0))))
      (setq P2 (RFL:XY (list STA (/ SWATH 2.0))))
      (setq PLIST nil)
      (setq ZLIST nil)
      (setq C 0)
      (while (< C (length ALPLLIST))
       (setq RFL:ALIGNLIST (nth C ALPLLIST))
       (setq RFL:PVILIST (nth C PVIPLLIST))
       (setq P (RFL:ALINTERS P1 P2 RFL:ALIGNLIST))
       (if (/= nil P)
        (progn
         (setq Z (RFL:ELEVATION (car (RFL:STAOFF P))))
         (if (/= nil Z)
          (progn
           (setq PLIST (append PLIST (list P)))
           (setq ZLIST (append ZLIST (list Z)))
          )
         )
        )
       )
       (setq C (+ C 1))
      )
      (setq RFL:ALIGNLIST ALSAVE)
      (if (and (= 3 (length PLIST)) (= 3 (length ZLIST)))
       (progn
        (setq PL (append (RFL:STAOFF (nth 0 PLIST)) (list (nth 0 ZLIST))))
        (setq PC (append (RFL:STAOFF (nth 1 PLIST)) (list (nth 1 ZLIST))))
        (setq PR (append (RFL:STAOFF (nth 2 PLIST)) (list (nth 2 ZLIST))))
        (setq RFL:SUPERLIST (append RFL:SUPERLIST (list (list STA
                                                              (* -100.0 (/ (- (caddr PC) (caddr PL)) (- (cadr PC) (cadr PL))))
                                                              (* 100.0 (/ (- (caddr PC) (caddr PR)) (- (cadr PC) (cadr PR))))
                                                        )
                                                  )
                            )
        )
       )
      )
      (MP:Echo (strcat "\nSta : " (RFL:STATXT STA)))
      ;(princ (strcat "\nSta : " (RFL:STATXT STA)))
      (setq STA (+ STA INC))
     )
    )
   )
  )
 )
 (setq RFL:ALIGNLIST ALSAVE)
 (setq PVISAVE RFL:PVILIST)
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
 T
)