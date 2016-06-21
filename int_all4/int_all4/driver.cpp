
#include "Arduino.h"
#include "Wire.h"
#include"driver.h"

union field{
  int valor;
  byte a[2];
};

void read_single (int address){
    int c2=0;
    
    Wire.beginTransmission(address); // transmit to device #44 (0x2c)
    // device address is specified in datasheet
          
    Wire.write(byte(0x3e));            //[0011 1110] sends instruction byte (single read, XYZ sem temperatura)
    
    Wire.endTransmission();
  
    //ptime=millis();
    //while(digitalRead(4)==LOW);
    //atime=millis();
    //rtime=atime-ptime;
      
    Wire.requestFrom(address, 1);    // request 1 byte from slave device #address (status)
    //Serial.print("\n");
    
    c2=0;
    
    while(Wire.available())    // slave may send less than requested
    {    
      c2 = Wire.read();    // lê todos os bytes e guarda num vector
    }
    return;
}

void send_info(int address){
    field x, y, z;
    int c2=0;
    byte stat;
    
    Wire.beginTransmission(address); 
  
    Wire.write(byte(0x4e)); //0100 1110 - Ler uma vez campo (zyx)
  
    Wire.endTransmission();
  
    Wire.requestFrom(address, 7);    // request 7 bytes from slave device #address (status)
    //Serial.print("\n");
    
    c2=0;  
    
    while(Wire.available())    // slave may send less than requested
    {    
      stat=Wire.read();
      z.a[1] = Wire.read();
      z.a[0] = Wire.read();
      y.a[1] = Wire.read();
      y.a[0] = Wire.read();
      x.a[1] = Wire.read();
      x.a[0] = Wire.read();
      // lê todos os bytes e guarda num vector
    }  
  
    /*Serial.print("Status BYTE -> ");
    Serial.print(stat);
    Serial.println();*/
    Serial.println(address,HEX);
    Serial.println(stat, HEX);
    Serial.println(x.valor);
    Serial.println(y.valor);
    Serial.println(z.valor);
    return;
}

int setup_mlx(int address){
    char char1[5], char2[5], char3[5];
    byte byte1=0, byte2=0, byte3=0;
    byte ack, stat=0;
    String str1, str2, str3;
    int st;
    short int swt;
    int b1=0, b2=0;

      Wire.beginTransmission(address); // transmit to device #44 (0x2c)
      // device address is specified in datasheet
            
      Wire.write(byte(0x50));            //[0101 0000] sends instruction byte (consultar memória)
      Wire.write(byte3);                 //[0000 0100] morada 0x00
      ack=Wire.endTransmission();
    
      Serial.print("A ler morada 0x");
      Serial.println(byte3>>2 ,HEX);
      Serial.println();
      
      Serial.println(ack);
      Wire.requestFrom(address, 3);    // request 2 bytes from slave device #0xe (status)
      
      stat=Wire.read();
      b1=Wire.read();
      b2=Wire.read();
    
      Serial.println(stat,BIN);
      Serial.print(b1,BIN);
      Serial.print("  ");
      Serial.print(b2,BIN);
      Serial.println("\n");
             
      if(Serial.available()){
        str1=Serial.readString();
        str1.toCharArray(char1, 5);
        byte1=strtoul(char1,NULL,16);
        st=1;
        if (char1[0]=='s'){
          swt=1;
          Serial.println("A SAIR DO MODO DE CONFIGURACAO");
          delay(1500);
          return swt; 
        }
        else if (char1[0]=='g'){
          Serial.println("BURNING EEPROM");
          Serial.println("(REGISTER WON'T BE RESTORED AFTER HARD RESET!!!)");
          delay(5000);
          Serial.println("SENDING");
          delay(1000);
          Wire.beginTransmission(address);
          Wire.write(0xe0); //Instruction - write
          ack=Wire.endTransmission();
          Wire.requestFrom(address, 1);
          stat=Wire.read();
          Serial.println(ack);
          Serial.println(stat);
          Serial.println("\n");
          Serial.println("Stored! \n");
          delay(1500);
          return swt;
        }
        else if (char1[0]=='r'){
          Serial.println("Restoring...");
          delay(1000);
          Wire.beginTransmission(address);
          Wire.write(0xd0);
          ack=Wire.endTransmission();
          Wire.requestFrom(address,1);
          stat=Wire.read();
          Serial.println(ack);
          Serial.println(stat);
          Serial.println("\n");
          Serial.println("Restored! \n");
          delay(1500);
          return swt;
        }
        else if (char1[0]=='p'){
          Serial.println("Introduzir MORADA em hexadecimal");
          while(!Serial.available()&&st==1);
          str3=Serial.readString();
          str3.toCharArray(char3, 5);
          byte3=strtoul(char3,NULL,16);
          byte3=byte3 << 2;
          Serial.println("Nao foi enviada instrucao \n");
          delay(1500);
          return swt;
        }
        Serial.println("Introduzir byte 2");
        while(!Serial.available()&&st==1);
        str2=Serial.readString();
        str2.toCharArray(char2, 5);
        byte2=strtoul(char2,NULL,16);
        st=2;
        Serial.println("Introduzir MORADA em hexadecimal");
        while(!Serial.available()&&st==2);
        str3=Serial.readString();
        str3.toCharArray(char3, 5);
        byte3=strtoul(char3,NULL,16);
        byte3=byte3 << 2;
        if(char2[0]!='p'){
          Wire.beginTransmission(address);
          Wire.write(0x60); //Instruction - write
          Wire.write(byte1); 
          Wire.write(byte2); 
          Wire.write(byte3); 
          ack=Wire.endTransmission();
          Wire.requestFrom(address, 1);
          stat=Wire.read();
          Serial.println(ack);
          Serial.println(stat);
          Serial.println("Dados enviados \n");
        }
        else
          Serial.println("Nao foi enviada instrucao \n");
      }
      else
        Serial.println("Pronto para receber instrucao");
        Serial.println("(s para sair deste modo)");
        Serial.println("(p para somente ler morada)");
      delay(2000);
      return (swt);
}

int* find_address (){
  short int n = 0;
  int i;
  byte byte3 = 0, ack, stat=0, b1, b2;
  int *address;
  address=(int*)malloc(20);
  
  Serial.println("Locating address...");
  for(i=0x0;i<=0x3F;i=i+0x1){
    Wire.beginTransmission(i); // transmit to device #44 (0x2c)
    // device address is specified in datasheet
    
    delay(100);              
    Serial.print("I2C Addr ");
    Serial.println(i,HEX);
    Wire.write(byte(0x50));            //[0101 0000] sends instruction byte (consultar memória)
    Wire.write(byte3);                 //[0000 0100] morada 0x02
    ack=Wire.endTransmission();
  
    Serial.print("A ler morada 0x");
    Serial.println(byte3>>2 ,HEX);
    Serial.println();
    
    Serial.println(ack);
    Wire.requestFrom(i, 3);    // request 2 bytes from slave device #0xe (status)
    
    stat=Wire.read();
    b1=Wire.read();
    b2=Wire.read();
  
    Serial.println(stat,BIN);
    Serial.print(b1,BIN);
    Serial.print("  ");
    Serial.print(b2,BIN);
    Serial.println("\n");
    
    if(ack==0){
      Serial.print("Address Found: 0x");
      Serial.println(i,HEX);
      Serial.println("Changing now and leaving to measure mode...");
      address[n]=i;
      n++;
      delay(1500);
    }
  }
  if(n==0){
    Serial.println("Address not found! Aborting...");
  return address;
  }
  else{
    Serial.print(n);
    Serial.println(" addresses found!");
    delay(1500);
    return address;
  }
}
