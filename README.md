# DragonDrone - Fly an Parrot AR.Drone 2.0 with [newLISP](http://www.newlisp.org/)

This project is heavily inspired by [Carin Meier's](http://gigasquidsoftware.com/#/about/index) [Clojure Drone](https://github.com/gigasquid/clj-drone) project which controls an [Parrot AR Drone 2.0](http://ardrone2.parrot.com/) with [Clojure](http://clojure.org/).

This project uses newLISP which is compared to Clojure a flyweight.


### How do I get set up?

* Get newLISP
* Clone the repo
* load the clonectrl.lsp from the newLISP shell
* connect to the AR.Drone's wifi
* (drone-control) - starts a simple "event loop" to control the drone with the keyboard
* alternativly just call the functions from drone.lsp from the newLISP shell

### Current state

* only tested under Mac OS X 10.7.5
* no navigation data and video streaming yet
* my Lisp needs to improve

## License

Copyright © 2014 Stefan Liebig

Distributed under the [Eclipse Public License 1.0](https://www.eclipse.org/legal/epl-v10.html)

