
Noise n => BiQuad f => LPF l => dac;
0.99 => f.prad; //DONT CHANGE BEYOND 1 PLEASE
0.8 => n.gain;
.002 => f.gain;
1 => f.eqzs; 

float e;

while( true )
{
  (Math.fabs((Math.tan(e)/4) * 3000.0)) => f.pfreq;
  (Math.randomize()) => f.zfreq;
  
 
    e + .06 => e;
    125::ms => now;
}

