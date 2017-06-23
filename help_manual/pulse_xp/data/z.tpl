! command file created by hormone_20060317 on 03/17/2006 at 11:51:45
Algorithm AutoDecon
READ_FIX
F:\pulse_xp\data\%1
<EOF>
DECON_Automatic
        5.000000E-02
    1
         0.00000
    1
         <default>
    1
    0
         %2
STORE_RESULTS
WRITE_NATIVE F:\pulse_xp\data\%~n1_%~n2.dat 
Exit
EXit

