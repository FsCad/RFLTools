       ((= (strcase BLKNAME) "SLOPE")
        (progn
         (entmake)
         (entmake
          (list
           (cons 0 "BLOCK")
           (cons 2 "SLOPE")
           (cons 70 2)
           (cons 4 "")
           (list 10 0 0 0)
          )
         )
         (entmake
          (list
           (cons 0 "SOLID")
           (cons 67 0)
           (cons 8 "0")
           (list 10 1.5 -0.25 0)
           (list 11 2.5 0 0)
           (list 12 1.5 0.25 0)
           (list 13 1.5 0.25 0)
           (cons 39 0)
          )
         )
         (entmake
          (list
           (cons 0 "LINE")
           (cons 67 0)
           (cons 8 "0")
           (list 10 -2.5 0 0)
           (list 11 1.5 0 0)
          )
         )
         (entmake
          (list
           (cons 0 "ATTDEF")
           (cons 67 0)
           (cons 8 "0")
           (list 10 0 1.2 0)
           (cons 40 0.75)
           (cons 1 "")
           (cons 50 0)
           (cons 41 1)
           (cons 51 0)
           (cons 7 (getvar "TEXTSTYLE"))
           (cons 71 0)
           (cons 72 4)
           (list 11 0 1.2 0)
           (cons 3 "Slope:")
           (cons 2 "SLOPE")
           (cons 70 0)
           (cons 73 0)
           (cons 74 0)
          )
         )
         (entmake (list (cons 0 "ENDBLK")))
        )
       )
