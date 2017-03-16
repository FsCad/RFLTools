;
;
;     Program written by Robert Livingston, 2013-02-20
;
;     C:STOPSIGHT3D is a routine for drawing lines from a point to points along an LWPolyline and checking for elevation conflicts
;
;
(defun C:STOPSIGHT3D (/ *error* ALSAVE ANALYZELEFT ANALYZERIGHT ANGBASE ANGDIR BELOWFLAG CECOLOR CLAYER DMAX ELEV ENT ENTLIST HEYE HTARGET INC INCLAYER LANE OBSURFACE OSMODE ORTHOMODE OS P P1 P2 PLONG PEYE PTARGET STA STASTART STAMAX STEP)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setq ORTHOMODE (getvar "ORTHOMODE"))
 (setvar "ORTHOMODE" 0)
 (setq CLAYER (getvar "CLAYER"))
 (setq CECOLOR (getvar "CECOLOR"))
 (setq TOL 0.000001)
 (setq ALSAVE RFL:ALIGNLIST)
 (command "._UNDO" "M")
 
 (defun *error* (msg)
  (princ msg)
  (setvar "CMDECHO" CMDECHO)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (setvar "OSMODE" OSMODE)
  (setvar "ORTHOMODE" ORTHOMODE)
  (setvar "CLAYER" CLAYER)
  (setvar "CECOLOR" CECOLOR)
  (setq RFL:ALIGNLIST ALSAVE PVILIST PVISAVE SUPERLIST ESAVE)
  (setq *error* nil)
 )

 (if (= nil VLAX-CREATE-OBJECT) (vl-load-com))

 (setq OBSURFACE (RFL:GETC3DSURFACE))
 
 (if (= nil OBSURFACE)
  (progn
   (princ "\n!!! Error getting surface !!!")
  )
  (progn
   (setq ENT (entsel "\nSelect target center polyline : "))
   (if (/= nil ENT)
    (progn
     (setq P (cadr ENT))
     (setq ENT (car ENT))
     (setq ENTLIST (entget ENT))
     (if (= "POLYLINE" (cdr (assoc 0 ENTLIST)))
      (progn
       (command "._CONVERT" "P" "S" ENT "")
       (setq ENTLIST (entget ENT))
      )
     )
     (if (/= "LWPOLYLINE" (cdr (assoc 0 ENTLIST)))
      (progn
       (princ "\n!!! Not a 2D Polyline !!!")
      )
      (progn
       (setq P1 (cdr (assoc 10 ENTLIST)))
       (setq P2 (cdr (assoc 10 (reverse ENTLIST))))
       (if (< (distance P P1) (distance P P2))
        (setq RFL:ALIGNLIST (RFL:ALIGNDEF ENT P1 0.0))
        (setq RFL:ALIGNLIST (RFL:ALIGNDEF ENT P2 0.0))
       )
       (if (= nil RFL:ALIGNLIST)
        (progn
         (princ "\n!!! Error generating target path !!!")
        )
        (progn
         (initget "Inside Outside Both")
         (setq ANALYZELEFT (getkword "\nLeft of eye analysis (<Inside> / Outside / Both) : "))
         (if (= nil ANALYZELEFT) (setq ANALYZELEFT "Inside"))
         (initget "Inside Outside Both")
         (setq ANALYZERIGHT (getkword "\nRight of eye analysis (Inside / <Outside> / Both) : "))
         (if (= nil ANALYZERIGHT) (setq ANALYZERIGHT "Outside"))
         (setq HEYE (getreal "\nEnter eye height <1.050> : "))
         (if (= nil HEYE) (setq HEYE 1.05))
         (setq HTARGET (getreal "\nEnter target height <0.380> : "))
         (if (= nil HTARGET) (setq HTARGET 0.38))
         (setq LANE (getreal "\nEnter lane width (note: target OS = lane / 2.0) <3.70> : "))
         (setq DMAX 0.0)
         (while (< DMAX TOL) (setq DMAX (getdist "\nEnter maximum sightline length : ")))
         (if (= nil LANE) (setq LANE 3.70))
         (setq STEP nil)
         (setq STEP (getdist "\nEnter step size <1.0> : "))
         (if (= nil STEP) (setq STEP 1.0))
         (initget "Yes No")
         (setq INCLAYER (getkword "\nIncriment layers (<Yes>/No) : "))
         (if (or (= nil INCLAYER) (= "Yes" INCLAYER))
          (progn
           (setq INCLAYER (getint "\nEnter start layer number suffix (<1>) : "))
           (if (= nil INCLAYER) (setq INCLAYER 1))
          )
         )
         (while (/= nil (setq PEYE (getpoint "\nEye point : ")))
          (setvar "OSMODE" 0)
          (if (/= "No" INCLAYER)
           (progn
            (if (= nil (tblsearch "LAYER" (strcat CLAYER "_" (itoa INCLAYER))))
             (progn
              (entmake (list (cons 0 "LAYER")
                             (cons 100 "AcDbSymbolTableRecord")
                             (cons 100 "AcDbLayerTableRecord")
                             (cons 2 (strcat CLAYER "_" (itoa INCLAYER)))
                             (cons 70 0)
                       )
              )
              (setvar "CLAYER" (strcat CLAYER "_" (itoa INCLAYER)))
             )
             (setvar "CLAYER" (strcat CLAYER "_" (itoa INCLAYER)))
            )
            (setq INCLAYER (+ INCLAYER 1))
           )
          )
          (setq P1 (STAOFF PEYE))
          (if (= nil P1)
           (princ "\n!!! Point not adjacent to target line !!!")
           (progn
            (setq ELEV (vlax-invoke-method OBSURFACE "FindElevationAtXY" (car PEYE) (cadr PEYE)))
            (if (= nil ELEV)
             (progn
              (princ "\n!!! Error getting eye surface elevation !!!")
             )
             (progn
              (setq PEYE (list (car PEYE) (cadr PEYE) (+ ELEV HEYE)))
              (setq STASTART (car P1))
              ; Left - Inside
              (if (or (= "Both" ANALYZELEFT) (= "Inside" ANALYZELEFT))
               (progn
                (if (< (cadr P1) 0.0)
                 (progn
                  (setq OS (* -0.5 LANE))
                  (setq INC STEP)
                 )
                 (progn
                  (setq OS (* 0.5 LANE))
                  (setq INC (* -1.0 STEP))
                 )
                )
                (setq STA STASTART)
                (setq PTARGET (RFL:XY (list STA OS)))
                (setq BELOWFLAG nil)
                (setq PLONG PTARGET)
                (while (/= nil PTARGET)
                 (setq ELEV (vlax-invoke-method OBSURFACE "FindElevationAtXY" (car PTARGET) (cadr PTARGET)))
                 (if (/= nil ELEV)
                  (progn
                   (setq PTARGET (list (car PTARGET) (cadr PTARGET) (+ ELEV HTARGET)))
                   (command "._LINE" PEYE PTARGET "")
                   (setq ENT (entlast))
                   (if BELOWFLAG
                    (progn
                     (RFL:SURFACELINE OBSURFACE ENT)
                    )
                    (progn
                     (setq BELOWFLAG (RFL:SURFACELINE OBSURFACE ENT))
                     (if (not BELOWFLAG)
                      (setq PLONG PTARGET)
                     )
                    )
                   )
                   (entdel ENT)
                  )
                 )
                 (setq STA (+ STA INC))
                 (setq PTARGET (RFL:XY (list STA OS)))
                 (if (/= nil PTARGET)
                  (if (> (distance (list (car PEYE) (cadr PEYE)) (list (car PTARGET) (cadr PTARGET))) DMAX)
                   (progn
                    (if (= nil BELOWFLAG) (setq BELOWFLAG "MAX"))
                    (setq PTARGET nil)
                   )
                  )
                 )
                )
                (if (/= nil PLONG)
                 (progn
                  (command "._DIMALIGNED" (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG)) (list (car PEYE) (cadr PEYE)))
                  (setq ENT (entlast))
                  (setq ENTLIST (entget ENT))
                  (setq ENTLIST (subst (cons 1 (strcat "Max. Sight Distance "
                                                       (if (= "MAX" BELOWFLAG)
                                                        (strcat "> " (rtos DMAX 2 0))
                                                        (strcat "= " (rtos (distance (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG))) 2 0))
                                                       )
                                               )
                                       )
                                       (assoc 1 ENTLIST)
                                       ENTLIST
                                )
                  )
                  (entmod ENTLIST)
                  (entupd ENT)
                 )
                )
               )
              )
              ; Left - Outside
              (if (or (= "Both" ANALYZELEFT) (= "Outside" ANALYZELEFT))
               (progn
                (if (< (cadr P1) 0.0)
                 (progn
                  (setq OS (* 0.5 LANE))
                  (setq INC STEP)
                 )
                 (progn
                  (setq OS (* -0.5 LANE))
                  (setq INC (* -1.0 STEP))
                 )
                )
                (setq STA STASTART)
                (setq PTARGET (RFL:XY (list STA OS)))
                (setq BELOWFLAG nil)
                (setq PLONG PTARGET)
                (while (/= nil PTARGET)
                 (setq ELEV (vlax-invoke-method OBSURFACE "FindElevationAtXY" (car PTARGET) (cadr PTARGET)))
                 (if (/= nil ELEV)
                  (progn
                   (setq PTARGET (list (car PTARGET) (cadr PTARGET) (+ ELEV HTARGET)))
                   (command "._LINE" PEYE PTARGET "")
                   (setq ENT (entlast))
                   (if BELOWFLAG
                    (progn
                     (RFL:SURFACELINE OBSURFACE ENT)
                    )
                    (progn
                     (setq BELOWFLAG (RFL:SURFACELINE OBSURFACE ENT))
                     (if (not BELOWFLAG)
                      (setq PLONG PTARGET)
                     )
                    )
                   )
                   (entdel ENT)
                  )
                 )
                 (setq STA (+ STA INC))
                 (setq PTARGET (RFL:XY (list STA OS)))
                 (if (/= nil PTARGET)
                  (if (> (distance (list (car PEYE) (cadr PEYE)) (list (car PTARGET) (cadr PTARGET))) DMAX)
                   (progn
                    (if (= nil BELOWFLAG) (setq BELOWFLAG "MAX"))
                    (setq PTARGET nil)
                   )
                  )
                 )
                )
                (if (/= nil PLONG)
                 (progn
                  (command "._DIMALIGNED" (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG)) (list (car PEYE) (cadr PEYE)))
                  (setq ENT (entlast))
                  (setq ENTLIST (entget ENT))
                  (setq ENTLIST (subst (cons 1 (strcat "Max. Sight Distance "
                                                       (if (= "MAX" BELOWFLAG)
                                                        (strcat "> " (rtos DMAX 2 0))
                                                        (strcat "= " (rtos (distance (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG))) 2 0))
                                                       )
                                               )
                                       )
                                       (assoc 1 ENTLIST)
                                       ENTLIST
                                )
                  )
                  (entmod ENTLIST)
                  (entupd ENT)
                 )
                )
               )
              )
              ; Right - Inside
              (if (or (= "Both" ANALYZERIGHT) (= "Inside" ANALYZERIGHT))
               (progn
                (if (< (cadr P1) 0.0)
                 (progn
                  (setq OS (* 0.5 LANE))
                  (setq INC (* -1.0 STEP))
                 )
                 (progn
                  (setq OS (* -0.5 LANE))
                  (setq INC STEP)
                 )
                )
                (setq STA STASTART)
                (setq PTARGET (RFL:XY (list STA OS)))
                (setq BELOWFLAG nil)
                (setq PLONG PTARGET)
                (while (/= nil PTARGET)
                 (setq ELEV (vlax-invoke-method OBSURFACE "FindElevationAtXY" (car PTARGET) (cadr PTARGET)))
                 (if (/= nil ELEV)
                  (progn
                   (setq PTARGET (list (car PTARGET) (cadr PTARGET) (+ ELEV HTARGET)))
                   (command "._LINE" PEYE PTARGET "")
                   (setq ENT (entlast))
                   (if BELOWFLAG
                    (progn
                     (RFL:SURFACELINE OBSURFACE ENT)
                    )
                    (progn
                     (setq BELOWFLAG (RFL:SURFACELINE OBSURFACE ENT))
                     (if (not BELOWFLAG)
                      (setq PLONG PTARGET)
                     )
                    )
                   )
                   (entdel ENT)
                  )
                 )
                 (setq STA (+ STA INC))
                 (setq PTARGET (RFL:XY (list STA OS)))
                 (if (/= nil PTARGET)
                  (if (> (distance (list (car PEYE) (cadr PEYE)) (list (car PTARGET) (cadr PTARGET))) DMAX)
                   (progn
                    (if (= nil BELOWFLAG) (setq BELOWFLAG "MAX"))
                    (setq PTARGET nil)
                   )
                  )
                 )
                )
                (if (/= nil PLONG)
                 (progn
                  (command "._DIMALIGNED" (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG)) (list (car PEYE) (cadr PEYE)))
                  (setq ENT (entlast))
                  (setq ENTLIST (entget ENT))
                  (setq ENTLIST (subst (cons 1 (strcat "Max. Sight Distance "
                                                       (if (= "MAX" BELOWFLAG)
                                                        (strcat "> " (rtos DMAX 2 0))
                                                        (strcat "= " (rtos (distance (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG))) 2 0))
                                                       )
                                               )
                                       )
                                       (assoc 1 ENTLIST)
                                       ENTLIST
                                )
                  )
                  (entmod ENTLIST)
                  (entupd ENT)
                 )
                )
               )
              )
              ; Right - Outside
              (if (or (= "Both" ANALYZERIGHT) (= "Outside" ANALYZERIGHT))
               (progn
                (if (< (cadr P1) 0.0)
                 (progn
                  (setq OS (* 0.5 LANE))
                  (setq INC (* -1.0 STEP))
                 )
                 (progn
                  (setq OS (* -0.5 LANE))
                  (setq INC STEP)
                 )
                )
                (setq STA STASTART)
                (setq PTARGET (RFL:XY (list STA OS)))
                (setq BELOWFLAG nil)
                (setq PLONG PTARGET)
                (while (/= nil PTARGET)
                 (setq ELEV (vlax-invoke-method OBSURFACE "FindElevationAtXY" (car PTARGET) (cadr PTARGET)))
                 (if (/= nil ELEV)
                  (progn
                   (setq PTARGET (list (car PTARGET) (cadr PTARGET) (+ ELEV HTARGET)))
                   (command "._LINE" PEYE PTARGET "")
                   (setq ENT (entlast))
                   (if BELOWFLAG
                    (progn
                     (RFL:SURFACELINE OBSURFACE ENT)
                    )
                    (progn
                     (setq BELOWFLAG (RFL:SURFACELINE OBSURFACE ENT))
                     (if (not BELOWFLAG)
                      (setq PLONG PTARGET)
                     )
                    )
                   )
                   (entdel ENT)
                  )
                 )
                 (setq STA (+ STA INC))
                 (setq PTARGET (RFL:XY (list STA OS)))
                 (if (/= nil PTARGET)
                  (if (> (distance (list (car PEYE) (cadr PEYE)) (list (car PTARGET) (cadr PTARGET))) DMAX)
                   (progn
                    (if (= nil BELOWFLAG) (setq BELOWFLAG "MAX"))
                    (setq PTARGET nil)
                   )
                  )
                 )
                )
                (if (/= nil PLONG)
                 (progn
                  (command "._DIMALIGNED" (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG)) (list (car PEYE) (cadr PEYE)))
                  (setq ENT (entlast))
                  (setq ENTLIST (entget ENT))
                  (setq ENTLIST (subst (cons 1 (strcat "Max. Sight Distance "
                                                       (if (= "MAX" BELOWFLAG)
                                                        (strcat "> " (rtos DMAX 2 0))
                                                        (strcat "= " (rtos (distance (list (car PEYE) (cadr PEYE)) (list (car PLONG) (cadr PLONG))) 2 0))
                                                       )
                                               )
                                       )
                                       (assoc 1 ENTLIST)
                                       ENTLIST
                                )
                  )
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
          (setvar "OSMODE" OSMODE)
         )
        )
       )
      )
     )
    )
   )        
  )
 )

 (setvar "CMDECHO" CMDECHO)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
 (setvar "CLAYER" CLAYER)
 (setvar "CECOLOR" CECOLOR)
 (setq RFL:ALIGNLIST ALSAVE)
)