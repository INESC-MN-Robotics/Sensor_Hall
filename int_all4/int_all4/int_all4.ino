// Programa Sensor magnético
#include <Wire.h>
#include "driver.h"

  byte val = 0, stat=0, ack;
  int c2=0;
  short int temp_swt, swt=1;
  int i=0;  
  unsigned int atime=0, ptime=0, rtime;
  int b1=0, b2=0;
  char char1[5], char2[5], char3[5];
  String str1, str2, str3;
  byte byte1=0, byte2=0, byte3=0;
  unsigned int st;
  //int address = 0xc;
  int *address;
  short int naddress;

void setup() {
  pinMode(4,INPUT);
  Wire.begin(); // join i2c bus (address optional for master)
  Serial.begin(9600);
  address=(int*)malloc(4);
  naddress=4;
  address[0]=0xc;
  address[1]=0xd;
  address[2]=0xe;
  address[3]=0xf;
}

void loop() {

  if(Serial.available()&&swt==1){
    temp_swt=Serial.readString().toInt();
    if(temp_swt==0){
      swt=temp_swt;
      Serial.println("MODO DE FUNCIONAMENTO: CONFIGURACAO");
      delay(1500);
    }
    else if(temp_swt==2){
      swt=temp_swt;
      Serial.println("MODO DE FUNCIONAMENTO: ADDRESS SEARCH");
      delay(1500);
    }
    else{
      Serial.println(temp_swt);
      Serial.println("Introduzir 0 para modo de configuracao");
      delay(1500);
    }
  }


  switch (swt){

    case 0:
     //for(i=0;i<naddress;i++)
       swt=setup_mlx(address[0]);
    break;
      
    case 1:
    for(i=0;i<naddress;i++){
      read_single(address[i]);
      delay(30);
      send_info(address[i]);
    }
    break;

    case 2:
      address=find_address();
      naddress=0;
      for(i=0;i<20;i++)
        naddress++;
      swt=1;
  }
}
