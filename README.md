# DragonDrone - Fly an Parrot AR.Drone 2.0 with [newLISP](http://www.newlisp.org/)

This project is heavily inspired by [Carin Meier's](http://gigasquidsoftware.com/#/about/index) [Clojure Drone](https://github.com/gigasquid/clj-drone) project which controls an [Parrot AR Drone 2.0](http://ardrone2.parrot.com/) with [Clojure](http://clojure.org/).

Clojure compared to newLISP is *heavy-weighted* and I wondered how far I would come with newLISP.


### How do I get set up? ###

* Get newLISP
* Clone the repo
* load the clonectrl.lsp from the newLISP shell
* connect to the AR.Drone's wifi
* (drone-control) - starts a simple "event loop" to control the drone with the keyboard
* alternativly just call the functions from drone.lsp from the newLISP shell

## License

Copyright © 2014 Stefan Liebig

Distributed under the Eclipse Public License.

