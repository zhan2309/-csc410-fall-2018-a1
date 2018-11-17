(define-fun checkSecure ((p String)) Bool
(ite (< (str.len p) 5) false
  (ite (and (not (str.contains p "$")) (not (str.contains p "!"))) false 
  		(ite (and (not (str.contains p "0")) (not (str.contains p "9"))) false true)
	)
))
(declare-const x String)
(push)
(assert (= (checkSecure x) true))
(check-sat)
(get-model)
(pop)
(assert (= (checkSecure x) false))
(check-sat)
(get-model)