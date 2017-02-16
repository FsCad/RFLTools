;
;
;   Program written by Robert Livingston, 99/12/03
;
;   (RFL:XYP) returns the X,Y point for a station and offset of the currently defined alignment
;
;
(defun RFL:XYP (/ ACCEPTXYP AL ANG CANCEL CANCELXYP DCL_ID FIXE FIXN FIXSTA FIXOS
                  FIXFROMSTA FIXFROMOS FIXTOSTA FIXTOOS
                  FIXSTEP FIXXFROMSTA FIXXTOSTA FIXXSWATH FIXXINC INC INFILE INLINE
                  NODE P P1 P2 RERUN STA STA1 STA2 STAMIN STAMAX
                  TMP UPDATENE UPDATESTAOFF)

 (defun ACCEPTXYP (TMP)
  (setq CANCEL TMP)
  (setq XYPSTA (atof (get_tile "STATION")))
  (setq XYPOS (atof (get_tile "OFFSET")))
  (setq XYPFROMSTA (atof (get_tile "FROMSTATION")))
  (setq XYPFROMOS (atof (get_tile "FROMOFFSET")))
  (setq XYPTOSTA (atof (get_tile "TOSTATION")))
  (setq XYPTOOS (atof (get_tile "TOOFFSET")))
  (setq XYPSTEP (atoi (get_tile "STEP")))
  (setq XYPXFROMSTA (atof (get_tile "XFROMSTATION")))
  (setq XYPXTOSTA (atof (get_tile "XTOSTATION")))
  (setq XYPXROUND (get_tile "XROUND"))
  (setq XYPXSWATH (atof (get_tile "XSWATH")))
  (setq XYPXINC (atof (get_tile "XINC")))
  (setq XYPXSPECIAL (get_tile "XSPECIAL"))
  (done_dialog)
 )

 (defun CANCELXYP ()
  (setq CANCEL 1)
  (done_dialog)
 )

 (defun FIXSTA (/ TMP)
  (setq TMP (atof (get_tile "STATION")))
  (if (< TMP STAMIN) (setq TMP STAMIN))
  (if (> TMP STAMAX) (setq TMP STAMAX))
  (set_tile "STATION" (rtos TMP))
  (UPDATENE)
 )

 (defun FIXOS ()
  (set_tile "OFFSET" (rtos (atof (get_tile "OFFSET"))))
  (UPDATENE)
 )

 (defun FIXN ()
  (set_tile "NORTHING" (rtos (atof (get_tile "NORTHING"))))
  (UPDATESTAOFF)
 )

 (defun FIXE ()
  (set_tile "EASTING" (rtos (atof (get_tile "EASTING"))))
  (UPDATESTAOFF)
 )

 (defun FIXFROMSTA (/ TMP)
  (setq TMP (atof (get_tile "FROMSTATION")))
  (if (< TMP STAMIN) (setq TMP STAMIN))
  (if (> TMP STAMAX) (setq TMP STAMAX))
  (set_tile "FROMSTATION" (rtos TMP))
 )

 (defun FIXFROMOS ()
  (set_tile "FROMOFFSET" (rtos (atof (get_tile "FROMOFFSET"))))
 )

 (defun FIXTOSTA (/ TMP)
  (setq TMP (atof (get_tile "TOSTATION")))
  (if (< TMP STAMIN) (setq TMP STAMIN))
  (if (> TMP STAMAX) (setq TMP STAMAX))
  (set_tile "TOSTATION" (rtos TMP))
 )

 (defun FIXTOOS ()
  (set_tile "TOOFFSET" (rtos (atof (get_tile "TOOFFSET"))))
 )

 (defun FIXSTEP (/ TMP)
  (setq TMP (atoi (get_tile "STEP")))
  (if (< TMP 1) (setq TMP 1))
  (set_tile "STEP" (itoa TMP))
 )

 (defun FIXXFROMSTA (/ TMP)
  (setq TMP (atof (get_tile "XFROMSTATION")))
  (if (< TMP STAMIN) (setq TMP STAMIN))
  (if (> TMP STAMAX) (setq TMP STAMAX))
  (set_tile "XFROMSTATION" (rtos TMP))
 )

 (defun FIXXTOSTA (/ TMP)
  (setq TMP (atof (get_tile "XTOSTATION")))
  (if (< TMP STAMIN) (setq TMP STAMIN))
  (if (> TMP STAMAX) (setq TMP STAMAX))
  (set_tile "XTOSTATION" (rtos TMP))
 )

 (defun FIXXSWATH (/ TMP)
  (setq TMP (atof (get_tile "XSWATH")))
  (if (<= TMP 0.0) (setq TMP 0.0))
  (set_tile "XSWATH" (rtos TMP))
 )

 (defun FIXXINC (/ TMP)
  (setq TMP (atof (get_tile "XINC")))
  (if (< TMP 0.0) (setq TMP 10.0))
  (set_tile "XINC" (rtos TMP))
 )

 (defun UPDATENE (/ P)
  (setq P (list (atof (get_tile "STATION")) (atof (get_tile "OFFSET"))))
  (setq P (RFL:XY P))
  (if (/= P nil)
   (progn
    (set_tile "NORTHING" (rtos (nth 1 P)))
    (set_tile "EASTING" (rtos (nth 0 P)))
   )
  )
 )

 (defun UPDATESTAOFF (/ P)
  (setq P (list (atof (get_tile "EASTING")) (atof (get_tile "NORTHING"))))
  (setq P (RFL:STAOFF P))
  (if (/= P nil)
   (progn
    (set_tile "STATION" (rtos (nth 0 P)))
    (set_tile "OFFSET" (rtos (nth 1 P)))
   )
   (progn
    (UPDATENE)
   )
  )
 )

 (if (or (= RFL:ALIGNLIST nil) (= RFL:XY nil))
  (princ "\n*** No alignment defined or utilities not loaded ***")
  (progn
   (setq NODE (car RFL:ALIGNLIST))
   (setq STAMIN (car NODE))
   (setq NODE (last RFL:ALIGNLIST))
   (setq STAMAX (+ (car NODE) (RFL:DIST (nth 1 NODE) (nth 2 NODE) (nth 3 node))))

   (if (= XYPDCLNAME nil)
    (progn
     (setq XYPDCLNAME (vl-filename-mktemp "rfl.dcl"))
     (RFL:MAKEDCL XYPDCLNAME "XYP")
    )
    (if (= nil (findfile XYPDCLNAME))
     (progn
      (setq XYPDCLNAME (vl-filename-mktemp "rfl.dcl"))
      (RFL:MAKEDCL XYPDCLNAME "XYP")
     )
    )
   )
   
   (setq DCL_ID (load_dialog XYPDCLNAME))
   (if (not (new_dialog "XYP" DCL_ID)) (exit))

   (if (= nil XYPSTA) (setq XYPSTA STAMIN))
   (if (= nil XYPOS) (setq XYPOS 0.0))

   (if (= nil XYPFROMSTA) (setq XYPFROMSTA STAMIN))
   (if (= nil XYPFROMOS) (setq XYPFROMOS 0.0))
   (if (= nil XYPTOSTA) (setq XYPTOSTA STAMAX))
   (if (= nil XYPTOOS) (setq XYPTOOS 0.0))
   (if (= nil XYPSTEP) (setq XYPSTEP 1))
   (if (= nil XYPXFROMSTA) (setq XYPXFROMSTA STAMIN))
   (if (= nil XYPXTOSTA) (setq XYPXTOSTA STAMAX))
   (if (= nil XYPXROUND) (setq XYPXROUND "1"))
   (if (= nil XYPXSWATH) (setq XYPXSWATH 25.0))
   (if (= nil XYPXINC) (setq XYPXINC 10.0))
   (if (= nil XYPXSPECIAL) (setq XYPXSPECIAL "0"))

   (set_tile "STAMINMAX" (strcat (rtos STAMIN 2 3) " < STA < " (rtos STAMAX 2 3)))
   (set_tile "STATION" (rtos XYPSTA))
   (set_tile "OFFSET" (rtos XYPOS))

   (set_tile "FROMSTATION" (rtos XYPFROMSTA))
   (set_tile "FROMOFFSET" (rtos XYPFROMOS))
   (set_tile "TOSTATION" (rtos XYPTOSTA))
   (set_tile "TOOFFSET" (rtos XYPTOOS))
   (set_tile "STEP" (itoa XYPSTEP))

   (set_tile "XFROMSTATION" (rtos XYPXFROMSTA))
   (set_tile "XTOSTATION" (rtos XYPXTOSTA))
   (set_tile "XROUND" XYPXROUND)
   (set_tile "XSWATH" (rtos XYPXSWATH))
   (set_tile "XINC" (rtos XYPXINC))
   (set_tile "XSPECIAL" XYPXSPECIAL)

   (FIXSTA)
   (FIXOS)
   (FIXFROMSTA)
   (FIXFROMOS)
   (FIXTOSTA)
   (FIXTOOS)
   (FIXSTEP)
   (FIXXFROMSTA)
   (FIXXTOSTA)
   (FIXXSWATH)
   (FIXXINC)

   (action_tile "STATION" "(FIXSTA)")
   (action_tile "OFFSET" "(FIXOS)")
   (action_tile "NORTHING" "(FIXN)")
   (action_tile "EASTING" "(FIXE)")
   (action_tile "FROMSTATION" "(FIXFROMSTA)")
   (action_tile "FROMOFFSET" "(FIXFROMOS)")
   (action_tile "TOSTATION" "(FIXTOSTA)")
   (action_tile "TOOFFSET" "(FIXTOOS)")
   (action_tile "STEP" "(FIXSTEP)")
   (action_tile "XFROMSTATION" "(FIXXFROMSTA)")
   (action_tile "XTOSTATION" "(FIXXTOSTA)")
   (action_tile "XSWATH" "(FIXXSWATH)")
   (action_tile "XINC" "(FIXXINC)")
   (action_tile "OK" "(ACCEPTXYP 0)")
   (action_tile "DRAW" "(ACCEPTXYP -1)")
   (action_tile "XDRAW" "(ACCEPTXYP -2)")
   (action_tile "FROMFILE" "(ACCEPTXYP -3)")
   (action_tile "PICK" "(ACCEPTXYP \"RERUN1\")")
   (action_tile "MPICK" "(ACCEPTXYP \"RERUN2\")")
   (action_tile "XPICK" "(ACCEPTXYP \"RERUN3\")")
   (action_tile "CANCEL" "(CANCELXYP)")

   (start_dialog)

   (if (= CANCEL 0)
    (progn
     (unload_dialog DCL_ID)
     (setq P (RFL:XY (list XYPSTA XYPOS)))
     (if (/= P nil)
      (command "_NON" P)
     )
    )
   )
   (if (= CANCEL -1)
    (progn
     (unload_dialog DCL_ID)
     (RFL:MPOINT2 XYPFROMSTA XYPFROMOS XYPTOSTA XYPTOOS XYPSTEP)
    )
   )
   (if (= CANCEL -2)
    (progn
     (unload_dialog DCL_ID)
     (command)
     (command)
     (setq INC XYPXINC)
     (if (> INC 0.0)
      (progn
       (if (< XYPXFOMSTA XYPXTOSTA)
        (setq STA1 XYPXFROMSTA STA2 XYPXTOSTA)
        (setq STA1 XYPXTOSTA STA2 XYPXFROMSTA)
       )
       (if (= XYPXROUND "1")
        (setq STA (float (* INC (fix (+ 0.99999999 (/ STA1 INC))))))
        (setq STA STA1)
       )
       (while (<= STA STA2)
        (setq P1 (RFL:XY (list STA (* -0.5 XYPXSWATH))))
        (setq P2 (RFL:XY (list STA (* 0.5 XYPXSWATH))))
        (if (/= P1 nil)
         (progn
          ;(command "._LINE" "_NON" P1 "_NON" P2 "")
          (entmake)
          (if (= XYPXSWATH 0.0)
           (progn
            (setq P2 (RFL:XY (list STA 1.0)))
            (setq ANG (angle P1 P2))
            (entmake (list (cons 0 "XLINE")
                           (cons 100 "AcDbEntity")
                           (cons 100 "AcDbXline")
                           (append (list 10) P1 (list 0.0))
                           (list 11 (cos ANG) (sin ANG) 0.0)
                     )
            )
           )
           (entmake (list (cons 0 "LINE")
                          (append (list 10) P1 (list 0.0))
                          (append (list 11) P2 (list 0.0))
                    )
           )
          )
         )
        )
        (setq STA (+ STA INC))
       )
      )
     )
     (if (= XYPXSPECIAL "1")
      (progn
       (setq AL RFL:ALIGNLIST)
       (setq NODE (car AL))
       (setq AL (cdr AL))
       (while (/= NODE nil)
        (setq P1 (RFL:XY (list (car NODE) (* -0.5 XYPXSWATH))))
        (setq P2 (RFL:XY (list (car NODE) (* 0.5 XYPXSWATH))))
        (if (/= P1 nil)
         (progn
          (command "._LINE" "_NON" P1 "_NON" P2 "")
         )
        )
        (setq NODE (car AL))
        (setq AL (cdr AL))
       )
       (setq NODE (last RFL:ALIGNLIST))
       (setq P1 (RFL:XY (list (+ (car NODE) (RFL:DIST (nth 1 NODE) (nth 2 NODE) (nth 3 NODE))) (* -0.5 XYPXSWATH))))
       (setq P2 (RFL:XY (list (+ (car NODE) (RFL:DIST (nth 1 NODE) (nth 2 NODE) (nth 3 NODE))) (* 0.5 XYPXSWATH))))
       (if (/= P1 nil)
        (progn
         (command "._LINE" "_NON" P1 "_NON" P2 "")
        )
       )
      )
     )
    )
   )
   (if (= CANCEL -3)
    (progn
     (unload_dialog DCL_ID)
     (setq INFILE (getfiled "Select a Sta,O/S comma delimited file" "" "" 2))
     (if (/= INFILE nil)
      (progn
       (setq INFILE (open INFILE "r"))
       (setq INLINE (read-line INFILE))
       (while (/= INLINE nil)
        (if (= INLINE "")
         (command "")
         (progn
          (setq P (RFL:XY (list (atof (RFL:COLUMN INLINE 1 ","))
                            (atof (RFL:COLUMN INLINE 2 ",")))))
          (if (/= P nil) (command "_NON" P))
         )
        )
        (setq INLINE (read-line INFILE))
       )
       (close INFILE)
      )
     )
    )
   )
   (if (= CANCEL "RERUN1")
    (progn
     (unload_dialog DCL_ID)
     (setq TMP (RFL:STAOFF (getpoint "\n\n\nPoint :")))
     (if (/= TMP nil)
      (progn
       (setq XYPSTA (nth 0 TMP))
       (setq XYPOS (nth 1 TMP))
      )
     )
     (RFL:XYP)
    )
   )
   (if (= CANCEL "RERUN2")
    (progn
     (unload_dialog DCL_ID)
     (setq TMP (RFL:STAOFF (getpoint "\n\n\nFirst point :")))
     (if (/= TMP nil)
      (progn
       (setq XYPFROMSTA (nth 0 TMP))
       (setq XYPFROMOS (nth 1 TMP))
      )
     )
     (setq TMP (RFL:STAOFF (getpoint "\nSecond point :")))
     (if (/= TMP nil)
      (progn
       (setq XYPTOSTA (nth 0 TMP))
       (setq XYPTOOS (nth 1 TMP))
      )
     )
     (if (> XYPFROMSTA XYPTOSTA)
      (progn
       (setq TMP XYPFROMSTA)
       (setq XYPFROMSTA XYPTOSTA)
       (setq XYPTOSTA TMP)
       (setq TMP XYPFROMOS)
       (setq XYPFROMOS XYPTOOS)
       (setq XYPTOOS TMP)
      )
     )
     (RFL:XYP)
    )
   )
   (if (= CANCEL "RERUN3")
    (progn
     (unload_dialog DCL_ID)
     (setq TMP (RFL:STAOFF (getpoint "\n\n\nFirst point :")))
     (if (/= TMP nil) (setq XYPXFROMSTA (car TMP)))
     (setq TMP (RFL:STAOFF (getpoint "\nSecond point :")))
     (if (/= TMP nil) (setq XYPXTOSTA (car TMP)))
     (if (> XYPXFROMSTA XYPXTOSTA)
      (progn
       (setq TMP XYPXFROMSTA)
       (setq XYPXFROMSTA XYPXTOSTA)
       (setq XYPXTOSTA TMP)
      )
     )
     (RFL:XYP)
    )
   )
  )
 )
)