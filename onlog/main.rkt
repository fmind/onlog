#lang racket/base

(require racket/contract)

(provide
 (contract-out
  [suppress-numbers (->* (string?) (#:with string?) string?)]))

(define (suppress-numbers input #:with [insert "8"])
  (regexp-replace* #px"\\d+" input insert))

(module+ test
  (require rackunit
           quickcheck
           rackunit/quickcheck)
  (test-equal? "can suppress numbers from string"
               (suppress-numbers "[INFO] 9:34 login user10\n[WARN] 12:56 failed login")
               "[INFO] 8:8 login user8\n[WARN] 8:8 failed login")
  (test-equal? "can suppress numbers with custom insert"
               (suppress-numbers "[INFO] 9:34 login user10\n[WARN] 12:56 failed login" #:with "0")
               "[INFO] 0:0 login user0\n[WARN] 0:0 failed login")
  (test-case "input is always longer or the same size as output"
    (check-property
     (property
      ([input arbitrary-string])
      (>= (string-length input)
          (string-length (suppress-numbers input)))))))

(module+ main
  (require racket/cmdline)
  (require racket/sequence)
  (command-line
    #:args (file)
    (define proc suppress-numbers)
    (define input (if (equal? file "-")
                      (current-input-port)
                      (open-input-file file)))
    (for [(line (sequence-map proc (in-lines input)))]
      (display line)
      (newline))))
