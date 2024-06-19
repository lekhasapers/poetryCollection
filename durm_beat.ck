// Model Stuff||||||||||||||||||||||||||||||||||||
Word2Vec model;
me.dir() + "glove_appropriate_vectors.txt" => string filepath;

if( !model.load( filepath ) )
{
    <<< "cannot load model:", filepath >>>;
    me.exit();
}


fun void kick(){
    Noise n => LPF f => ADSR e  => dac;
    120 => f.freq;
    10 => f.gain;
    e.set(2::ms, 40::ms, 0.1, 100::ms);
    e.keyOn();
    50::ms => now;
    e.keyOff();
    1000::ms => now;
}

fun void hat(){
    Noise n => HPF f => ADSR e => NRev r => dac;
    2500 => f.freq;
    0.05 => f.gain;
    0.025 => r.mix;
    e.set(5::ms, 50::ms, 0.1, 100::ms);
    e.keyOn();
    50::ms => now;
    e.keyOff();
    1000::ms => now;
}

fun void rim(){
    Noise n => BPF f => ADSR e => NRev r => dac;
    440 => f.freq;
    15. => f.Q;
    10 => f.gain;
    0.025 => r.mix;
    e.set(5::ms, 50::ms, 0.1, 50::ms);
    e.keyOn();
    50::ms => now;
    e.keyOff();
    1000::ms => now;
}

fun void beat() {
    spork ~ kick();
    spork ~ hat();
    400:: ms => now;
    spork ~ rim();
    spork ~ hat();
    400:: ms => now;
    
    
    spork ~ hat(); 
    200::ms => now;
    spork ~ kick();
    220::ms => now; 
    
    spork ~ hat();
    spork ~ kick();
    400::ms => now;
}

while (true) {
    
    beat();
}


