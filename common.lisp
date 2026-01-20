(defmacro filter (name predicate lst)
  `(mapcan #'(lambda (,name) (and ,predicate (list ,name))) ,lst)
  )

(defun modify-nth (n f lst)
  (cond
    ((atom lst) nil)
    ((not (numberp n)) nil)
    ((zerop n) (cons (funcall f (car lst)) (cdr lst)))
    (t (cons (car lst) (modify-nth (- n 1) f (cdr lst))))
    ))
