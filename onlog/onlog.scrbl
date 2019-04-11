#lang scribble/manual

@(require scribble/eval
          (for-label onlog
                     racket/base))

@(define base-eval (make-base-eval
                   '(require onlog)))
 
@title{onlog: perform operations on log files}
 
@defmodule[onlog]

@defproc[(suppress-numbers [input string?]
                           [#:with insert string? "8"])
         string?]{

Replaces consecutive numbers in @racket[input] with @racket[insert].

@examples[
  #:eval base-eval
  (suppress-numbers "[INFO] 9:34 login user10")
  (suppress-numbers "[WARN] 12:56 failed login" #:with "0")
]}
