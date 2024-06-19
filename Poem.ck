// Model Stuff||||||||||||||||||||||||||||||||||||
Word2Vec model;
me.dir() + "glove_appropriate_vectors.txt" => string filepath;

if( !model.load( filepath ) )
{
    <<< "cannot load model:", filepath >>>;
    me.exit();
}

// Music stuff|||||||||||||||||||||||||||||||||||
fun void kick() {
    Noise n => LPF f => ADSR e => dac;
    120 => f.freq;
    10 => f.gain;
    e.set(2::ms, 40::ms, 0.1, 100::ms);
    e.keyOn();
    50::ms => now;
    e.keyOff();
    1000::ms => now;
}

fun void hat() {
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

fun void rim() {
    Noise n => BPF f => ADSR e => NRev r => dac;
    440 => f.freq;
    15.0 => f.Q;
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
    400::ms => now;
    spork ~ rim();
    spork ~ hat();
    400::ms => now;
    
    spork ~ hat();
    200::ms => now;
    spork ~ kick();
    220::ms => now;
    
    spork ~ hat();
    spork ~ kick();
    400::ms => now;
}

// Poetry Stuff ||||||||||||||||||||||||||||||||

fun void say(string word, dur wait) {
    chout <= word; chout.flush();
    wait => now;
}

fun void intro() {
    say("Welcome ", 200::ms);
    say("to ", 200::ms);
    say("your ", 200::ms);
    say("personal ", 200::ms);
    say("rap ", 200::ms);
    say("concert!!!!\n", 300::ms);
    
    say("You'll ", 200::ms);
    say("hear ", 600::ms);
    say("from ", 400::ms);
    say("Kendrick ", 200::ms);
    say("Lamar, ", 500::ms);
    say("who ", 200::ms);
    say("is ", 500::ms);
    say("one ", 500::ms);
    say("of ", 200::ms);
    say("the ", 200::ms);
    say("most ", 200::ms);
    say("electric ", 200::ms);
    say("artists ", 200::ms);
    say("of ", 200::ms);
    say("the ", 200::ms);
    say("era.\n", 600::ms);
    
    say("He'll ", 500::ms);
    say("be ", 200::ms);
    say("rapping ", 200::ms);
    say("a ", 200::ms);
    say("variation ", 200::ms);
    say("of ", 200::ms);
    say("Bitch, ", 200::ms);
    say("Don't ", 700::ms);
    say("Kill ", 700::ms);
    say("My ", 700::ms);
    say("Vibe ", 700::ms);
    say("over ", 300::ms);
    say("an ", 200::ms);
    say("INSANELY ", 800::ms);
    say("funky", 500::ms);
    say("drum beat\n ", 600::ms);
}

fun void songbegin(int w2v) {
    ["sinner", "sin", "homie", "money", "kunta", "god", "baby",
    "home", "street", "me", "vibe"] @=> string words[];
    
    ["sin again", "tell again", "look again", "rap again",
    "blow again", "feel again", "need again", "live again", "call again"] @=> string verbs[];
    
    say("\n", 0::ms);
    //if (w2v) {
    string choices[2];
    for (0 => int i; i < 1; i++) {
        say("I ", 300::ms);
        say("am ", 700::ms);
        say("a ", 150::ms);
        say(".", 150::ms);
        say(".", 150::ms);
        say(". ", 400::ms);
        
        Math.random2(0, words.size()-1) => int idx;
        model.getSimilar(words[idx], choices.size(), choices);
        
        if (choices.size() >=! 0) {
            Math.random2(0, choices.size()-1) => int choicesIdx;
            choices[choicesIdx] => string choice;
            say(choice + "\n", 700::ms);
        } else {
            words[idx] => string fallback;
            say(fallback + "\n", 700::ms);
        }
    }

    
    for (0 => int i; i < 1; i++) {      
        say("Who's ", 300::ms);
        say("probably ", 700::ms);
        say("going ", 150::ms);
        say("to", 150::ms);
        say(".", 150::ms);
        say(".", 400::ms);
        say(". ", 400::ms);
        
        Math.random2(0, verbs.size()-1) => int idx;
        say(verbs[idx] + "\n", 1000::ms);
        
    } for (0 => int i; i < 1; i++) {      
        say("Lord, ", 300::ms);
        say("forgive ", 300::ms);

        
        Math.random2(0, words.size()-1) => int idx;
        say(words[idx] + "\n", 400::ms);
        
    }
    
    
    
    
    //else {
        for (0 => int i; i < 1; i++) {
            say("Some ", 400::ms);
            say("things ", 1000::ms);
            say("I ", 200::ms);
            say("don't ", 200::ms);
            say(".", 150::ms);
            say(".", 400::ms);
            say(". ", 400::ms);
            Math.random2(0, words.size()-1) => int idx;
            say(words[idx] + "\n", 1000::ms);
  
        
    }
       for (0 => int i; i < 1; i++) {      
            say("Sometimes ", 600::ms);
            say("I ", 200::ms);
            say("need ", 200::ms);
            say("to ", 200::ms);
            say("be", 500::ms);
            say(".", 200::ms);
            say(".", 200::ms);
            say(". ", 200::ms);
            
            Math.random2(0, words.size()-1) => int idx;
            say(words[idx] + "\n", 200::ms);
    }
}
fun void songmid(int w2v) {
    ["bridge", "planet", "shit", "vibe", "chain", "lock"] @=> string words[];
    ["tell it", "sin it", "share it", "look at it", "rap it",
    "blow it", "feel it", "need it", "live it", "call it"] @=> string verbs[];
    
    say("\n", 0::ms);
   // if (w2v) {
        string choices[2];
        for (0 => int i; i < 1; i++) {
            say("Don't ", 80::ms);
            say("kill ", 300::ms);
            say("my ", 80::ms);
            say(".", 80::ms);
            say(".", 80::ms);
            say(". ", 800::ms);
            Math.random2(0, words.size()-1) => int idx;
            say(words[idx] + "\n", 1000::ms); 
      }
        for (0 => int i; i < 1; i++) {
            say("Don't ", 100::ms);
            say("kill ", 300::ms);
            say("my", 80::ms);
            say(".", 80::ms);
            say(".", 80::ms);
            say(". ", 200::ms);
            
            Math.random2(0, words.size()-1) => int idx;
            say(words[idx] + "\n", 1000::ms); 
            

        }
        
        for (0 => int i; i < 1; i++) {
            say("I've got ", 100::ms);
            say("my ", 300::ms);
            say(".", 80::ms);
            say(".", 80::ms);
            say(". ", 200::ms);
            
            Math.random2(0, words.size()-1) => int idx;
            model.getSimilar(words[idx], choices.size(), choices);
            
            if (choices.size() >=! 0) {
                Math.random2(0, choices.size()-1) => int choicesIdx;
                choices[choicesIdx] => string choice;
                say(choice + "\n", 700::ms);
            } else {
                words[idx] => string fallback;
                say(fallback + "\n", 700::ms);
            } 
            
            
        }
        
        for (0 => int i; i < 1; i++) {
            say("I've got ", 100::ms);
            say("my ", 300::ms);
            say(".", 80::ms);
            say(".", 80::ms);
            say(". ", 200::ms);
            
            Math.random2(0, words.size()-1) => int idx;
            say(words[idx] + "\n", 1000::ms); 
            
            
        }
        for (0 => int i; i < 1; i++) {
            say("I ", 100::ms);
            say("will ", 300::ms);
            say(".", 80::ms);
            say(".", 80::ms);
            say(". ", 200::ms);
            
            Math.random2(0, verbs.size()-1) => int idx;
            say(verbs[idx] + "\n", 1000::ms); 
        }
       
        
        say("\n", 1000::ms);
        say("But ", 400::ms);
        say("today ", 400::ms);
        say("I'm ", 400::ms);
        say("yelling\n", 400::ms);
        say("Please ", 400::ms);
        say("don't ", 400::ms);
        say("kill ", 400::ms);
        say("my ", 400::ms);
        say("vibe", 900::ms);
        say(".", 1000::ms);
        
    }


int id;

fun void startBeat() {
    Machine.add( me.dir() + "durm_beat.ck:foo" ) => int id;
}

fun void stopBeat() {
    Machine.remove(int id);
    
}



// Sporking functions
spork ~ intro();
16::second => now;

// Music and songbegin
startBeat();
spork ~ songbegin(0); // Call songbegin with the appropriate argument
14::second => now;


spork ~ songmid(0); // Call songmid with the appropriate argument
14::second => now;
stopBeat();

    100::ms => now;
    Machine.removeAllShreds();

