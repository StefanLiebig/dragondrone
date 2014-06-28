;;(set 'socket (net-connect "192.168.1.1" 5556 "udp"))
;;(println (net-error))
;;(print socket)
;;(set 'cmd {AT*CONFIG=1,"leds:leds_anim","3,1073741824,1"})
;;(print cmd)
;; (net-send-to "192.168.1.1" 5556  "" socket)

(set 'socket (net-listen 5556 "" "udp"))
(if (not socket) (println (net-error)) (println socket))

;;(set 'socket (net-connect "192.168.1.1" 5556 "udp"))
;;(println (net-error))

(for (x 1 1)
	(begin
		(net-send-to "192.168.1.1" 5556 "AT*COMWDG=1\r" socket)
		(set 'cmd (string {AT*CONFIG=} 2 {,"leds:leds_anim","1,1073741824,3"} "\r"))
		(println cmd)
		(net-send-to "192.168.1.1" 5556 cmd socket)
		(println (net-error))
		(sleep 0.03)))
		
(net-close socket)
(println (net-error))

;; (net-send-udp "192.168.1.1" 5556 {AT*CONFIG=605,"leds:leds_anim","0,1073741824,1"} true)

;; (while (not (net-error))
;;	(print "enter something -> ")
;;	(net-send-to  "127.0.0.1" 10001 (read-line) socket)
;;	(net-receive socket buff 255)
;;	(println "=> " buff))
