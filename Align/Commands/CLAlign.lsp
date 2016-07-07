;
;
;     Program written by Robert Livingston, 2016/07/07
;
;     C:LALIGN is a utility for labelling alignments
;
;
;     NODEMODE = 0  :  LEFT
;     NODEMODE = 1  :  RIGHT
;     NODEMODE = 2  :  INSIDE
;     NODEMODE = 3  :  OUTSIDE
;
;     xxxLAYER  :  '*' concatinates current layer
;
(setq RFL:LALIGNLIST (list (cons "LABELBLOCK" "STALBL")
                           (cons "LABEL" 1)
                           (cons "LABELLAYER" "*-LBL")
                           (cons "LABELINC" 100.0)
                           (cons "LABELSCALE" 1.0)
                           (cons "LABELOFFSET" 3.0)
                           (cons "TICKBLOCK" "STATICK")
                           (cons "TICK" 1)
                           (cons "TICKLAYER" "*-LBL")
                           (cons "TICKINC" 20.0)
                           (cons "TICKSCALE" 1.0)
                           (cons "TICKOFFSET" 0.0)
                           (cons "NODELEFTBLOCK" "STANODELEFT")
                           (cons "NODERIGHTBLOCK" "STANODERIGHT")
                           (cons "NODE" 1)
                           (cons "NODELAYER" "*-LBL")
                           (cons "NODEMODE" 0)
                           (cons "NODESCALE" 1.0)
                           (cons "NODEOFFSET" 0.0)
                     )
)
(defun C:LALIGN (/ ACTIVEDOC ACTIVESPC ENT ENTLIST LLABEL LTICK LNODE P P1 PREVENT)
 (command "._UNDO" "M")
 (vl-load-com)
 (setq ACTIVEDOC (vla-get-activedocument (vlax-get-acad-object)))
 (setq ACTIVESPC
       (vlax-get-property ACTIVEDOC
        (if (or (eq acmodelspace (vla-get-activespace ACTIVEDOC)) (eq :vlax-true (vla-get-mspace ACTIVEDOC)))
         'modelspace
         'paperspace
        )
       )
 )
 (defun LLABEL (/ ANGBASE ANGDIR CLAYER INC NLAYER P STA STAH STAL STAMAX)
  (setq ANGBASE (getvar "ANGBASE"))
  (setvar "ANGBASE" 0.0)
  (setq ANGDIR (getvar "ANGDIR"))
  (setvar "ANGDIR" 0)
  (setq CLAYER (getvar "CLAYER"))
  (setq NLAYER (cdr (assoc "LABELLAYER" RFL:LALIGNLIST)))
  (if (= "*" (substr NLAYER 1 1)) (setq NLAYER (strcat CLAYER (substr NLAYER 2))))
  (if (not (tblsearch "LAYER" NLAYER))
   (entmake (list (cons 0 "LAYER")
                  (cons 100 "AcDbSymbolTableRecord")
                  (cons 100 "AcDbLayerTableRecord")
                  (cons 2 NLAYER)
                  (cons 70 0)
            )
   )
  )
  (setvar "CLAYER" NLAYER)
  (if (not (tblsearch "BLOCK" (cdr (assoc "LABELBLOCK" RFL:LALIGNLIST))))
   (RFL:MAKEENT (cdr (assoc "LABELBLOCK" RFL:LALIGNLIST)))
  )
  (if (tblsearch "BLOCK" (cdr (assoc "LABELBLOCK" RFL:LALIGNLIST)))
   (progn
    (setq STA (float (* (fix (/ (caar ALIGNLIST)
                                (cdr (assoc "LABELINC" RFL:LALIGNLIST))
                             )
                        )
                        (cdr (assoc "LABELINC" RFL:LALIGNLIST))
                     )
              )
    )
    (setq STAEND (+ (caar ALIGNLIST) (RFL:GETALIGNLENGTH)))
    (setq INC (cdr (assoc "LABELINC" RFL:LALIGNLIST)))
    (while (<= STA STAEND)
     (if (setq P (RFL:XY (list STA (cdr (assoc "LABELOFFSET" RFL:LALIGNLIST)))))
      (progn
       (setq P1 (RFL:XY (list STA (- (cdr (assoc "LABELOFFSET" RFL:LALIGNLIST)) 1))))
       (vla-insertblock ACTIVESPC
                        (vlax-3D-point P)
                        (cdr (assoc "LABELBLOCK" RFL:LALIGNLIST))
                        (cdr (assoc "LABELSCALE" RFL:LALIGNLIST))
                        (cdr (assoc "LABELSCALE" RFL:LALIGNLIST))
                        (cdr (assoc "LABELSCALE" RFL:LALIGNLIST))
                        (+ (/ pi 2.0) (angle P1 P))
       )
       (setq ENT (entlast))
       (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
       (if (= 1 (cdr (assoc 66 (setq ENTLIST (entget ENT)))))
        (progn
         (setq STAH (RFL:STATXT STA))
         (setq STAL (substr STAH (+ 2 (vl-string-search "+" STAH))))
         (setq STAH (substr STAH 1 (vl-string-search "+" STAH)))
         (setq ENT (entnext ENT))
         (setq ENTLIST (entget ENT))
         (while (= "ATTRIB" (cdr (assoc 0 ENTLIST)))
          (cond ((= "STAH" (cdr (assoc 2 ENTLIST)))
                 (entmod (subst (cons 1 STAH) (assoc 1 ENTLIST) ENTLIST))
                )
                ((= "STAL" (cdr (assoc 2 ENTLIST)))
                 (entmod (subst (cons 1 STAL) (assoc 1 ENTLIST) ENTLIST))
                )
           )
          (setq ENT (entnext ENT))
          (setq ENTLIST (entget ENT))
         )
        )
       )
      )
     )
     (setq STA (+ STA INC))
    )
   )
   (princ "\n!!! Unable to locate or create Lable Block !!!")
  )
  (setvar "CLAYER" CLAYER)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  1
 )
 (defun LTICK (/ ANGBASE ANGDIR CLAYER INC NLAYER P STA STAMAX)
  (setq ANGBASE (getvar "ANGBASE"))
  (setvar "ANGBASE" 0.0)
  (setq ANGDIR (getvar "ANGDIR"))
  (setvar "ANGDIR" 0)
  (setq CLAYER (getvar "CLAYER"))
  (setq NLAYER (cdr (assoc "TICKLAYER" RFL:LALIGNLIST)))
  (if (= "*" (substr NLAYER 1 1)) (setq NLAYER (strcat CLAYER (substr NLAYER 2))))
  (if (not (tblsearch "LAYER" NLAYER))
   (entmake (list (cons 0 "LAYER")
                  (cons 100 "AcDbSymbolTableRecord")
                  (cons 100 "AcDbLayerTableRecord")
                  (cons 2 NLAYER)
                  (cons 70 0)
            )
   )
  )
  (setvar "CLAYER" NLAYER)
  (if (not (tblsearch "BLOCK" (cdr (assoc "TICKBLOCK" RFL:LALIGNLIST))))
   (RFL:MAKEENT (cdr (assoc "TICKBLOCK" RFL:LALIGNLIST)))
  )
  (if (tblsearch "BLOCK" (cdr (assoc "LABELBLOCK" RFL:LALIGNLIST)))
   (progn
    (setq STA (float (* (fix (/ (caar ALIGNLIST)
                                (cdr (assoc "TICKINC" RFL:LALIGNLIST))
                             )
                        )
                        (cdr (assoc "TICKINC" RFL:LALIGNLIST))
                     )
              )
    )
    (setq STAEND (+ (caar ALIGNLIST) (RFL:GETALIGNLENGTH)))
    (setq INC (cdr (assoc "TICKINC" RFL:LALIGNLIST)))
    (while (<= STA STAEND)
     (if (setq P (RFL:XY (list STA (cdr (assoc "TICKOFFSET" RFL:LALIGNLIST)))))
      (progn
       (setq P1 (RFL:XY (list STA (- (cdr (assoc "TICKOFFSET" RFL:LALIGNLIST)) 1))))
       (vla-insertblock ACTIVESPC
                        (vlax-3D-point P)
                        (cdr (assoc "TICKBLOCK" RFL:LALIGNLIST))
                        (cdr (assoc "TICKSCALE" RFL:LALIGNLIST))
                        (cdr (assoc "TICKSCALE" RFL:LALIGNLIST))
                        (cdr (assoc "TICKSCALE" RFL:LALIGNLIST))
                        (+ (/ pi 2.0) (angle P1 P))
       )
       (setq ENT (entlast))
       (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
      )
     )
     (setq STA (+ STA INC))
    )
   )
   (princ "\n!!! Unable to locate or create Tick Block !!!")
  )
  (setvar "CLAYER" CLAYER)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  1
 )
 (defun LNODE (/ ANGBASE ANGDIR CLAYER NLAYER NODE NODEBLOCK NODEPREV P STA STAH STAMAX)
  (setq ANGBASE (getvar "ANGBASE"))
  (setvar "ANGBASE" 0.0)
  (setq ANGDIR (getvar "ANGDIR"))
  (setvar "ANGDIR" 0)
  (setq CLAYER (getvar "CLAYER"))
  (setq NLAYER (cdr (assoc "NODELAYER" RFL:LALIGNLIST)))
  (if (= "*" (substr NLAYER 1 1)) (setq NLAYER (strcat CLAYER (substr NLAYER 2))))
  (if (not (tblsearch "LAYER" NLAYER))
   (entmake (list (cons 0 "LAYER")
                  (cons 100 "AcDbSymbolTableRecord")
                  (cons 100 "AcDbLayerTableRecord")
                  (cons 2 NLAYER)
                  (cons 70 0)
            )
   )
  )
  (setvar "CLAYER" NLAYER)
  (if (not (tblsearch "BLOCK" (cdr (assoc "NODELEFTBLOCK" RFL:LALIGNLIST))))
   (RFL:MAKEENT (cdr (assoc "NODELEFTBLOCK" RFL:LALIGNLIST)))
  )
  (if (not (tblsearch "BLOCK" (cdr (assoc "NODERIGHTBLOCK" RFL:LALIGNLIST))))
   (RFL:MAKEENT (cdr (assoc "NODERIGHTBLOCK" RFL:LALIGNLIST)))
  )
  (if (and (tblsearch "BLOCK" (cdr (assoc "NODELEFTBLOCK" RFL:LALIGNLIST)))
           (tblsearch "BLOCK" (cdr (assoc "NODERIGHTBLOCK" RFL:LALIGNLIST)))
      )
   (progn
    (setq NODEPREV nil)
    (foreach NODE ALIGNLIST
     (setq STA (car NODE))
     (setq NODEBLOCK (cdr (assoc "NODELEFTBLOCK" RFL:LALIGNLIST)))
     (if (setq P (RFL:XY (list STA (cdr (assoc "NODEOFFSET" RFL:LALIGNLIST)))))
      (progn
       (setq P1 (RFL:XY (list STA (- (cdr (assoc "NODEOFFSET" RFL:LALIGNLIST)) 1))))
       (vla-insertblock ACTIVESPC
                        (vlax-3D-point P)
                        NODEBLOCK
                        (cdr (assoc "NODESCALE" RFL:LALIGNLIST))
                        (cdr (assoc "NODESCALE" RFL:LALIGNLIST))
                        (cdr (assoc "NODESCALE" RFL:LALIGNLIST))
                        (+ (/ pi 2.0) (angle P1 P))
       )
       (setq ENT (entlast))
       (RFL:PUTPREVENT ENT PREVENT)(RFL:PUTNEXTENT PREVENT ENT)(setq PREVENT ENT)
       (if (= 1 (cdr (assoc 66 (setq ENTLIST (entget ENT)))))
        (progn
         (setq STAH (RFL:STATXT STA))
         (setq ENT (entnext ENT))
         (setq ENTLIST (entget ENT))
         (while (= "ATTRIB" (cdr (assoc 0 ENTLIST)))
          (cond ((= "NODE" (cdr (assoc 2 ENTLIST)))
                 (entmod (subst (cons 1 STAH) (assoc 1 ENTLIST) ENTLIST))
                )
           )
          (setq ENT (entnext ENT))
          (setq ENTLIST (entget ENT))
         )
        )
       )
      )
     )
     (setq NODEPREV NODE)
    )
   )
   (princ "\n!!! Unable to locate or create Lable Block !!!")
  )
  (setvar "CLAYER" CLAYER)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  1
 )
 (if ALIGNLIST
  (progn
   (setq PREVENT nil)
   (if (= 1 (cdr (assoc "LABEL" RFL:LALIGNLIST))) (LLABEL))
   (if (= 1 (cdr (assoc "TICK" RFL:LALIGNLIST))) (LTICK))
   (if (= 1 (cdr (assoc "NODE" RFL:LALIGNLIST))) (LNODE))
   T
  )
  (progn
   (princ "\n!!! No alignment defined !!!")
   nil
  )
 )
)
