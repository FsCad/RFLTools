       ((= (strcase BLKNAME) "SPOTELEVATION2")
        (progn
         (entmake)
         (entmake
          (list
           (cons 0 "BLOCK")
           (cons 2 "spotelevation2")
           (cons 70 2)
           (list 10 0 0 0)
          )
         )
         (entmake
          (list
           (cons 0 "POINT")
           (cons 100 "AcDbEntity")
           (cons 67 0)
           (cons 8 "0")
           (cons 100 "AcDbPoint")
           (list 10 0 0 0)
           (cons 50 0)
          )
         )
         (entmake
          (list
           (cons 0 "ATTDEF")
           (cons 100 "AcDbEntity")
           (cons 67 0)
           (cons 8 "0")
           (cons 100 "AcDbText")
           (list 10 0.00207694 -1.2000018 0)
           (cons 40 0.75)
           (cons 1 "")
           (cons 50 6.28145452)
           (cons 41 1)
           (cons 51 0)
           (cons 7 (getvar "TEXTSTYLE"))
           (cons 71 0)
           (cons 72 4)
           (list 11 0.00207694 -1.2000018 0)
           (cons 100 "AcDbAttributeDefinition")
           (cons 3 "Elevation:")
           (cons 2 "ELEV")
           (cons 70 0)
           (cons 73 0)
           (cons 74 0)
          )
         )
         (entmake (list (cons 0 "ENDBLK")))
        )
       )
