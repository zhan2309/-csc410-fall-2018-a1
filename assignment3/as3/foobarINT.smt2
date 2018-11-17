;==================foo function part======================
(define-fun lib1 ((x Int)) Int
    (ite (> x 10) 11 x)
)
(define-fun foo ((x Int)) Int
    (ite (> x (lib1 x)) x (lib1 x))
)

;==================bar function part======================
(define-fun lib2 ((x Int)) Int
    (ite (> x 10) 11 (- x 1))
)
(define-fun bar ((x Int)) Int
    (ite (> x (lib2 x)) x (lib2 x))
)
(declare-const x Int)
(assert (not (= (foo x) (bar x))))
(check-sat); Unsat, Therefore there is no input that can make foo and bar not equal
