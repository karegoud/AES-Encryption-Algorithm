#include "io.h"
#include "system.h"
#include "stdio.h"
#include "time.h"
int main() { unsigned int i,j; unsigned int status =0 ;
unsigned int nine_numbers[8] = {1417113376, 1332634912,1315532389, 542406511, 1416126836, 1931505017, 541816174, 1730168437} ;
unsigned int Golden_output[4]= {700665951, 1460936950, 1076009395, 436393786};
unsigned int processed_nine_numbers[4];
unsigned int error_flag=0;

  printf("Data to IP from CPU:\n") ;
  for(i=0;i<8;i++){ IOWR(REG32_AVALON_INTERFACE_0_BASE,0,nine_numbers[i]);
   // usleep(1000000);
    printf("%u   ",nine_numbers[i]);
  }

  printf("\nGolden Output for the given data:\n") ;
  for(i=0;i<4;i++){
  //  usleep(100000);
    printf("%u   ",Golden_output[i]);
  }


 // usleep(10000000);
  printf("\nComputation Result from the IP:\n") ;
  // usleep(100000);
  while ( status==0 ) { status = (unsigned int)  IORD(REG32_AVALON_INTERFACE_0_BASE,0);}
  //printf("\n%d",status);
  for(i=0;i<4;i++){ // dummy "write" request to "separate" successive "read" requests
    // a hack by SBP, due to unavailability of "address" avalon-MM-slave signal
    IOWR(REG32_AVALON_INTERFACE_0_BASE,0,nine_numbers[i]);
    usleep(100000); // 0.1 sec
    processed_nine_numbers[i] = (unsigned int)  IORD(REG32_AVALON_INTERFACE_0_BASE,0);
    printf("%u   ",processed_nine_numbers[i]);
    usleep(1000000); // 0.1 sec
  }
  printf("\nVerification of computed results:\n") ;
 //Verification
  error_flag=0;
   for(i=0;i<4;i++){
	if(error_flag==0){
		if(processed_nine_numbers[i]!=Golden_output[i]){
		error_flag=1;
		j=i;
	    }
	}
   }
  if(error_flag==1){
	  printf("\nTestcase failed for Golden_output[%d],",j);
  }
  else{
	  printf("All testcases passed");
  }

  while (1) ; return 0;
}
