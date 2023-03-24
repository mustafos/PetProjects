import UIKit

//Thread
//Operation
//GCD

//1Paralels ----------------
//2Thread// ----------------

//-------------Consistent thread -------
//1Thread  ––  ––   –
//2Thread –  ––  ––– ––

//----------- Asynhronous thread ------------
//1Main(UI) -------------
//2Thread         -

//Unix – POSIX
var thread = pthread_t(bitPattern: 0) // create thread
var attribut = pthread_attr_t()

pthread_attr_init(&attribut)
pthread_create(&thread, &attribut, { (pointer) -> UnsafeMutableRawPointer? in
    print("test")
    return nil
}, nil)

//2 Thread
var nsthread = Thread {
    print("test")
}
nsthread.start()
nsthread.cancel()
