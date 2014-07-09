# DragonDrone - Fly an Parrot AR.Drone 2.0 with [newLISP](http://www.newlisp.org/)

This project is inspired by [Carin Meier's](http://gigasquidsoftware.com/#/about/index) [Clojure Drone](https://github.com/gigasquid/clj-drone) project which controls an [Parrot AR Drone 2.0](http://ardrone2.parrot.com/) with [Clojure](http://clojure.org/).

This project uses newLISP which is compared to Clojure a flyweight.


### How to get started?

* Get newLISP
* Clone the repo
* load the clonectrl.lsp from the newLISP shell
* connect to the AR.Drone's wifi
* (drone-control) - starts a simple "event loop" to control the drone with the keyboard (see dronectrl.lsp)
* alternativly just call the functions from drone.lsp from the newLISP shell
* .. and an AR.Drone would be fine

### Current state

* only tested under Mac OS X 10.7.5 and newLISP 10.6.0
* no navigation data and video streaming yet
* my Lisp needs to improve (feedback welcome)

My .init.lsp contains a few functions and setup that are required for this project:

	;; set local to the "C" locale on UT8
	(if utf8
		(set-locale "C"))
	
	;; test for 32-bit-ness
	(define (bit32?)
		(= (& (sys-info -1) 256)))
	
	;; define flt32 depending on the bit-ness
	(if (bit32?)
		(constant 'flt32 flt)
		(define (flt32 f)
			(first (unpack "ld" (pack "f" f)))))
	
	;; cool prompt ;-)
	(prompt-event
		(if (= ostype "Win32")
			(fn (ctx) (string (char 159) ": "))     ;; win32 a nice 'f' (like function)
			(fn (ctx) (string (char 955) ": "))))   ;; otherwise a cool lambda
	
	;; simple logger
	(define (s-log msg)
		(println msg)
		nil)

 
The prompt-event function is not needed ;-)

## License

Copyright © 2014 Stefan Liebig

Distributed under the [Eclipse Public License 1.0](https://www.eclipse.org/legal/epl-v10.html)

