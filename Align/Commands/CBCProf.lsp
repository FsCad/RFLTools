;
;
;   Program written by Robert Livingston, 15-02-03
;
;   CBCPROF is a utility for drawing and labelling vertical profiles
;
;
;
(setq RFL:BCPROFLIST nil)
(defun C:BCPROF (/ ANG ANGBASE ANGDIR C CANCEL CIRCDIA CLAYER CMDECHO DIMZIN DIRECTIONT DIRECTIONS ENT
                   FIXNUMBER FONTNAME G1 G2 K L1 L2 L3 LUPREC MLMR MLMRT MLMRB OSMODE P P1 P2 PLINETYPE PREVENT
                   REGENMODE REP SCALETEXT SIDE SIGN STA STA1 STA2 STA3 SPLINETYPE
                   SPLINESEGS TEXTSTYLE TOL Z1 Z2 Z3 ZMAX ZMIN)
 (setq REGENMODE (getvar "REGENMODE"))
 (setvar "REGENMODE" 1)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq DIMZIN (getvar "DIMZIN"))
 (setvar "DIMZIN" 0)
 (setq CLAYER (getvar "CLAYER"))
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setvar "OSMODE" 0)
 (setq SPLINETYPE (getvar "SPLINETYPE"))
 (setvar "SPLINETYPE" 5)
 (setq SPLINESEGS (getvar "SPLINESEGS"))
 (setvar "SPLINESEGS" 65)
 (setq PLINETYPE (getvar "PLINETYPE"))
 (setvar "PLINETYPE" 0)
 (setq TEXTSTYLE (getvar "TEXTSTYLE"))

 (setq TOL 0.000001)
 
 (setq CIRCDIA 1.0)
 
 (setq PREVENT nil)
 
 (command "._UNDO" "M")

; (if (= nil (findfile "BC MoT.shx"))
  (if (= nil (findfile "ROMANS.SHX"))
   (progn
    (princ "\n!!!!!  Warning - BC MoT.SHX not found, subsituting TXT.SHX")
    (setq FONTNAME "TXT.SHX")
   )
   (progn
    (princ "\n!!!!!  Warning - BC MoT.SHX not found, subsituting ROMANS.SHX")
    (setq FONTNAME "ROMANS.SHX")
   )
  )
;  (progn
;   (setq FONTNAME "BC MoT.SHX")
;  )
; )

 (defun SIGN (X)
  (if (< X 0)
   (eval -1.0)
   (eval 1.0)
  )
 )

 (defun FIXNUMBER (TILE)
  (set_tile TILE (itoa (atoi (get_tile TILE))))
 )

 (defun SCALETEXT (H / ENT ENTLIST)
  (setq ENT (entlast))
  (setq ENTLIST (entget ENT))
  (setq ENTLIST (subst (cons 40 (* (cdr (assoc "SCALE" RFL:PROFDEFLIST)) H))
                       (assoc 40 ENTLIST)
                       ENTLIST
                )
  )
  (entmod ENTLIST)
  (entupd ENT)
 )

 (defun SETBCPROFLIST (/ ACCEPTBCPROF CANCELBCPROF DCLID)
  (defun ACCEPTBCPROF ()
   (setq RFL:BCPROFLIST
    (list
     (cons "DPROF" (get_tile "DPROF"))
     (cons "LSLOPE" (get_tile "LSLOPE"))
     (cons "LL" (get_tile "LL"))
     (cons "LK" (get_tile "LK"))
     (cons "CNODES" (get_tile "CNODES"))
     (cons "DPVI" (get_tile "DPVI"))
     (cons "LPVI" (get_tile "LPVI"))
     (cons "LBVC" (get_tile "LBVC"))
     (cons "LHIGH" (get_tile "LHIGH"))
     (cons "LELEVATIONS" (get_tile "LELEVATIONS"))
     (cons "RAB" (get_tile "RAB"))
     (cons "DIRECTION" (cond ((= (get_tile "DIRLEFT") "1") "DIRLEFT")
                             ((= (get_tile "DIRRIGHT") "1") "DIRRIGHT")
                             ((= (get_tile "DIRUP") "1") "DIRUP")
                             ((= (get_tile "DIRDOWN") "1") "DIRDOWN")
                       )
     )
     (cons "KPREC" (get_tile "KPREC"))
     (cons "LPREC" (get_tile "LPREC"))
     (cons "SLOPEPREC" (get_tile "SLOPEPREC"))
     (cons "STAPREC" (get_tile "STAPREC"))
     (cons "ELEVPREC" (get_tile "ELEVPREC"))
    )
   )
   (setq CANCEL 0)
   (done_dialog)
   (unload_dialog DCL_ID)
  )

  (defun CANCELBCPROF ()
   (setq CANCEL 1)
   (done_dialog)
   (unload_dialog DCL_ID)
  )

  (if (= nil RFL:BCPROFLIST)
   (setq RFL:BCPROFLIST
    (list
     (cons "DPROF" "0")
     (cons "LSLOPE" "1")
     (cons "LL" "1")
     (cons "LK" "1")
     (cons "CNODES" "1")
     (cons "DPVI" "1")
     (cons "LPVI" "1")
     (cons "LBVC" "1")
     (cons "LHIGH" "1")
     (cons "LELEVATIONS" "0")
     (cons "RAB" "0")
     (cons "DIRECTION" "DIRRIGHT")
     (cons "KPREC" "1")
     (cons "LPREC" "0")
     (cons "SLOPEPREC" "3")
     (cons "STAPREC" "3")
     (cons "ELEVPREC" "3")
    )
   )
  )

  (if (= BCPROFDCLNAME nil)
   (progn
    (setq BCPROFDCLNAME (vl-filename-mktemp "rfl.dcl"))
    (RFL:MAKEDCL BCPROFDCLNAME "BCPROF")
   )
   (if (= nil (findfile BCPROFDCLNAME))
    (progn
     (setq BCPROFDCLNAME (vl-filename-mktemp "rfl.dcl"))
     (RFL:MAKEDCL BCPROFDCLNAME "BCPROF")
    )
   )
  )
  (setq DCL_ID (load_dialog BCPROFDCLNAME))
  (if (not (new_dialog "BCPROF" DCL_ID)) (exit))

  (setq RFLALIGNSLBNAME "rflAlign.slb")
  (if (= nil (findfile RFLALIGNSLBNAME))
   (progn
    (setq RFLALIGNSLBNAME (vl-filename-mktemp "rfl.slb"))
    (RFL:MAKERFLSLB RFLALIGNSLBNAME)
   )
  )
  (start_image "IMAGE")
  (slide_image 0 0 (- (dimx_tile "IMAGE") 1) (- (dimy_tile "IMAGE") 1) (strcat RFLALIGNSLBNAME "(BCPROF)"))
  (end_image)

  (set_tile "DPROF" (cdr (assoc "DPROF" RFL:BCPROFLIST)))
  (set_tile "LSLOPE" (cdr (assoc "LSLOPE" RFL:BCPROFLIST)))
  (set_tile "LL" (cdr (assoc "LL" RFL:BCPROFLIST)))
  (set_tile "LK" (cdr (assoc "LK" RFL:BCPROFLIST)))
  (set_tile "CNODES" (cdr (assoc "CNODES" RFL:BCPROFLIST)))
  (set_tile "DPVI" (cdr (assoc "DPVI" RFL:BCPROFLIST)))
  (set_tile "LPVI" (cdr (assoc "LPVI" RFL:BCPROFLIST)))
  (set_tile "LBVC" (cdr (assoc "LBVC" RFL:BCPROFLIST)))
  (set_tile "LHIGH" (cdr (assoc "LHIGH" RFL:BCPROFLIST)))
  (set_tile "LELEVATIONS" (cdr (assoc "LELEVATIONS" RFL:BCPROFLIST)))
  (set_tile "RAB" (cdr (assoc "RAB" RFL:BCPROFLIST)))
  (set_tile (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "1")
  (set_tile "KPREC" (cdr (assoc "KPREC" RFL:BCPROFLIST)))
  (set_tile "LPREC" (cdr (assoc "LPREC" RFL:BCPROFLIST)))
  (set_tile "SLOPEPREC" (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST)))
  (set_tile "STAPREC" (cdr (assoc "STAPREC" RFL:BCPROFLIST)))
  (set_tile "ELEVPREC" (cdr (assoc "ELEVPREC" RFL:BCPROFLIST)))

  (action_tile "KPREC" "(FIXNUMBER \"KPREC\")")
  (action_tile "LPREC" "(FIXNUMBER \"LPREC\")")
  (action_tile "SLOPEPREC" "(FIXNUMBER \"SLOPEPREC\")")
  (action_tile "STAPREC" "(FIXNUMBER \"STAPREC\")")
  (action_tile "ELEVPREC" "(FIXNUMBER \"ELEVPREC\")")
  (action_tile "OK" "(ACCEPTBCPROF)")
  (action_tile "CANCEL" "(CANCELBCPROF)")

  (start_dialog)
 )

 (if (= nil C:RPROF)
  (progn
   (princ "\n*****  PROFILE UTILITIES NOT LOADED  *****")
  )
  (progn
   (C:RPROF)
   (if (= nil RFL:PVILIST)
    (progn
     (princ "\n*****  PROFILE NOT DEFINED  *****")
    )
    (progn
     (RFL:PROFDEF)
     (if (= nil RFL:PROFDEFLIST)
      (progn
       (princ "\n*****  PROFILE LOCATION NOT DEFINED  *****")
      )
      (progn
       (SETBCPROFLIST)
       (if (and (= (cdr (assoc "DPROF" RFL:BCPROFLIST)) "1")
                (= CANCEL 0)
           )
        (progn
         (if (= (tblsearch "LAYER" (cdr (assoc "PLAYER" RFL:PROFDEFLIST))) nil)
          (progn
           (command "._LAYER" "M" (cdr (assoc "PLAYER" RFL:PROFDEFLIST)) "")
          )
          (progn
           (setvar "CLAYER" (cdr (assoc "PLAYER" RFL:PROFDEFLIST)))
          )
         )
         (command "._PLINE")
         (foreach TMP RFL:PVILIST
          (progn
           (if (< (cadddr TMP) TOL)
            (command (RFL:PROFPOINT (car TMP) (cadr TMP)))
            (progn
             (setq C 0)
             (while (<= C 64)
              (command (RFL:PROFPOINT (+ (- (car TMP) (/ (cadddr TMP) 2.0)) (* (/ (cadddr TMP) 64) C))
                                  (RFL:ELEVATION (+ (- (car TMP) (/ (cadddr TMP) 2.0)) (* (/ (cadddr TMP) 64) C)))
                       )
              )
              (setq C (+ C 1))
             )
            )
           )
          )
         )
         (command "")
         (setq ENT (entlast))
         (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
        )
       )
       (if (and (or (= (cdr (assoc "LSLOPE" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "LL" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "LK" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "DPVI" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "LPVI" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "LBVC" RFL:BCPROFLIST)) "1")
                    (= (cdr (assoc "LELEVATIONS" RFL:BCPROFLIST)) "1")
                )
                (= CANCEL 0)
           )
        (progn
         (if (or (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) 1)
                 (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) nil)
             )
          (cond ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRLEFT")
                 (setq DIRECTIONT 1 DIRECTIONS 1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRRIGHT")
                 (setq DIRECTIONT -1 DIRECTIONS 1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRUP")
                 (setq DIRECTIONT 1 DIRECTIONS 1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRDOWN")
                 (setq DIRECTIONT -1 DIRECTIONS 1)
                )
          )
          (cond ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRLEFT")
                 (setq DIRECTIONT 1 DIRECTIONS -1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRRIGHT")
                 (setq DIRECTIONT -1 DIRECTIONS -1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRUP")
                 (setq DIRECTIONT -1 DIRECTIONS -1)
                )
                ((= (cdr (assoc "DIRECTION" RFL:BCPROFLIST)) "DIRDOWN")
                 (setq DIRECTIONT 1 DIRECTIONS -1)
                )
          )
         )
         (if (= DIRECTIONT 1)
          (progn
           (if (= (cdr (assoc "RAB" RFL:BCPROFLIST)) "0")
            (progn
             (setq MLMR "MR")
             (setq MLMRT "R")
             (setq MLMRB "TR")
             (setq SIDE 1)
            )
            (progn
             (setq MLMR "ML")
             (setq MLMRT "L")
             (setq MLMRB "TL")
             (setq SIDE -1)
            )
           )
          )
          (progn
           (if (= (cdr (assoc "RAB" RFL:BCPROFLIST)) "0")
            (progn
             (setq MLMR "ML")
             (setq MLMRT "L")
             (setq MLMRB "TL")
             (setq SIDE 1)
            )
            (progn
             (setq MLMR "MR")
             (setq MLMRT "R")
             (setq MLMRB "TR")
             (setq SIDE -1)
            )
           )
          )
         )
         (setq ZMAX (nth 1 (nth 0 RFL:PVILIST)))
         (setq ZMIN (nth 1 (nth 0 RFL:PVILIST)))
         (setq C 1)
         (while (< C (length RFL:PVILIST))
          (if (> (nth 1 (nth C RFL:PVILIST)) ZMAX)
           (setq ZMAX (nth 1 (nth C RFL:PVILIST)))
          )
          (if (< (nth 1 (nth C RFL:PVILIST)) ZMIN)
           (setq ZMIN (nth 1 (nth C RFL:PVILIST)))
          )
          (setq C (+ C 1))
         )
         (setq C 1)
         (if (= (tblsearch "LAYER" (cdr (assoc "PTLAYER" RFL:PROFDEFLIST))) nil)
          (progn
           (command "._LAYER" "M" (cdr (assoc "PTLAYER" RFL:PROFDEFLIST)) "")
          )
          (progn
           (setvar "CLAYER" (cdr (assoc "PTLAYER" RFL:PROFDEFLIST)))
          )
         )
;         (if (or (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
;                 (= (cdr (assoc "DPVI" RFL:BCPROFLIST)) "1")
;             )
;          (if (= (tblsearch "BLOCK" "CIRC") nil)
;           (progn
;            (entmake)
;            (setq ENTLIST (list (cons 0 "BLOCK")
;                                (cons 2 "CIRC")
;                                (list 10 0.0 0.0 0.0)
;                                (cons 70 0)
;                          )
;            )
;            (entmake ENTLIST)
;            (setq ENTLIST (list (cons 0 "CIRCLE")
;                                (cons 8 "0")
;                                (list 10 0.0 0.0 0.0)
;                                (cons 40 5.0)
;                          )
;            )
;            (entmake ENTLIST)
;            (setq ENTLIST (list (cons 0 "ENDBLK")
;                          )
;            )
;            (entmake ENTLIST)
;           )
;          )
;         )
         (if (= (tblsearch "STYLE" "3.5mm") nil)
          (progn
           (command "._STYLE" "3.5mm" FONTNAME "3.5" "1.0" "0.0" "N" "N" "N")
          )
          (progn
           (setvar "TEXTSTYLE" "3.5mm")
          )
         )
         (setq STA1 (nth 0 (nth 0 RFL:PVILIST)))
         (setq Z1 (nth 1 (nth 0 RFL:PVILIST)))
         (setq L1 (nth 3 (nth 0 RFL:PVILIST)))
         (setq P (RFL:PROFPOINT STA1 Z1))
         (if (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
          (progn
;           (if (= nil (tblsearch "BLOCK" "CIRC")) (RFL:MAKEENT "CIRC"))
;           (command "._INSERT" "CIRC" P (cdr (assoc "SCALE" RFL:PROFDEFLIST)) "" "")
;           (setq ENT (entlast))
;           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (command "._CIRCLE" P (* CIRCDIA (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (command "._LINE"
                    (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 1.0)))
                    (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 11.0)))
                    ""
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
          )
         )
         (if (= (cdr (assoc "LBVC" RFL:BCPROFLIST)) "1")
          (progn
           (setq TMP (/ (fix (+ 0.5
                                (* Z1
                                   (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                                )
                             )
                        )
                        (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                     )
           )
           (command "._TEXT"
                    MLMRT
                    (list (+ (nth 0 P) (* DIRECTIONT 0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                          (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                    )
                    (if (= DIRECTIONT 1)
                     "-90.0"
                     "90.0"
                    )
                    (strcat "STA  " (RFL:STATXT STA1))
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (SCALETEXT 3.5)
           (command "._TEXT"
                    MLMRB
                    (list (+ (nth 0 P) (* DIRECTIONT -0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                          (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                    )
                    (if (= DIRECTIONT 1)
                     "-90.0"
                     "90.0"
                    )
                    (strcat "PIVC  " (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0)) " m")
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (SCALETEXT 3.5)
          )
         )
         (while (< (+ C 1) (length RFL:PVILIST))
          (if (= (tblsearch "STYLE" "3.5mm") nil)
           (progn
            (command "._STYLE" "3.5mm" FONTNAME "3.5" "1.0" "0.0" "N" "N" "N")
           )
           (progn
            (setvar "TEXTSTYLE" "3.5mm")
           )
          )
          (setq STA1 (nth 0 (nth (- C 1) RFL:PVILIST)))
          (setq Z1 (nth 1 (nth (- C 1) RFL:PVILIST)))
          (setq L1 (nth 3 (nth (- C 1) RFL:PVILIST)))
          (setq STA2 (nth 0 (nth C RFL:PVILIST)))
          (setq Z2 (nth 1 (nth C RFL:PVILIST)))
          (setq L2 (nth 3 (nth C RFL:PVILIST)))
          (setq STA3 (nth 0 (nth (+ C 1) RFL:PVILIST)))
          (setq Z3 (nth 1 (nth (+ C 1) RFL:PVILIST)))
          (setq L3 (nth 3 (nth (+ C 1) RFL:PVILIST)))
          (setq G1 (* (/ (- Z2 Z1) (- STA2 STA1)) 100.0))
          (setq G2 (* (/ (- Z3 Z2) (- STA3 STA2)) 100.0))
          (setq STA (/ (+ (+ STA1
                             (/ L1 2.0)
                          )
                          (- STA2
                             (/ L2 2.0)
                          )
                       )
                       2.0
                    )
          )
          (if (= (cdr (assoc "LSLOPE" RFL:BCPROFLIST)) "1")
           (progn
;            (setq TMP (/ (fix (+ 0.5
;                                 (* G1
;                                    (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
;                                 )
;                              )
;                         )
;                         (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
;                      )
;            )
            (command "._TEXT"
                     (if (= SIDE 1) "C" "TC")
                     (list (+ (car (RFL:PROFPOINT STA (RFL:ELEVATION STA)))
                              (* 1.75
                                 SIDE
                                 (if (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) -1) -1 1)
                                 (sin (angle (RFL:PROFPOINT STA2 Z2) (RFL:PROFPOINT STA1 Z1)))
                                 (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                              )
                           )
                           (+ (cadr (RFL:PROFPOINT STA (RFL:ELEVATION STA)))
                              (* -1.75
                                 SIDE
                                 (if (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) -1) -1 1)
                                 (cos (angle (RFL:PROFPOINT STA2 Z2) (RFL:PROFPOINT STA1 Z1)))
                                 (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                              )
                           )
                    )
                     (if (= DIRECTIONS 1)
                      (* (angle (RFL:PROFPOINT STA1 Z1) (RFL:PROFPOINT STA2 Z2)) (/ 180.0 pi))
                      (* (angle (RFL:PROFPOINT STA2 Z2) (RFL:PROFPOINT STA1 Z1)) (/ 180.0 pi))
                     )
                     (strcat (if (> G1 0.0) "+" "") (rtos G1 2 (if (> (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))) 0)) "%")
            )
            (setq ENT (entlast))
            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
            (SCALETEXT 3.5)
           )
          )
          (setq P (RFL:PROFPOINT STA2 Z2))
          (if (= (cdr (assoc "LPVI" RFL:BCPROFLIST)) "1")
           (progn
            (setq TMP (/ (fix (+ 0.5
                                 (* Z2
                                    (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                                 )
                              )
                         )
                         (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                      )
            )
            (command "._TEXT"
                     MLMRT
                     (list (+ (nth 0 P) (* DIRECTIONT 0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                           (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                     )
                     (if (= DIRECTIONT 1)
                      "-90.0"
                      "90.0"
                     )
                     (strcat "STA  " (RFL:STATXT STA2))
            )
            (setq ENT (entlast))
            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
            (SCALETEXT 3.5)
            (command "._TEXT"
                     MLMRB
                     (list (+ (nth 0 P) (* DIRECTIONT -0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                           (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                     )
                     (if (= DIRECTIONT 1)
                      "-90.0"
                      "90.0"
                     )
                     (strcat "PIVC  " (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0)) " m")
            )
            (setq ENT (entlast))
            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
            (SCALETEXT 3.5)
           )
          )
          (if (= (cdr (assoc "DPVI" RFL:BCPROFLIST)) "1")
           (progn
;            (if (= nil (tblsearch "BLOCK" "CIRC")) (RFL:MAKEENT "CIRC"))
;            (command "._INSERT" "CIRC" (RFL:PROFPOINT STA2 Z2) (cdr (assoc "SCALE" RFL:PROFDEFLIST)) "" "")
;            (setq ENT (entlast))
;            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
            (command "._CIRCLE" (RFL:PROFPOINT STA2 Z2) (* CIRCDIA (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
            (setq ENT (entlast))
            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
            (command "._LINE"
                     (list (nth 0 (RFL:PROFPOINT STA2 Z2)) (+ (nth 1 (RFL:PROFPOINT STA2 Z2)) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 1.0)))
                     (list (nth 0 (RFL:PROFPOINT STA2 Z2)) (+ (nth 1 (RFL:PROFPOINT STA2 Z2)) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 11.0)))
                     ""
            )
            (setq ENT (entlast))
            (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           )
          )
          (if (> L2 0.0)
           (progn
            (setq K (abs (/ L2
                            (- G2 G1)
                         )
                    )
            )
            (if (= (cdr (assoc "LL" RFL:BCPROFLIST)) "1")
             (progn
              (setq TMP (/ (fix (+ 0.5
                                   (* L2
                                      (expt 10.0 (atoi (cdr (assoc "LPREC" RFL:BCPROFLIST))))
                                   )
                                )
                           )
                           (expt 10.0 (atoi (cdr (assoc "LPREC" RFL:BCPROFLIST))))
                        )
              )
              (command "._TEXT"
                       "TC"
                       (list (nth 0 P) (- (nth 1 P) (* SIDE 50.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST)))))
                       "0.0"
                       (strcat (rtos TMP 2 (if (> (atoi (cdr (assoc "LPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "LPREC" RFL:BCPROFLIST))) 0)) " VC")
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (SCALETEXT 3.5)
             )
            )
            (if (= (cdr (assoc "LK" RFL:BCPROFLIST)) "1")
             (progn
              (setq TMP (/ (fix (+ 0.5
                                   (* K
                                      (expt 10.0 (atoi (cdr (assoc "KPREC" RFL:BCPROFLIST))))
                                   )
                                )
                           )
                           (expt 10.0 (atoi (cdr (assoc "KPREC" RFL:BCPROFLIST))))
                        )
              )
              (command "._TEXT"
                       "TC"
                       (list (nth 0 P) (- (nth 1 P) (* SIDE 50.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))) (* 5.25 (cdr (assoc "SCALE" RFL:PROFDEFLIST)))))
                       "0.0"
                       (strcat "K = "(rtos TMP 2 (if (> (atoi (cdr (assoc "KPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "KPREC" RFL:BCPROFLIST))) 0)))
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (SCALETEXT 3.5)
             )
            )
            (if (= (cdr (assoc "DPVI" RFL:BCPROFLIST)) "1")
             (progn
              (setq ANG (angle P (RFL:PROFPOINT STA1 Z1)))
              (command "._LINE"
                       (list (+ (nth 0 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   1.0
                                   (cos ANG)
                                )
                             )
                             (+ (nth 1 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   1.0
                                   (sin ANG)
                                )
                             )
                       )
                       (list (+ (nth 0 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   11.0
                                   (cos ANG)
                                )
                             )
                             (+ (nth 1 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   11.0
                                   (sin ANG)
                                )
                             )
                       )
                       ""
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (setq ANG (angle P (RFL:PROFPOINT STA3 Z3)))
              (command "._LINE"
                       (list (+ (nth 0 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   1.0
                                   (cos ANG)
                                )
                             )
                             (+ (nth 1 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   1.0
                                   (sin ANG)
                                )
                             )
                       )
                       (list (+ (nth 0 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   11.0
                                   (cos ANG)
                                )
                             )
                             (+ (nth 1 P)
                                (* (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                                   11.0
                                   (sin ANG)
                                )
                             )
                       )
                       ""
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
             )
            )
            (setq P (RFL:PROFPOINT (- STA2 (/ L2 2.0)) (RFL:ELEVATION (- STA2 (/ L2 2.0)))))
            (if (= (cdr (assoc "LBVC" RFL:BCPROFLIST)) "1")
             (progn
              (setq TMP (/ (fix (+ 0.5
                                   (* (RFL:ELEVATION (- STA2 (/ L2 2.0)))
                                      (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                                   )
                                )
                           )
                           (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                        )
              )
              (command "._TEXT"
                       MLMR
                       (list (nth 0 P)
                             (+ (nth 1 P) (* SIDE 12.75 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                       )
                       (if (= DIRECTIONT 1)
                        "-90.0"
                        "90.0"
                       )
                       (strcat "BVC  " (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0)) " m")
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (SCALETEXT 3.5)
             )
            )
            (if (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
             (progn
;              (if (= nil (tblsearch "BLOCK" "CIRC")) (RFL:MAKEENT "CIRC"))
;              (command "._INSERT" "CIRC" P (cdr (assoc "SCALE" RFL:PROFDEFLIST)) "" "")
;              (setq ENT (entlast))
;              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (command "._CIRCLE" P (* CIRCDIA (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (command "._LINE"
                       (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 1.0)))
                       (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 11.0)))
                       ""
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
             )
            )
            (setq P (RFL:PROFPOINT (+ STA2 (/ L2 2.0)) (RFL:ELEVATION (+ STA2 (/ L2 2.0)))))
            (if (= (cdr (assoc "LBVC" RFL:BCPROFLIST)) "1")
             (progn
              (setq TMP (/ (fix (+ 0.5
                                   (* (RFL:ELEVATION (+ STA2 (/ L2 2.0)))
                                      (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                                   )
                                )
                           )
                           (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                        )
              )
              (command "._TEXT"
                       MLMR
                       (list (nth 0 P)
                             (+ (nth 1 P) (* SIDE 12.75 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                       )
                       (if (= DIRECTIONT 1)
                        "-90.0"
                        "90.0"
                       )
                       (strcat "EVC  " (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0)) " m")
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (SCALETEXT 3.5)
             )
            )
            (if (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
             (progn
;              (if (= nil (tblsearch "BLOCK" "CIRC")) (RFL:MAKEENT "CIRC"))
;              (command "._INSERT" "CIRC" P (cdr (assoc "SCALE" RFL:PROFDEFLIST)) "" "")
;              (setq ENT (entlast))
;              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (command "._CIRCLE" P (* CIRCDIA (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
              (command "._LINE"
                       (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 1.0)))
                       (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 11.0)))
                       ""
              )
              (setq ENT (entlast))
              (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
             )
            )
            (if (= (cdr (assoc "LELEVATIONS" RFL:BCPROFLIST)) "1")
             (progn
              (if (= (tblsearch "STYLE" "2.5mm") nil)
               (progn
                (command "._STYLE" "2.5mm" FONTNAME "2.5" "1.0" "0.0" "N" "N" "N")
               )
               (progn
                (setvar "TEXTSTYLE" "2.5mm")
               )
              )
              (setq STA (float (* (+ (fix (/ (- STA2 (/ L2 2.0)) 20.0)) 1) 20.0)))
              (while (< STA (+ STA2 (/ L2 2.0)))
               (if (= SIDE 1)
                (setq P (RFL:PROFPOINT STA ZMAX))
                (setq P (RFL:PROFPOINT STA ZMIN))
               )
               (setq TMP (/ (fix (+ 0.5
                                    (* (RFL:ELEVATION STA)
                                       (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                                    )
                                 )
                            )
                            (expt 10.0 (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))))
                         )
               )
               (command "._TEXT"
                        MLMR
                        (list (nth 0 P) (+ (nth 1 P) (* SIDE 400.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST)))))
                        (if (= DIRECTIONT 1)
                         "-90.0"
                         "90.0"
                        )
                        (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0))
               )
               (setq ENT (entlast))
               (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
               (SCALETEXT 10.16)
               (setq STA (+ STA 20.0))
              )
             )
            )
           )
          )
          (setq C (+ C 1))
         )
         (setq STA (/ (+ (+ STA2
                            (/ L2 2.0)
                         )
                         (- STA3
                            (/ L3 2.0)
                         )
                      )
                      2.0
                   )
         )
         (if (= (tblsearch "STYLE" "3.5mm") nil)
          (progn
           (command "._STYLE" "3.5mm" FONTNAME "3.5" "1.0" "0.0" "N" "N" "N")
          )
          (progn
           (setvar "TEXTSTYLE" "3.5mm")
          )
         )
         (if (= (cdr (assoc "LSLOPE" RFL:BCPROFLIST)) "1")
          (progn
;           (setq TMP (/ (fix (+ 0.5
;                                (* G2
;                                   (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
;                                )
;                             )
;                        )
;                        (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
;                     )
;           )
           (command "._TEXT"
                    (if (= SIDE 1) "C" "TC")
                    (list (+ (car (RFL:PROFPOINT STA (RFL:ELEVATION STA)))
                             (* 1.75
                                SIDE
                                (if (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) -1) -1 1)
                                (sin (angle (RFL:PROFPOINT STA3 Z3) (RFL:PROFPOINT STA2 Z2)))
                                (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                             )
                          )
                          (+ (cadr (RFL:PROFPOINT STA (RFL:ELEVATION STA)))
                             (* -1.75
                                SIDE
                                (if (= (cdr (assoc "DIRECTION" RFL:PROFDEFLIST)) -1) -1 1)
                                (cos (angle (RFL:PROFPOINT STA2 Z2) (RFL:PROFPOINT STA1 Z1)))
                                (cdr (assoc "SCALE" RFL:PROFDEFLIST))
                             )
                          )
                   )
                   (if (= DIRECTIONS 1)
                    (* (angle (RFL:PROFPOINT STA2 Z2) (RFL:PROFPOINT STA3 Z3)) (/ 180.0 pi))
                    (* (angle (RFL:PROFPOINT STA3 Z3) (RFL:PROFPOINT STA2 Z2)) (/ 180.0 pi))
                   )
                   (strcat (if (> G2 0.0) "+" "") (rtos G2 2 (if (> (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))) 0)) "%")
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (SCALETEXT 3.5)
          )
         )
         (setq P (RFL:PROFPOINT STA3 Z3))
         (if (= (cdr (assoc "CNODES" RFL:BCPROFLIST)) "1")
          (progn
;           (if (= nil (tblsearch "BLOCK" "CIRC")) (RFL:MAKEENT "CIRC"))
;           (command "._INSERT" "CIRC" P (cdr (assoc "SCALE" RFL:PROFDEFLIST)) "" "")
;           (setq ENT (entlast))
;           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (command "._CIRCLE" P (* CIRCDIA (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (command "._LINE"
                    (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 1.0)))
                    (list (nth 0 P) (+ (nth 1 P) (* SIDE (cdr (assoc "SCALE" RFL:PROFDEFLIST)) 11.0)))
                    ""
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
          )
         )
         (if (= (cdr (assoc "LBVC" RFL:BCPROFLIST)) "1")
          (progn
           (setq TMP (/ (fix (+ 0.5
                                (* Z3
                                   (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
                                )
                             )
                        )
                        (expt 10.0 (atoi (cdr (assoc "SLOPEPREC" RFL:BCPROFLIST))))
                     )
           )
           (command "._TEXT"
                    MLMRT
                    (list (+ (nth 0 P) (* DIRECTIONT 0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                          (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                    )
                    (if (= DIRECTIONT 1)
                     "-90.0"
                     "90.0"
                    )
                    (strcat "STA  " (RFL:STATXT STA3))
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (SCALETEXT 3.5)
           (command "._TEXT"
                    MLMRB
                    (list (+ (nth 0 P) (* DIRECTIONT -0.875 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                          (+ (nth 1 P) (* SIDE 12.0 (cdr (assoc "SCALE" RFL:PROFDEFLIST))))
                    )
                    (if (= DIRECTIONT 1)
                     "-90.0"
                     "90.0"
                    )
                    (strcat "PIVC  " (rtos TMP 2 (if (> (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0) (atoi (cdr (assoc "ELEVPREC" RFL:BCPROFLIST))) 0)) " m")
           )
           (setq ENT (entlast))
           (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
           (SCALETEXT 3.5)
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

 (setvar "REGENMODE" REGENMODE)
 (setvar "CMDECHO" CMDECHO)
 (setvar "DIMZIN" DIMZIN)
 (setvar "CLAYER" CLAYER)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
 (setvar "SPLINETYPE" SPLINETYPE)
 (setvar "SPLINESEGS" SPLINESEGS)
 (setvar "PLINETYPE" PLINETYPE)
 (setvar "TEXTSTYLE" TEXTSTYLE)
)