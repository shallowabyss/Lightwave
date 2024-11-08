@warnings
@version 2.7
@name "cp_UFlip"
// UFlip by chris peterson
// chris@shallowabyss.com

main{

   pntcnt = pointcount();
   if(!pntcnt)
    {
        error("You must have geometry to perform this operation");
        return;
    }
    x = 1;
    vmap = VMap(VMTEXTURE) || error("No texture maps in mesh!");
    while(vmap && vmap.type == VMTEXTURE)
    {
         //vmapnames += vmap.name;
         mapStore[x] = vmap.name;
         vmap = vmap.next();
         x++;
    }

   // Recall variables if ran before
   vmapname = recall("vmapname",1);
   partname = recall("partname","left_half");

   // Requester
    reqbegin("UFlip");
    reqsize(250,166);

    c1 = ctlpopup("Texture Map",vmapname,mapStore);
    ctlposition(c1,27,90);

    c2 = ctlstring("Part Name",partname);
    ctlposition(c2,39,66,162,17);

    c3 = ctltext("","               UFlip","      by Chris Peterson","chris@shallowabyss.com");
    ctlposition(c3,65,6,118,39);

    return if !reqpost();

    // Retrieve values from requester
    vmapname = getvalue(c1);
    partname = getvalue(c2);
    reqend();

  // Store values for future use
  store("vmapname",vmapname);
  store("partname",partname);

// Begin the selections
selmode(USER);
selpolygon(CLEAR);
selpolygon(SET, PART, partname);
// Unweld selected geometry to avoid messy UV's
unweld();


// Select the Vmap and error out if none selected
vmap = VMap(VMTEXTURE, mapStore[vmapname]) || error("No UV map selected");

    selmode(USER);
    editbegin();
    pntCnt = pointcount();
    // This will reverse the direction of the UV
   	for(i=1; i <= pntCnt; i++){
   		if(vmap.isMapped(points[i])){
			pointValue = vmap.getValue(points[i]);
                        pointValue[1] = (pointValue[1] * -1)+ 1;
   			if(vmap.isMapped(points[i])){
		       	vmap.setValue(points[i], pointValue);
		       	}
                 }
          }
    editend();
    selpolygon(CLEAR);
    // Merge the points
    mergepoints();

}

