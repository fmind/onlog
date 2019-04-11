#lang info

(define version "0.1")
(define deps '("base"))
(define build-deps '("quickcheck"
                     "rackunit-lib"))
(define scribblings '(("onlog.scrbl")))
(define racket-launcher-names '("onlog"))
(define racket-launcher-libraries '("main.rkt"))

