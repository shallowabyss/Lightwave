@version 2.4
@warnings
@name "cp_MeshCombine"
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    march 31 2006
    
    updated may 23 2010
    thanks to shannon burnett for adding the background and foreground options
    
    This script will combine multiple objects into
    a single object and preserve layer names.
    
    Known limitations:  Will not copy over pivots or hierarchy
*/


main
  {
    layerdata    = lyrdata ( )   ; // Fill the array with all layers
	emptyLayer   = lyrempty( )   ; // Find empty layer
  fgLyrs =  lyrfg ( ) ;  // Defined here so information isnt lost when switching to target object
	bgLyrs = lyrbg ( ) ; // Defined here so information isnt lost when switching to target object
	curObj       = Mesh    ( 0 ) ; // Create a mesh from the current object so 
							       //      that modeler will recognize object.
    
	curName      = curObj.name   ; // Assign the filename to a variable
    targetObjVal = 1             ; // Intialize variables for the requester
    whatToFill   = 1             ; // Intialize variables for the requester
    keepNames    = 1             ;
    swTarget     = 1             ;
    x            = 1             ; // Intialize the incrementer for the popup loop
    
    
	
	if( !layerdata )
	  {	// if no geometry throw error
        lyrsetfg( 1 )              ; // Set foreground to first layer
        ( "No geometry detected" ) ; // Tell user
        return 0                   ; // Tell it to be done
    }
   else
     {
        mesh = Mesh( ) || error( "No object files detected." ) ;
        while( mesh )                                            
          {
            objTarName    = mesh.name    ; 
            setobject     ( objTarName ) ; 
            nameList[ x ] = mesh.name    ;  
            mesh          = mesh.next( ) ; 
            x++                          ;                          
          }
        
		setobject( curName ) ; // when done go back to original file
     }

//////////////     REQUESTER BEGIN \\\\\\\\\\\\\\\

reqbegin("cp_MeshCombine");

    reqsize(341,255);                                            //--<<<<<--  changed 05/23/10 by shannon burnett, to accomodate c6 ... see below
    c1 = ctlpopup("Target Object",targetObjVal,nameList);
    ctlposition(c1,32,71,180,21);

    c2 = ctlchoice("Paste to",whatToFill,@"Any Empty","Last Layer"@);
    ctlposition(c2,33,99,179,20);

    c3 = ctlcheckbox("Preserve Layer Names",keepNames);
    ctlposition(c3,37,164,175,22);                                //--<<<<<--  changed 05/23/10 by shannon burnett, to accomodate c6 ... see below

    c4 = ctlcheckbox("Switch to Target When Done",swTarget);
    ctlposition(c4,37,189,175,20);                                //--<<<<<--  changed 05/23/10 by shannon burnett, to accomodate c6 ... see below

    c5 = ctltext("","         Mesh Combine","       by Chris Peterson","chrisepeterson@gmail.com");
    ctlposition(c5,61,12,118,39);
    
	//--vvvvv--  added 05/23/10 by shannon burnett
	lvs_title                  = "which layers to copy?"                                                  ;
	lvi_default_button         = 1                                                                        ;                                                 
	lvas_options_for_copy_what = @ "all" , "foreground" , "background" @                                  ;
	c6                         = ctlchoice( lvs_title , lvi_default_button , lvas_options_for_copy_what ) ;
    ctlposition                (c6,33,130,300,20)                                                         ;
	//--^^^^^--   
	
	
	
    return if !reqpost();
    
	
	
    targetObjVal  = getvalue( c1 ) ;
    whatToFill    = getvalue( c2 ) ;
    keepNames     = getvalue( c3 ) ;
    swTarget      = getvalue( c4 ) ;
	//--vvvvv--  added 05/23/10 by shannon burnett
    lvi_copy_what_result = getvalue( c6 )                                     ;
	lvs_copy_what        = lvas_options_for_copy_what[ lvi_copy_what_result ] ;
	//info( lvs_copy_what )                                                   ;
	//--^^^^^--   

reqend();

//////////////     REQUESTER END \\\\\\\\\\\\\\\



  targetObj = nameList[ targetObjVal ] ;      // Set target object to the name in the array

  if( curName == targetObj )
    {
      error( "Cant send object to itself" ) ;
      return 0;
    }

  else
    {
	  //--vvvvv--  added 05/23/10 by shannon burnett 
	  if      ( lvs_copy_what == "all" )
	    { // do nothing, this is default case ... see  layerdata = lyrdata( )   ;
		  // layerdata = layerdata ;
		}
      else if ( lvs_copy_what == "foreground" )
	    { // overwrite the default case, lyrdata(), with the subset lyrfg( ) ...
		  layerdata    = fgLyrs; //lyrfg ( ) ;
		} 
      else if ( lvs_copy_what == "background" )
	    { // overwrite the default case, lyrdata(), with the subset lyrbg( ) ...
		  layerdata    = bgLyrs; //lyrbg ( ) ;
		} 
	  //--^^^^^--  
      
	  
	  // do the copying here
      setobject( targetObj ) ;	
      secondObj  = Mesh(0)    ;			
                                         // Create a mesh from the current object so
        								// that modeler will recognize the object
      targetName = secondObj.name;     // Assign the filename to a variable
      
	   
	   
	   
      targetLyrData = lyrdata ( ) ;                // Layer data info of the target object
      lva_fg_layers = lyrfg   ( ) ;
	  
	  if ( targetLyrData == nil)
        { targetLyrData += 0;                // Incase the person sends it to an empty obj
        }
      
      targetTotalVal = sizeof( targetLyrData )         ; // Get size of the layer data array
      targetLyrData.sortA( )                           ; // Make sure that the highest value is last
      targetLstIdx   = targetLyrData[ targetTotalVal ] ; // Get the last value in that array
      nextEmpty      = targetLstIdx + 1                ; // Increment to the next empty at end of file
        
      setobject      ( curName )                       ; // Set to first object 
      layerdata.sortA( )                               ; // Sort the layer data in order

      for( i=1 ; i <= sizeof( layerdata ) ; i++ )
        {	
			
          lyrname  = curObj.layerName( layerdata[i] ) ; // Get the layer name of the selected layer
                
          lyrsetfg ( layerdata[ i ] )                   ; // Set layer to first layer with data
          selmode  ( GLOBAL )                         ; // Select everything in that layer
          copy     ( )       	                        ; // Copy contents to clipboard			
          setobject( targetName )                     ; // Set the object to a different object 

          if ( whatToFill == 1 )                  // If they selected ANY EMPTY
            { empL    = lyrempty() ;                  // Create empty layer
              lyrsetfg( empL[1] )  ;                  // Set it to foreground
            }
          else
            { lyrsetfg( nextEmpty );                // Find the next empty layer (at end of object)
            }
          paste( ) ;					// Paste geometry in layer
                        
                       
          if( keepNames )
		    {                       // If they opt'ed to keep names
              if( lyrname )
                { // If it has a layer name
                  setlayername(lyrname);	// Set it to the layer name
                }
              else
                { setlayername("unnamed");	// If not just call it unnamed
                }
            }

          setobject(curName);		// Set to first object 
          nextEmpty += 1;
        } 
                
      info("Layers copied to: ", targetName);
      if( swTarget )
	    {   
          setobject( targetName ) ;		// Set to target 
          lyrsetfg ( 1 )          ;
        }
      else
	    {
          setobject( curName ) ;		// Set to source
          lyrsetfg ( 1 )       ;
        }
    }

  }
