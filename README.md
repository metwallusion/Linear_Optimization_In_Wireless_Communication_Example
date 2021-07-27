# Linear_Optimization_In_Wireless_Communication_Example
An example of solving one of the major wireless communication problem (interference) by using linear programming
Screenshot_1 and Screenshot_2 are showing the example
The m file is the solution for this problem
Note here : Function of linprog is not used since we are dealing with syms in matlab, this is why it is done manually.
>>> Input ? n which is the number of users you want to use to formulate a problem of optimization
>>> Output ? Sinr(Signal to interference ratio) , how can it be forumulated ? and of course C_transposed, A matrix and b that are the outcome of any optimization problem
Also check the solution in screenshot_3  


Example digitally written a.k.a not in screenshot :
Consider a wireless communication system as shown in Figure 15.2.
There are n "mobile" users. For each i — 1,..., n, user i transmits a signal to the
base station with power pi and an attenuation factor of hi (i.e., the actual received
signal power at the base station from user i is hipi). When the base station is receiving
from user i, the total received power from all other users is considered "interference"
(i.e., the interference for user i is Z^i hjpj). For the communication with user i
to be reliable, the signal-to-interference ratio must exceed a threshold 7^, where the
"signal" is the received power for user i.

