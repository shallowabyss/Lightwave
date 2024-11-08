@warnings
@version 2.3
@name "cp_DongleCheck"

main {
      dongleNum = licenseId();
      if(dongleNum == 0){
          reqbegin("Error");
          reqsize(227,80);
          c1 = ctltext("","Your dongle is not plugged in.");
          ctlposition(c1,44,14,140,13);
          return if !reqpost();
          reqend();
      }
      else{
            //info("Dongle Detected: ", dongleNum);
      }
}
