@warnings
@version 2.8
@name cp_CloneRename
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 13 2006
    
    This script will clone the given object, 
    rename it, and give it an offset.
*/


generic
{
    varClonName = "Clone";
    xoff = 0;
    yoff = 0;
    zoff = 0;
    numClones = 1;
    prom = true;
    fromOrig = true;
    chOrig = 1;
    origLocation = <0,0,0>;

    // Make sure its only one item to be cloned
    // Also retrieve current time
    scn = Scene();
    iname = scn.firstSelect();
    time = scn.currenttime;
    origLocation = iname.getWorldPosition(time);

    // Requester
    reqbegin("cp_CloneRename");
    reqsize(208,276);

    c1 = ctlstring("Name",varClonName);
    ctlposition(c1,18,77);

    c2 = ctldistance("Offset X",xoff);
    ctlposition(c2,18,103);

    c3 = ctldistance("Offset Y",yoff);
    ctlposition(c3,18,129);

    c4 = ctldistance("Offset Z",zoff);
    ctlposition(c4,18,155);

    c5 = ctlinteger("Clones",numClones);
    ctlposition(c5,18,53);

    c6 = ctlcheckbox("Prompt for names?",prom);
    ctlposition(c6,40,184,129,21);

    c7 = ctltext("","        CloneRename","     by Chris Peterson","chris@shallowabyss.com");
    ctlposition(c7,41,0,118,39);

    c8 = ctlchoice("Offset",chOrig,@"From Orig","From Clone"@);
    ctlposition(c8,10,216);

    return if !reqpost();

    varClonName = getvalue(c1);
    xoff = getvalue(c2);
    yoff = getvalue(c3);
    zoff = getvalue(c4);
    numClones = getvalue(c5);
    prom = getvalue(c6);
    chOrig = getvalue(c8);

    reqend();
    
    // Check to see whether they want it to be from Original null or not
    if(chOrig == 1){
      fromOrig = true;
    }
    if(chOrig == 2){
      fromOrig = false;
    }
    if(fromOrig){
      // if they want all clones to be offset from original clone
      origLocation = iname.getWorldPosition(time);
    }
    if(prom){
                  if(numClones > 1){
                          for(i=1; i <= numClones; i++){
                          // Create multiple clones with new name
                                   Clone(1);
                                   varClonName = "Clone";
                          // Dialog Box
                                   reqbegin("Name");
                                   reqsize(185,85);

                                   c1 = ctlstring("Name",varClonName);
                                   ctlposition(c1,18,15);

                                   return if !reqpost();

                                   varClonName = getvalue(c1);

                                   reqend();
                                   Rename(varClonName);
                             // check to see if the position is from the original or not
                                   if(fromOrig){
                                               if(i == 1){
                                                    // If its the first clone then
                                                  AddPosition(xoff,yoff,zoff);
                                               }
                                               if(i > 1){
                                                 // All other items get same value as first clone
                                                    xnew = origLocation.x + xoff;
                                                    ynew = origLocation.y + yoff;
                                                    znew = origLocation.z + zoff;
                                                    Position(xnew,ynew,znew);
                                               }
                                   } // from orig true
                                   else{
                                         AddPosition(xoff,yoff,zoff);
                                   } // from orig false
                         }     // forloop
                  }      // numclones
             else{
                  Clone(1);
                  Rename(varClonName);
                  AddPosition(xoff,yoff,zoff);
             } // if only one clone (else)
   }  // prom
     else{
        for(i=1; i<=numClones; i++){
           Clone(1);
           Rename(varClonName);
           // check to see if the position is from the original or not
           if(fromOrig){             
               if(i == 1){
                  // If its the first clone then
                  AddPosition(xoff,yoff,zoff);
               }
               if(i > 1){
               // All other items get same value as first clone
                  xnew = origLocation.x + xoff;
                  ynew = origLocation.y + yoff;
                  znew = origLocation.z + zoff;
                  Position(xnew,ynew,znew);
               }
          } // from orig true
          else{
              AddPosition(xoff,yoff,zoff);
          } // from orig false
        }  // else prom
     } // big else
} // main



