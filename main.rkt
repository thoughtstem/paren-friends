#lang racket

(require meta-engine 2htdp/image)

(define (face color)
  (register-sprite (circle 40 'solid color)))

(define (paren kind color)
  (register-sprite (text kind 50 color)))

(define (eye color)
  (register-sprite (circle 3 'solid color)))

(define (mouth color (angle -90))
  (register-sprite
    (scale 1
           (add-curve (circle 1 'solid 'transparent)
                      0 10 angle 1/2
                      20 10 (- angle) 1/2
                      (make-pen color 4 "solid" "round" "round")))))

(define (paren-friend kind #:smile s . cs)
  (add-or-replace-components
    (parent
      (children
        (parent
          (relative-position (posn -40 0))
          (sprite (paren kind 'white)))
        (parent
          (relative-position (posn 40 0))
          (relative-rotation pi)
          (sprite (paren kind 'white)))
        (parent
          (relative-position (posn 0 0))
          (children
            (parent
              (relative-position (posn -20 4))
              (sprite (eye 'white)))
            (parent
              (relative-position (posn 20 4))
              (sprite (eye 'white)))
            (parent
              (relative-position (posn 0 0))
              (sprite (mouth 'white s)))))))
    cs))

(play!
  (game
    (paren-friend "(" #:smile 90
      (relative-position (posn 200 100))
      (normal-counter)
      (relative-rotation 0 (/ (get-counter) 100)))
    (paren-friend "{" #:smile 0
      (relative-position (posn 200 200)))
    (paren-friend "[" #:smile -90
      (relative-position (posn 200 300)))))
