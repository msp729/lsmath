(load "common.lisp")

(defun derivative (var expr)
  (cond
    ((eq var expr) 1)
    ((atom expr) 0)
    (t (let ((f (car expr)) (xs (cdr expr)))
         (cond
           ((eq f '+) (cons '+ (mapcar #'(lambda (x) (derivative var x)) xs)))
           ((eq f '-) (cons '- (mapcar #'(lambda (x) (derivative var x)) xs)))
           ((eq f '*) (cons '+ (mapcar #'(lambda (x) (modify-nth x #'(lambda (y) (derivative var y)) expr))
                                       (loop for n from 1 to (length xs) collect n))))
           ((eq f 'exp) `(* ,(derivative var (car xs)) (exp . ,xs)))
           ((eq f 'sin) `(* ,(derivative var (car xs)) (cos . ,xs)))
           ((eq f 'cos) `(* ,(derivative var (car xs)) -1 (sin . ,xs)))
           )
         )
       )
    )
  )

(defmacro diff (var expr)
  `(quote ,(derivative var expr)))
