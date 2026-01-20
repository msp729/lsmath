(load "common.lisp")

(defun simp-zero (redex)
  (cond
    ((atom redex) redex)
    ((equalp redex '(+)) 0)
    ((equalp redex '(*)) 1)
    (t (mapcar #'simp-zero redex))
    ))

(defun simp-one (redex)
  (cond
    ((atom redex) redex)
    ((not (equalp 2 (length redex))) (mapcar #'simp-one redex))
    ((equalp (car redex) '+) (simp-one (cadr redex)))
    ((equalp (car redex) '*) (simp-one (cadr redex)))
    (t (mapcar #'simp-one redex))
    ))

(defun simp-ident (redex)
  (if (atom redex)
    redex
    (let ((fn (car redex)) (xs (cdr redex)))
      (cond
        ((eq fn '+) (cons fn (mapcar #'simp-ident (filter x (not (and (numberp x) (zerop x))) xs))))
        ((eq fn '*) (cons fn (mapcar #'simp-ident (filter x (not (and (numberp x) (equalp x 1))) xs))))
        (t (mapcar #'simp-ident redex))
        ))
    ))

(defun simp-absorb (redex)
  (if (atom redex)
    redex
    (let ((fn (car redex)) (xs (cdr redex)))
      (cond
        ((and (eq fn '*) (find 0 xs)) 0)
        (t (mapcar #'simp-absorb redex))
        ))
    ))

(defun simp (redex)
  "Simplifies expressions."
  ; steps of simplification:
  ;   remove identities
  ;   reduce 1-length operations
  ;   reduce 0-length operations
  ;   shortcut with absorbing elements
  ;   ??
  (let ((redend (simp-absorb (simp-zero (simp-one (simp-ident redex))))))
    (if (equalp redex redend)
      redex
      (simp redend)
      )
    )
  )
