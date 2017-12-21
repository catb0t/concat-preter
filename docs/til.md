s o t: 			o = translator
s o action: o = translator of type interpreter

2 phase: 
s [o] f [o] t
s [o] f [o] action
   1		 2
1: source -> form
2: form -> translation

threaded code interpter produces analysed internal form which is a series of forms threaded together
TCIs can augment internal forms because of form phase

runtime > vm > {threadpool > threadctx | stack names globals gc}

