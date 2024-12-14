#lang racket

;Description of Code:
;  a function which converts whole number values from degrees Celsius to degrees Fahrenheit and vice versa
;  each function has an inner function for the sake of mapping it onto lists
;  main function filters out unusable data, iterates through the list and calls on the inner function for each element
;  returns a list of converted values, or "#<void>" in the place of an element and an error message for each unusable input data


;lists with various different types of elements to test the functions
(define lst1 '(42 -12 6 0 490)) ;this one should produce no error messages, all numbers are integers
(define lst2 '("pig" 14.2 g 19)) ;a mixture of strings, fractional numbers, characters, and whole numbers, should produce 3 messages
(define lst3 '(0 "25.5" #\a #t -10 100.25)) ;more mixed data, these last two lists should both produce 4 errors and 2 successful conversions
(define lst4 '("32.1" 77 #\b #f -14 212.5))


;FUNCTION 1
;first inner function for Celsius to Fahrenheit conversion
(define (inner-convert-to-F C) ;takes 1 argument, C, which is nth element in list
  (if (= C 0) ;implementing conditionals (= ...), (< ...), base case is C = 0
      32
      (if (< C 0)
          (- (inner-convert-to-F (+ C 1)) 1.8) ;implementing recursion, calling function again repeatedly until base case is reached
          (+ (inner-convert-to-F (- C 1)) 1.8)))) ;these two lines are the conversion formula, keeps repeating until C is 0 and adds 1.8 for every degree

;main function that can be mapped onto a list
(define (convert-to-F)
  (lambda (C) ;the list is given value C
    (if (integer? C) ;tests whether or not the nth element of C is an integer, hence filtering out inappropriate data
        (round (inner-convert-to-F C)) ;if the element is a whole number, the inner function is called and the final value is rounded for clarity
        (displayln "whole numbers only")))) ;otherwise this string is printed as an error message and the element is presented as "#<void>" in the list



;FUNCTION 2
;a second inner function for Fahrenheit to Celsius conversion, mirrors first function
(define (inner-convert-to-C F)
      (if (= F 32)
        0
        (if (< F 32)
            (- (inner-convert-to-C (+ F 1)) 0.55555556) ;the difference is the base case (now 32) and the difference per degree (now 0.55555556)
            (+ (inner-convert-to-C (- F 1)) 0.55555556))))

;the main function that calls this second inner function, same filtering method
(define (convert-to-C)
  (lambda (F)
    (if (integer? F)
        (round (inner-convert-to-C F)) ;I chose to round the answers in the main functions only as this was far more accurate in the end
        (displayln "whole numbers only"))))