(defun RFL:AXY (AL STA SWATH / ALSAVE ENTLIST OFFSET1 OFFSET2 OFFSET3 P1 P2 P3)
 (setq ENTLIST (entget ENT))
 (if (= (cdr (assoc 0 ENTLIST)) "LWPOLYLINE")
  (progn
   (setq P1 (XY (list STA (/ SWATH -2.0))))
   (setq P2 (XY (list STA (/ SWATH 2.0))))
   (if (and (/= P1 nil) (/= P2 nil))
    (progn
     (setq ALSAVE ALIGNLIST)
     (setq ALIGNLIST AL)
     (if (= nil ALIGNLIST)
      (progn
       (setq ALIGNLIST ALSAVE)
       (eval nil)
      )
      (progn
       (setq OFFSET1 (STAOFF P1))
       (setq OFFSET2 (STAOFF P2))
       (setq P3 (list (/ (+ (car P1) (car P2)) 2.0) (/ (+ (cadr P1) (cadr P2)) 2.0)))
       (setq OFFSET3 (STAOFF P3))
       (if (= OFFSET1 nil)
        (progn
         (setq P1 P3)
         (setq OFFSET1 OFFSET3)
        )
       )
       (if (= OFFSET2 nil)
        (progn
         (setq P2 P3)
         (setq OFFSET2 OFFSET3)
        )
       )
       (if (and (/= OFFSET1 nil) (/= OFFSET2 nil))
        (progn
         (setq OFFSET1 (cadr OFFSET1))
         (setq OFFSET2 (cadr OFFSET2))
         (if (> (* OFFSET1 OFFSET2) 0.0)
          (progn
           (setq ALIGNLIST ALSAVE)
           (eval nil)
          )
          (progn
           (while (> (distance P1 P2) RFL:TOL)
            (setq P3 (list (/ (+ (car P1) (car P2)) 2.0) (/ (+ (cadr P1) (cadr P2)) 2.0)))
            (setq OFFSET3 (cadr (STAOFF P3)))
            (if (> (* OFFSET1 OFFSET3) 0.0)
             (setq P1 P3)
             (setq P2 P3)
            )
           )
           (setq ALIGNLIST ALSAVE)
           (setq P3 P3)
          )
         )
        )
        (progn
         (eval nil)
        )
       )
      )
     )
    )
    (progn
     (eval nil)
    )
   )
  )
  (progn
   (eval nil)
  )
 )
)