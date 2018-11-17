;==================foo function part======================
(define-fun lib1 ((x (_ BitVec 32))) (_ BitVec 32)
    (ite (bvsgt x #x0000000a) #x0000000b x)
)
(define-fun foo ((x (_ BitVec 32))) (_ BitVec 32)
    (ite (bvsgt x (lib1 x)) x (lib1 x))
)

;==================bar function part======================
(define-fun lib2 ((x (_ BitVec 32))) (_ BitVec 32)
    (ite (bvsgt x #x0000000a) #x0000000b (bvsub x #x00000001))
)
(define-fun bar ((x (_ BitVec 32))) (_ BitVec 32)
    (ite (bvsgt x (lib2 x)) x (lib2 x))
)
(declare-const x (_ BitVec 32))
(push)
(assert (not (= (foo x) (bar x))))
(check-sat); sat, Therefore there exsit input that can make foo and bar not equal
(get-model)
(pop)

(push)
(assert (= (foo x) (bar x)))
(check-sat); sat, Therefore there exsit input that can make foo and bar equal
(get-model)
(pop)