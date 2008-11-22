// "StartupMacros"
// These macros are automatically installed in the Plugins>Macros submenu 
// when ImageJ starts as long as the name of this file is StartupMacros.txt
// and it is located in a folder named macros inside the ImageJ folder.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush, 
//  eraser and flood fill (paint bucket) tools in NIH Image. The 
//  pencil and paintbrush draw in the current foreground color 
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw 
//  using the background color or to have the flood fill tool fill 
//  using the background color. Set the foreground and background 
//  colors by double-clicking on the flood fill tool or on the eye  
//  dropper tool.  Double-click on the pencil, paintbrush or eraser 
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.

   // Global variables
   var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
   var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
   var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

   //macro "AutoxRunAndHide" {}
   //macro "AutoxRun" {run("Control Panel...");}
   //macro "AutoxRun" {run("Brightness/Contrast...");}

    macro "About Startup Macros..." {
       path = getDirectory("macros")+"/About Startup Macros";
       if (!File.exists(path))
           exit("\"About Startup Macros\" not found in ImageJ/macros/.");
       open(path);
   }

   macro "Open StartupMacros..." {
       path = getDirectory("macros")+"/StartupMacros.txt";
       if (!File.exists(path))
           exit("\"StartupMacros.txt\" not found in ImageJ/macros/.");
       open(path);
   }

   macro "-" {} //menu divider

   macro "Unused Tool-1 - " {}  // leave slot between text tool and magnifying glass unused
   macro "Unused Tool-2 - " {}  // leave slot between dropper and pencil unused

 
   macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
        getCursorLoc(x, y, z, flags);
        if (flags&alt!=0)
              setColorToBackgound();
        draw(pencilWidth);
   }

   macro "Paintbrush Tool - C037F6036F3699CfffD71F4771D5eD7eD9e" {
        getCursorLoc(x, y, z, flags);
        if (flags&alt!=0)
              setColorToBackgound();
        draw(brushWidth);
   }

    macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
        requires("1.34j");
        setupUndo();
        getCursorLoc(x, y, z, flags);
        if (flags&alt!=0) setColorToBackgound();
        floodFill(x, y, floodType);
     }

   function draw(width) {
        requires("1.32g");
        setupUndo();
        getCursorLoc(x, y, z, flags);
        setLineWidth(width);
        moveTo(x,y);
        x2=-1; y2=-1;
        while (true) {
            getCursorLoc(x, y, z, flags);
            if (flags&leftClick==0) exit();
            if (x!=x2 || y!=y2)
                lineTo(x,y);
            x2=x; y2 =y;
            wait(10);
        }
   }

   function setColorToBackgound() {
       savep = getPixel(0, 0);
       makeRectangle(0, 0, 1, 1);
       run("Clear");
       background = getPixel(0, 0);
       run("Select None");
       setPixel(0, 0, savep);
       setColor(background);
   }

  // Runs when the user double-clicks on the pencil tool icon
  macro 'Pencil Tool Options...' {
       pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
  }

  // Runs when the user double-clicks on the paint brush tool icon
  macro 'Paintbrush Tool Options...' {
      brushWidth = getNumber("Brush Width (pixels):", brushWidth);
    call("ij.Prefs.set", "startup.brush", brushWidth);
  }

  // Runs when the user double-clicks on the flood fill tool icon
  macro 'Flood Fill Tool Options...' {
      Dialog.create("Flood Fill Tool");
      Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
      Dialog.show();
      floodType = Dialog.getChoice();
      call("ij.Prefs.set", "startup.flood", floodType);
  }
