;;
;; simple newlisp ncurses binding to get key codes
;;

;; import functions from ncurses lib
(set 'ncfuncs '( "initscr" "endwin" "getch" "cbreak" "keypad"))
;(define (import-ncurses) (dolist (x ncfuncs ) (import "/usr/lib/libncurses.dylib" x)))
(define (import-ncurses) (dolist (x ncfuncs ) (import "libncurses.dylib" x)))
(import-ncurses)

(set 'key-up 259 'key-down 258 'key-left 260 'key-right 261
	 'fn-key-up 339 'fn-key-down 338 'fn-key-left 262 'fn-key-right 360
	 'key-space 32 'key-tab 9 'key-cr 10 'key-backspace 127 'key-lt 60 'key-gt 62 'key-esc 27 'key-plus 43 'key-hash 35
	 'key-0 48 'key-9 57
	 'key-a 97 'key-z 122 'key-A 65 'key-Z 90)

;; get a key
(define (get-key)
	(set 'stdscr (initscr))
	(cbreak)
	(keypad stdscr 1)
	(set 'key (getch))
	(endwin)
;;	(println (string "key: " key))
	key)

(s-log "ncurses loaded")
