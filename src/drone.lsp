;;
;; newLISP Simple AR.Drone control commands
;;

;; Wireshark filter: udp port 5556

(set 'drone-ip "192.168.1.1")
(set 'drone-cmd-port 5556)
(set 'drone-navdata-port 5554)

;;
;; switch bits on, e.g. (bits-on 0 1) -> 3
;;
(define (bits-on)
	(set 'v 0)
	(dolist (e (args))
		(set 'v (| v  (<< 1 e)))))

;;
;; get the next sequence number or set it to given value, e.g.
;; (seq) -> 1
;; (seq) -> 2
;; (seq 1) -> 1
;; (seq) -> 2
;;
(define (seq)
	(if (empty? (args))
		(++ seq-no)
		(set 'seq-no (first (args)))))

(define (opt-param param)
	(if (null? param) "" (string "," param)))

;; basic send command
(define (send-cmd seq cmd param)
	(net-send-udp drone-ip drone-cmd-port
		(string "AT*" cmd "=" seq (opt-param param) "\r") true))

;; reset communication watch dog
(define (drone-reset-wdg)
	(send-cmd (seq 1) "COMWDG"))

;; flat trim - drone must be on ground
(define (drone-flat-trim)
	(send-cmd (seq) "FTRIM"))

;; led animation "enums"
(set 'led-anims
	'(blink-green-red blink-green blink-red blink-orange snake-green-red fire standard
	  red green red-snake blank right-missile left-missile double-missile
	  front-left-green-others-red front-right-green-others-red rear-right-green-others-red
	  rear-left-green-others-red left-green-right-red left-red-right-green blink-standard))

;;
;; Led animations, e.g. (drone-leds 'blink-green 2.0 5)
;;
(define (drone-leds anim freq secs)
	(send-cmd (seq) "CONFIG" (format {"leds:leds_anim","%d,%d,%d"} (find anim led-anims)  (flt32 freq) secs)))

;; flight animation "enums"
(set 'flight-anims
	'(phi-m30-deg phi-30-deg theta-m30-deg theta-30-deg theta-20deg-yaw-200deg
	theta-20deg-yaw-m200deg turnaround turnaround-godown yaw-shake yaw-dance phi-dance
	theta-dance vz-dance wave phi-theta-mixed double-phi-theta-mixed flip-ahead
	flip-behind flip-left flip-right))

;;
;; Flight animations, e.g. (drone-flight 'wave 5000)
;;
(define (drone-anim anim msecs)
	(send-cmd (seq) "CONFIG" (format {"control:flight_anim","%d,%d"} (find anim flight-anims) msecs)))

(define (drone-max-altitude mm)
	(send-cmd (seq) "CONFIG" (format {"control:altitude_max","%d"} mm)))

(define (drone-takeoff)
	(send-cmd (seq) "REF" (format "%d" (bits-on 18 20 22 24 28 9))))

(define (drone-land)
	(send-cmd (seq) "REF" (format "%d" (bits-on 18 20 22 24 28))))

(define (drone-emergency)
	(send-cmd (seq) "REF" (format "%d" (bits-on 18 20 22 24 28 8))))

(define (drone-move flag roll pitch gaz yaw)
	(send-cmd (seq) "PCMD" (format "%d,%d,%d,%d,%d" flag (flt32 roll) (flt32 pitch) (flt32 gaz) (flt32 yaw))))

(define (drone-hover)
	(drone-move 0 0 0 0 0))

(define (drone-tilt-right amount)
	(drone-move 1 amount 0 0 0 0))

(define (drone-tilt-left amount)
	(drone-tilt-right (sub amount)))

(define (drone-tilt-front amount)
	(drone-tilt-back (sub amount)))

(define (drone-tilt-back amount)
	(drone-move 1 0 amount 0 0))

(define (drone-up amount)
	(drone-move 1 0 0 amount 0))

(define (drone-down amount)
	(drone-up (sub amount)))

(define (drone-spin-right amount)
	(drone-move 1 0 0 0 amount))

(define (drone-spin-left amount)
	(drone-spin-right (sub amount)))

(define (drone-keep-alive)
	(while true
		(drone-reset-wdg)
		(sleep 300)))

;; initialize drone
(define (drone-init)
	(drone-reset-wdg)
	(drone-flat-trim)
;	(set 'pid (spawn 'res (drone-keep-alive)))
	)

;; stop drone
(define (drone-stop)
;	(abort pid)
	)

(define (test)
	(drone-init)
	(sleep 1000)
	(drone-takeoff)
	(sleep 10000)
	(drone-land)
	(sleep 100)
	(drone-stop))

(define (test-anim)
	(drone-init)
	(sleep 1000)
	(drone-takeoff)
	(sleep 5000)
	(drone-anim 'yaw-shake 5000)
	(sleep 5000)
	(drone-land)
	(sleep 100)
	(drone-stop))

(define (test-anims)
	(drone-anim 'phi-m30-deg 5000)
	(drone-anim 'phi-30-deg 5000)
	(drone-anim 'theta-m30-deg 5000)
	(drone-anim 'theta-30-deg 5000)
	(drone-anim 'theta-20deg-yaw-200deg 5000)
	(drone-anim 'theta-20deg-yaw-m200deg 5000)
	(drone-anim 'turnaround 5000)
	(drone-anim 'turnaround-godown 5000)
	(drone-anim 'yaw-shake 5000)
	(drone-anim 'yaw-dance 5000)
	(drone-anim 'phi-dance 5000)
	(drone-anim 'theta-dance  5000)
	(drone-anim 'vz-dance  5000)
	(drone-anim 'wave  5000)
	(drone-anim 'phi-theta-mixed 5000)
	(drone-anim 'double-phi-theta-mixed 5000)
	(drone-anim 'flip-ahead 5000)
	(drone-anim 'flip-behind  5000)
	(drone-anim 'flip-left  5000)
	(drone-anim 'flip-right 5000))

(s-log "drone loaded")
