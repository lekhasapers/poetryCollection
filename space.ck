//to do: write music for this piece 
//

GScene scene; 
GCamera camera; 
scene.backgroundColor(@(1.0,1.0,1.0));
camera.clip(2.0, 1000);
camera.posZ(16);

NormalsMaterial Mats;

// default material values
40.0 => float LINE_SIZE;
//@(.99,.9,9.0) => vec3 DEFAULT_COLOR;

    Mats @=> NormalsMaterial @ mat;
    mat.pointSize(LINE_SIZE);
    mat.attenuatePoints(false);
    mat.transparent(false);
    mat.color(vec3 rgb2hsv) => vec3 DEFAULT_COLOR;


// geometry =============================================
2000 => int NUM_LINES;
//3 => int LINES_SPREAD;
vec3 linePos[NUM_LINES];

//for (int i; i < 1000; i++) {
    //@(
    //Math.random2(-LINES_SPREAD, LINES_SPREAD),  
   // Math.random2(-LINES_SPREAD, LINES_SPREAD),  
   // Math.random2(-LINES_SPREAD, LINES_SPREAD)
   // ) => linePos[i]; for when i used custom geom
//}

LatheGeometry latheGeo;
TorusGeometry torusGeo;
//PlaneGeometry planeGeo;
SphereGeometry starGeo;

latheGeo.positions(linePos);
fun void LatheStuff() {
    200 => int pathCount;
    float points[0];
    for ( int i; i < pathCount; i ++ ) {
        i * Math.PI / pathCount => float theta;
        Math.sin(theta) => float x;
        Math.cos(theta) => float y;
        points << x;
        points << y;
    }
    40 => int segments;
    Math.PI => float Start;
    Math.PI * 2 => float Length;
    
    // set geometry
    latheGeo.set(points, segments, Start, Length);
    while (true) {
        now / second => float xtime;
        (Math.sin(.3 * xtime) * 5 + 20 ) $ int => segments;
        Math.sin(.5 * xtime) * Math.PI + Math.PI => Length;
        
        latheGeo.set(segments, Start, Length);
        
        GG.nextFrame() => now;
    }
}
spork ~ LatheStuff();


fun void torusStuff() {
    1.0 => float radius;
    0.9 => float tubeRadius;
    10 => int radialSegments;
    48 => int tubularSegments;
    Math.PI *2  => float arcLen;
    
    .5 => float size;
    
    while (true) {
        (now / second) => float ftime;
        Math.sin(.2 * ftime) * size + size => radius;
        Math.sin(.1 * ftime) * 0.2 + 0.22 => tubeRadius;
        (Math.sin(.1 * ftime) * 12 + 14) $ int => radialSegments;
        (Math.sin(.1 * ftime) * 40 + 45) $ int => tubularSegments;
        torusGeo.set(radius, tubeRadius, radialSegments, tubularSegments, arcLen);
        GG.nextFrame() => now;
    }
}
spork ~ torusStuff();

////AAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
fun void stars() {
    0.04 => float radius;
    1 => int widthSeg;
    1 => int heightSeg;
    0.1 => float phiStart;
    0.1 => float phiLength;
    0.1 => float thetaStart;
    0.1 => float thetaLength;
                vec3 starColors[1];
                @(0.0, 0.0, 0.0) => starColors[0];
                starGeo.colors(starColors);
    
    
    while (true) {
        (now / second) => float ztime;
        2000 => int starCount;
        for ( int i; i < starCount; i ++ ) {
            starGeo.set(radius, widthSeg, heightSeg, phiStart, phiLength, thetaStart, thetaLength);

        }
        GG.nextFrame() => now;
        
        //scene.backgroundColor(@(1.0,1.0,1.0))
    }
}

spork ~ stars();
    


//fun void planeStuff() {
    //0.05 => float width;
   // 0.5 => float height;
    //1 => int widthSegments;
   // 1 => int heightSegments;
    
    
    //.01 => float size;
    
        //while (true) {
           //(now / second) => float ftime;
            //Math.sin(.2 * ftime) * size + size => width;
            //Math.sin(.3 * ftime) * size + size => height;
            //planeGeo.set(width, height, widthSegments, heightSegments);
           // GG.nextFrame() => now;
          // }
//}
//spork ~ planeStuff();


// meshes  ==============================================
GGen lensflareEffect --> scene;
GMesh lensflares[20];

20 => int AXIS_LENGTH;

for (int i; i < 20; i++) {
    lensflares[i] @=> GMesh @ lensflare;
    lensflares[i].set(latheGeo, Mats);
    lensflares[i].set(torusGeo, Mats); 
    //lensflares[i].set(starGeo, Mats);
    //lensflares[i].set(planeGeo, Mats);//setting geo + material
    lensflares[i] --> lensflareEffect;
    
    // randomize rotation
    .29 => float s;
    Math.random2f(0, s*Math.TWO_PI) => lensflare.rotX;
    Math.random2f(0, s*Math.TWO_PI) => lensflare.rotY;
    Math.random2f(0, s*Math.TWO_PI) => lensflare.rotZ;
}



// UI Controls ==========================================
UI_Window window;
window.text("Line Controls");

// pointsize
UI_SliderFloat pointSizeSlider;
pointSizeSlider.text("Size");
pointSizeSlider.range(0.1, 500.0);
pointSizeSlider.val(LINE_SIZE); 



// color
UI_Color3 lineColor;
lineColor.text("Color");
lineColor.val(DEFAULT_COLOR);//DEFAULT_COLOR);

//Audio Test


// Camera Z Pos
UI_SliderFloat cameraZSlider;
cameraZSlider.text("Camera Z Position");
cameraZSlider.range(0.0, 50.0);
cameraZSlider.val(camera.posZ()); 

// Camera Y Pos
UI_SliderFloat cameraYSlider;
cameraYSlider.text("Camera Y Position");
cameraYSlider.range(0.0, 1.0);
cameraYSlider.val(camera.posY()); 

// Camera X Pos
UI_SliderFloat cameraXSlider;
cameraXSlider.text("Camera X Position");
cameraXSlider.range(0.0, 1.0);
cameraXSlider.val(camera.posX()); 

// Wind Speed
UI_SliderFloat windSpeedSlider;
windSpeedSlider.text("Wind Speed");
windSpeedSlider.range(0.0, 1.0);
windSpeedSlider.val(0.5);  

//Invert FX
UI_SliderFloat invertSlider;
invertSlider.text("Color Inversion BROKEN");
invertSlider.range(0.0, 0.01);
invertSlider.val(0.0);


window.add(pointSizeSlider); 
window.add(lineColor); 
window.add(cameraZSlider); 
window.add(cameraYSlider); //broken
window.add(cameraXSlider); //broken
window.add(windSpeedSlider);
window.add(invertSlider);


// UI Event Handlers ====================================
fun void PointSizeListener() {
    while (true) {
        pointSizeSlider => now;
        pointSizeSlider.val() => float ps;

    }
} 
spork ~ PointSizeListener();


fun void ColorListener() {
    while (true) {
        lineColor => now;
        lineColor.val() => vec3 rgb;

    }
} spork ~ ColorListener();


fun void CameraZListener() {
    while (true) {
        cameraZSlider => now;
        cameraZSlider.val() => camera.posZ;
    }
} spork ~ CameraZListener();

fun void CameraXListener() {
    while (true) {
        cameraXSlider => now;
        cameraXSlider.val() => camera.posX;
    }
} spork ~ CameraXListener();

fun void CameraYListener() {
    while (true) {
        cameraYSlider => now;
        cameraYSlider.val() => camera.posY;
    }
} spork ~ CameraYListener();

windSpeedSlider.val() => float rotationRate;
fun void WindSpeedListener() {
    while (true) {
        windSpeedSlider => now;
        windSpeedSlider.val() => rotationRate;
    }
} spork ~ WindSpeedListener();

invertSlider.val() => float mix;
fun void invertListener() {
    while (true) {
        GG.fx() --> InvertFX invert --> OutputFX output;
        invertSlider => now;
        invertSlider.val() => float mix;
    }
} spork ~ invertListener();



// Movement Stuff============================================
0.1 => float camSpeed;
1.5 => float camMovement;
while (true) {
 
    GG.mouseX() / GG.windowWidth() => float mouseX;
    GG.mouseY() / GG.windowHeight() => float mouseY;
    // normalize mouse coordinates to [-1, 1], scale by camMovement
    camMovement * (mouseX * 2.0 - 1.0) => mouseX;
    -camMovement * (mouseY * 2.0 - 1.0) => mouseY;
    camSpeed * (mouseX - camera.posX()) + camera.posX() => camera.posX;
    camSpeed * (mouseY - camera.posY()) + camera.posY() => camera.posY;
    camera.lookAt(scene.pos());
    
    //update
    for (int i; i < 5; i++) {
        Math.map(i, 0, 4, 1, 2.5) * rotationRate => float RotRate;
        RotRate * GG.dt() => lensflares[i].rotateY;
    }
    
    GG.nextFrame() => now;
    GG.fx() --> BloomFX bloom --> MonochromeFX mono --> OutputFX output --> InvertFX Invert;
    .3 => bloom.strength;
    16 => bloom.levels;
    bloom.threshold(0.2);
    bloom.blend(BloomFX.BLEND_MIX);
    output.toneMap(OutputFX.TONEMAP_LINEAR);
    mono.mix(0.1);
   
   
    

}
// Audio Stuff============================================

int id;

fun void startBeat() {
    <<< "Attempting to add Noise.ck" >>>;
    Machine.add(me.dir() + "Noise.ck:foo") => int id;
    if (id < 0) {
        <<< "Unable to add" >>>;
    } else {
        <<< "Noise.ck added successfully" >>>;
    }
}

// Spork the audio function to run concurrently with visuals
spork ~ startBeat();
