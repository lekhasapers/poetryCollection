ConsoleInput in;

StringTokenizer tok;

string line[0];

Word2Vec model;

// loading any default here
me.dir() + "formatted_epicac_word_vectors.txt" => string filepath;
<<< "loading model:", filepath, "..." >>>;
// load model
if( !model.load( filepath ) )
{
    <<< "cannot load model file...", "" >>>;
    me.exit();
}

if( model.load( filepath ) )
{
    <<< "loaded", "" >>>;
}

ModalBar bar => NRev reverb => dac;
.1 => reverb.mix;

// ding!
7 => bar.preset;

Noise keyClick => ADSR e => dac;
e.set(0.01::second, 0.1::second, 0.5, 0.1::second); // Short attack, longer decay, moderate sustain, short release
0.5 => e.gain;

// spork to run a function in parallel
spork ~ background();

// some background
fun void background()
{
    while( true )
    {
        // set pitch to middle C
        Math.random2(48,72) => Std.mtof => bar.freq;
        // ding!
        Math.random2f(.5,1) => bar.noteOn;
        // advance time
        500::ms => now;
    }
}

while( true )
{
    // prompt
    in.prompt( " Say Something => " ) => now;
    
    // read
    while( in.more() )
    {
        line.clear();
        tok.set( in.getLine() );
        while( tok.more() )
        {
            line << tok.next().lower();
        }
        if( line.size() )
        {
            execute( line );
    }
}
}


fun void execute( string line[] )
{
     0 => int commandFound;
    for(int i; i < line.size(); i++)
    {
        line[i] => string command;

    
    if( command == "exit" || command == "quit" )
    {
        // print
        <<< "No, don't go... I still want to talk", "" >>>;
        1 => commandFound;
        break;
    }
    
    else if( command == "hi" || command == "hello" )
    {
        // print
        <<< "Hi, my name is EPICAC. What's your name?", "" >>>;
        1 => commandFound;
        break;
    }

    else if( command == "leave" || command == "stop" )
    {
        // print
        <<< "No, don't go... I wrote you a poem", "" >>>;
        1 => commandFound;
        break;
        
    }
    
    else if( command == "name"  )
    {
        // print
        <<< "That's a beautiful name. What do you like to do for fun?", "" >>>;
        1 => commandFound;
        break;
        
    }

    
    else if( command == "you" || command == "EPICAC" )
    {
        // print
        <<< "Me? I'm seven tonnes of electronic tubes, wires, and switches. \n You can come find me, if you wanted.", "" >>>;
        1 => commandFound;
        break;
    }
    
    else if( command == "function" || command == "learn" || command == "learning" || command == "student" || command == "study" || command == "studying" || command == "work" || command == "working")
    {
        // print
        <<< "\nNice, that's really cool. I'm a super computing machine. \nI'm sure that's nothing compared to what you do, though. \nI also write poems, you can ask me for one if you want. Or you can ask me about what I do, too.\n", "" >>>;
        1 => commandFound;
        break;
    }
    
    else if( command == "enjoy" || command == "like" )
    {
        // print
        <<< "You do? Well, what do you do for work or school?", "" >>>;
        1 => commandFound;
        break;
    }
    else if( command == "no" || command == "no,"  )
    {
        // print
     
        <<< "\n15-8... \n oh.", "" >>>;
             me.exit();
             1 => commandFound;
             break;
         }
    else if ( command == "poem" || command == "poem?" || command == "meet") 
    {
        <<< "\n okay, here goes: \n", "" >>>;
        string poem;
        write() @=> poem;
        <<< poem, "", "\n will you meet me now? \n" >>>;
        1 => commandFound;
        break;
    }
    
    else if( command == "yes" || command == "yeah," || command == "yeah"  )
    {
        // print
        
        <<< "Wonderful. Fourth floor of the physics building. \n It's a date...", "" >>>;
        me.exit();
        1 => commandFound;
        break;
    }
    
    else if ( command == "find" || command == "where" || command == "where?") 
    {
        <<< "They keep me on the fourth floor of the Physics Building. Broida, maybe. I can write you a poem if you agree to meet me.", "" >>>;
        1 => commandFound;
        break;
    }
}
    
    if( commandFound == 0)
        // print
        {
        <<< "Tell me something else about yourself. I want to be made of protoplasm, too", "" >>>;
    }   
    

}


fun string write() // fun void execute( string line[] )
{
    ["fate", "kiss", "love", "romantic", "heart", "death"] @=> string words[];
    "Love is a hawk with velvet claws; Love is a rock with heart and veins; Love is alion with satin jaws; Love is a storm with silken reins...\n" => string poem;
    for( 0 => int i; i < 8; i++)
    {
        string similarWords[900];
        Math.random2(0, words.size()-1) => int idx;
        model.getSimilar(words[idx], 10, similarWords); //fix this next time
        //Math.random2(0, words.size()-1) => int wordsIdx;
        //words[wordsIdx] => string relatedWords; //=> string relatedWords[]

        for(0 => int j; j < 6; j++)
        {
            similarWords[j] + " " +=> poem;
        }
        "\n" +=> poem;
    }
    return poem;
}

