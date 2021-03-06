// CC-BY - Design by dusjagr, 2017
// DIMI-8 Chistli
// As part of the 

Show_Circuit = "YES"; //[YES,NO]
Logo = "NO"; //[YES,NO]
ExtraSides = "NO";

pcbWidth = 138; //138
pcbHeight = 96;
backDepth = 68; 
BeamWidth = 8; //[4:14]
boxHeight = 50;
overlap = 4;

coverRatio = 0.2;
backRatio = 0.2;
shelfRatio = 0.15;
RoundEdge = 8;

/*[Material]*/

pcbThickness = 1.6;	//[3:8]
woodThickness =5; //[1:6]
blendThickness = 4; //[1:6]
lidThickness = 3; //[1:6]
screwDiam = 3;
screwLength = 14;
nutDiam = 5.5;
nutThickness = 2.5;

/*[Hidden]*/
$fs=0.1;
//ScrewPort = (2*BeamWidth+ScrewDiam)/BeamWidth;
boxLength = pcbHeight+backDepth-overlap+2*woodThickness;

//Output_Type = "STL";
Output_Type = "DXF"; //[DXF,STL,single]
//Output_Type = "single";

// Assembly the Model

if (Output_Type == "single"){
   
   translate ([0,0,0]) topBeam();
   //import("interace.dxf", convexity=3);
}


if (Output_Type == "DXF"){
    projection(cut=true) translate ([0,0,0]) PCB();
    projection(cut=true) translate ([150,0,0]) backLid();
    projection(cut=true) translate ([300,0,0]) coverFront();
    projection(cut=true) translate ([300,50,0]) coverBack();
    projection(cut=true) translate ([300,100,0]) frameMiddle();
    projection(cut=true) translate ([300,150,0]) frameBack();
    projection(cut=true) translate ([300,200,0]) frameFront();
    projection(cut=true) translate ([300,250,0]) frameShelf();
    projection(cut=true) translate ([0,100,0]) frameSide();
    projection(cut=true) translate ([0,160,0]) frameSide();
    projection(cut=true) translate ([0,220,0]) rotate ([0,0,-90])topBeam();
    projection(cut=true) translate ([0,232,0]) rotate ([0,0,-90])topBeam();
    projection(cut=true) translate ([0,244,0]) rotate ([0,0,-90])innerBeam();
    projection(cut=true) translate ([0,256,0]) rotate ([0,0,-90])innerBeam();
}
   

if (Output_Type == "STL"){

translate ([-pcbWidth/2,0,boxHeight-blendThickness-pcbThickness]) PCB();
translate ([-pcbWidth/2+BeamWidth,pcbHeight-overlap,boxHeight-blendThickness]) backLid();
    
// Frame    
translate ([pcbWidth/2-BeamWidth,0,boxHeight-(3*woodThickness+pcbThickness)]) innerBeam();   
translate ([-pcbWidth/2,0,boxHeight-(3*woodThickness+pcbThickness)]) innerBeam();  
    
translate ([-pcbWidth/2,woodThickness,0]) rotate ([90,0,0]) frameFront();
translate ([-pcbWidth/2,pcbHeight,0]) rotate ([90,0,0]) frameMiddle();
translate ([-pcbWidth/2,pcbHeight+backDepth-overlap,0]) rotate ([90,0,0]) frameBack();
translate ([-pcbWidth/2-woodThickness,-woodThickness,0]) rotate ([90,0,90]) frameSide();
translate ([pcbWidth/2,-woodThickness,0]) rotate ([90,0,90]) frameSide();
translate ([-pcbWidth/2,pcbHeight,boxHeight*shelfRatio+woodThickness]) rotate ([0,0,0]) frameShelf();

// Cover
translate ([pcbWidth/2-BeamWidth,0,boxHeight-blendThickness]) topBeam();   
translate ([-pcbWidth/2,0,boxHeight-blendThickness]) topBeam();  
translate ([-pcbWidth/2,0,boxHeight*coverRatio]) rotate ([90,0,0]) coverFront();

translate ([-pcbWidth/2,pcbHeight+backDepth-overlap+blendThickness,boxHeight*backRatio]) rotate ([90,0,0]) coverBack();

}

// MODULES ///////////////////////////////
module PCB()
{color("DarkKhaki") 
  difference(){
    cube([pcbWidth,pcbHeight,pcbThickness],false);
   /* #translate([BeamWidth/2,pcbHeight*0.1,-1]) cylinder(woodThickness+2,    d=2, true);
    #translate([BeamWidth/2,pcbHeight*0.9,-1]) cylinder(woodThickness+2,    d=2, true);
    #translate([pcbWidth-BeamWidth/2,pcbHeight*0.1,-1]) cylinder(woodThickness+2,    d=2, true);
    #translate([pcbWidth-BeamWidth/2,pcbHeight*0.9,-1]) cylinder(woodThickness+2,    d=2, true);
      */
  } 
 if (Show_Circuit == "YES"){
 color("Gold") 
    translate ([0,0,pcbThickness])import("interace_anyma.dxf", convexity=3);
 color("DimGray") 
     //translate ([0,0,pcbThickness])import("garlampli.dxf", convexity=3);
 color("DimGray") 
     
    //translate ([3,0,-0.001])import("interace.dxf", convexity=3);
     translate ([0,0,-0.001])import("garlampli.dxf", convexity=3);
     }
}

module backLid()
{color("DarkGreen")
    
    cube([pcbWidth-2*BeamWidth,backDepth,lidThickness],false);
   
}

module screwPort()
{color("Goldenrod") 
    translate ([-woodThickness,0,0]) cube([screwLength,screwDiam,woodThickness],false);
    translate ([woodThickness/1.5,screwDiam/2-nutDiam/2,0]) cube([nutThickness,nutDiam,woodThickness],false);
}

module topBeam()
{color("Goldenrod") 
  difference(){ 
    cube([BeamWidth,pcbHeight+backDepth-overlap,blendThickness],false);
    #translate([BeamWidth/2,pcbHeight*0.1,-1]) cylinder(woodThickness+2,    d=2, true);
    #translate([BeamWidth/2,pcbHeight*0.88,-1]) cylinder(woodThickness+2,    d=2, true);
    #translate([BeamWidth/2,pcbHeight*1.57,-1]) cylinder(woodThickness+2,    d=2, true);
  }
}

module innerBeam()
{color("SaddleBrown")
   difference(){ 
    cube([BeamWidth,pcbHeight+backDepth-overlap,woodThickness],false);
       
   }
}

module frameSide()
{color("DarkSlateGray") 
    difference(){
    cube([boxLength,boxHeight,woodThickness],false);
    #translate([woodThickness*1.5,boxHeight/2,-1]) cylinder(  woodThickness+2,    d=screwDiam, true);
    #translate([boxLength-woodThickness*1.5,boxHeight/2,-1]) cylinder(  woodThickness+2,    d=screwDiam, true);
    #translate([pcbHeight+woodThickness*0.5,boxHeight/2,-1]) cylinder(  woodThickness+2,    d=screwDiam, true);
    }
}

module coverFront()
{color("Goldenrod") 
 
    cube([pcbWidth,boxHeight-boxHeight*coverRatio,blendThickness],false);
       
}

module coverBack()
{color("Tan") 
  difference(){
    cube([pcbWidth,boxHeight-boxHeight*backRatio,blendThickness],false);
    #translate([pcbWidth/2+22,(boxHeight*(1-backRatio)*0.4),-1]) cylinder(  woodThickness+2,    d=7, true);
      #translate([pcbWidth/2+10,(boxHeight*(1-backRatio)*0.4),-1]) cylinder(  woodThickness+2,    d=7, true);
    #translate([pcbWidth/2-22,(boxHeight*(1-backRatio)*0.4),-1]) cylinder(  woodThickness+2,    d=10, true);
       
  }
}

module frameFront()
{color("SaddleBrown") 
  difference(){
    cube([pcbWidth,boxHeight-blendThickness-pcbThickness,woodThickness],false);
    translate([0,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
    translate([pcbWidth-BeamWidth,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
    translate([0,boxHeight/2-screwDiam/2,0]) screwPort();
    translate([pcbWidth,boxHeight/2+screwDiam/2,0]) rotate ([0,0,180]) screwPort();
  }
}

module frameMiddle()
{color("SaddleBrown") 
  difference(){
  cube([pcbWidth,boxHeight-blendThickness-pcbThickness,woodThickness],false);
      
    translate([0,0,-1]) cube([pcbWidth*1,boxHeight*0.3-woodThickness-pcbThickness,woodThickness*2],false);
    translate([pcbWidth*0.2,0,-1]) cube([pcbWidth*0.6,boxHeight*0.75-woodThickness-pcbThickness,woodThickness*2],false);
    translate([0,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
    translate([pcbWidth-BeamWidth,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
      #translate([pcbWidth*0.066,boxHeight*shelfRatio+woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
    #translate([pcbWidth-BeamWidth-pcbWidth*0.066,boxHeight*shelfRatio+woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
      
    translate([0,boxHeight/2-screwDiam/2,0]) screwPort();
    translate([pcbWidth,boxHeight/2+screwDiam/2,0]) rotate ([0,0,180]) screwPort();
  }
}

module frameShelf()
{color("SaddleBrown"){
  difference(){
    cube([pcbWidth,backDepth-overlap-woodThickness,woodThickness],false);
    //translate([0,0,-1]) cube([pcbWidth*1,woodThickness,woodThickness*2],false);
  }
  translate([pcbWidth*0.2,-woodThickness,0]) cube([pcbWidth*0.6,woodThickness,woodThickness],false);
  translate([pcbWidth*0.066,-woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
  translate([pcbWidth-BeamWidth-pcbWidth*0.066,-woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
  translate([pcbWidth*0.066,backDepth-overlap-woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
  translate([pcbWidth-BeamWidth-pcbWidth*0.066,backDepth-overlap-woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
  }
}

module frameBack()
{color("SaddleBrown") 
  difference(){
    cube([pcbWidth,boxHeight-blendThickness,woodThickness],false);
    translate([pcbWidth*0.2,boxHeight/3,-1]) cube([pcbWidth*0.6,boxHeight/2-blendThickness,woodThickness*2],false);
    translate([0,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
    translate([pcbWidth-BeamWidth,boxHeight-(3*woodThickness+pcbThickness),-1]) cube([BeamWidth,woodThickness,woodThickness*2],false);
    //translate ([0,boxHeight*shelfRatio+woodThickness+woodThickness,backDepth-overlap]) rotate ([-90,0,0]) frameShelf();
    
    #translate([pcbWidth*0.066,boxHeight*shelfRatio+woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
    #translate([pcbWidth-BeamWidth-pcbWidth*0.066,boxHeight*shelfRatio+woodThickness,0]) cube([BeamWidth,woodThickness,woodThickness],false);
      
    translate([0,boxHeight/2-screwDiam/2,0]) screwPort();
    translate([pcbWidth,boxHeight/2+screwDiam/2,0]) rotate ([0,0,180]) screwPort();
  }
}

// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate([0,0,0])
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
  }
