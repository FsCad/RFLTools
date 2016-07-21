;
;
;   Program written by Robert Livingston, 98/05/14
;
;   RFL:PROFDEF locates and defines a global variable RFL:PROFDEFLIST with the profile base point, stationing and elevations
;
;
(defun RFL:PROFDEF (/ BPOINT DIRECTION ELEV ELEVMAX ENT ENTLIST FNAME OBPROFILE PLAYER PTLAYER
                      SCALE STA STAH STAL STAMAX TMP VEXAG X1 X2 Y1 Y2)
 (setq RFL:PROFDEFLIST nil
       BPOINT nil
       DIRECTION nil
       ELEV nil
       FNAME ""
       PLAYER (getvar "CLAYER")
       PTLAYER (getvar "CLAYER")
       SCALE 1.0
       STA nil
       VEXAG 1.0
 )
 (setq ENT (car (entsel "\nSelect profile grid or profile definition block : ")))
 (setq ENTLIST (entget ENT))
 (setq BPOINT (cdr (assoc 10 ENTLIST)))
 (if (and (= "INSERT" (cdr (assoc 0 ENTLIST)))
          (= 1 (cdr (assoc 66 ENTLIST)))
     )
  (progn
   (setq ENT (entnext ENT))
   (setq ENTLIST (entget ENT))
   (while (= "ATTRIB" (cdr (assoc 0 ENTLIST)))
    (cond ((= "DIRECTION" (strcase (cdr (assoc 2 ENTLIST))))
           (setq DIRECTION (atoi (cdr (assoc 1 ENTLIST))))
          )
          ((= "ELEV" (strcase (cdr (assoc 2 ENTLIST))))
           (setq ELEV (atof (cdr (assoc 1 ENTLIST))))
          )
          ((= "FNAME" (strcase (cdr (assoc 2 ENTLIST))))
           (setq FNAME (cdr (assoc 1 ENTLIST)))
          )
          ((= "PLAYER" (strcase (cdr (assoc 2 ENTLIST))))
           (setq PLAYER (cdr (assoc 1 ENTLIST)))
          )
          ((= "PTLAYER" (strcase (cdr (assoc 2 ENTLIST))))
           (setq PTLAYER (cdr (assoc 1 ENTLIST)))
          )
          ((= "SCALE" (strcase (cdr (assoc 2 ENTLIST))))
           (setq SCALE (atof (cdr (assoc 1 ENTLIST))))
          )
          ((= "STAH" (strcase (cdr (assoc 2 ENTLIST))))
           (setq STAH (cdr (assoc 1 ENTLIST)))
          )
          ((= "STAL" (strcase (cdr (assoc 2 ENTLIST))))
           (setq STAL (cdr (assoc 1 ENTLIST)))
          )
          ((= "VEXAG" (strcase (cdr (assoc 2 ENTLIST))))
           (setq VEXAG (atof (cdr (assoc 1 ENTLIST))))
          )
    )
    (setq ENT (entnext ENT))
    (setq ENTLIST (entget ENT))
   )
   (if (and STAH STAL) (setq STA (atof (strcat STAH STAL))))
  )
  (if (= "AECC_PROFILE_VIEW" (cdr (assoc 0 ENTLIST)))
   (progn
    (setq OBPROFILE (vlax-ename->vla-object ENT))
    (setq ELEV (vlax-get OBPROFILE "ElevationMin"))
    (setq ELEVMAX (vlax-get OBPROFILE "ElevationMax"))
    (setq STA (vlax-get OBPROFILE "StationStart"))
    (setq STAMAX (vlax-get OBPROFILE "StationEnd"))
    (vlax-invoke-method OBPROFILE 'FindXYAtStationAndElevation STA ELEV 'X1 'Y1 'inside)
    (vlax-invoke-method OBPROFILE 'FindXYAtStationAndElevation STAMAX ELEVMAX 'X2 'Y2 'inside)
    (if (< X1 X2)
     (setq BPOINT (list X1 Y1)
           DIRECTION 1
     )
     (setq BPOINT (list X2 Y1)
           DIRECTION -1
           STA (vlax-get OBPROFILE "StationEnd")
           STAMAX (vlax-get OBPROFILE "StationStart")
     )
    )
    (setq VEXAG (/ (- Y2 Y1) (- ELEVMAX ELEV)))
   )
   (if (= "AECC_PROFILE" (cdr (assoc 0 ENTLIST)))
    (progn
     (setq OBPROFILE (vlax-ename->vla-object ENT))
     (setq ELEV (vlax-get OBPROFILE "ElevationMin"))
     (setq ELEVMAX (vlax-get OBPROFILE "ElevationMax"))
     (setq STA (vlax-get OBPROFILE "StartingStation"))
     (setq STAMAX (vlax-get OBPROFILE "StationEnd"))
     (vlax-invoke-method OBPROFILE 'FindXYAtStationAndElevation STA ELEV 'X1 'Y1 'inside)
     (vlax-invoke-method OBPROFILE 'FindXYAtStationAndElevation STAMAX ELEVMAX 'X2 'Y2 'inside)
     (if (< X1 X2)
      (setq BPOINT (list X1 Y1)
            DIRECTION 1
      )
      (setq BPOINT (list X2 Y1)
            DIRECTION -1
            STA (vlax-get OBPROFILE "StationEnd")
            STAMAX (vlax-get OBPROFILE "StationStart")
      )
     )
     (setq VEXAG (/ (- Y2 Y1) (- ELEVMAX ELEV)))
    )
    (if (/= nil (setq ENTLIST (cdadr (assoc -3 (entget ENT (list "RFLTOOLS_XENT"))))))
     (if (= (cdar ENTLIST) "RFLTOOLS_DRAWGRID")
      (progn
       (setq ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             STA (cdar ENTLIST)
             ENTLIST (cdr ENTLIST)
             ELEV (cdar ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             VEXAG (cdar ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             ENTLIST (cdr ENTLIST)
             SCALE (cdar ENTLIST)
             ENTLIST (cdr ENTLIST)
             DIRECTION (cdar ENTLIST)
       )
      )
     )
    )
   )
  )
 )
 (if (and BPOINT DIRECTION ELEV FNAME PLAYER PTLAYER SCALE STA VEXAG)
  (setq RFL:PROFDEFLIST (list (cons "BPOINT" BPOINT)
                              (cons "DIRECTION" DIRECTION)
                              (cons "ELEV" ELEV)
                              (cons "FNAME" FNAME)
                              (cons "PLAYER" PLAYER)
                              (cons "PTLAYER" PTLAYER)
                              (cons "SCALE" SCALE)
                              (cons "STA" STA)
                              (cons "VEXAG" VEXAG)
                )
  )
  nil
 )
)