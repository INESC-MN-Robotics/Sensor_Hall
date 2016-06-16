// Programa Sensor magnético

#include <Wire.h>

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

  union field{
    int valor;
    byte a[2];
  };

  field x, y, z;

void setup() {
  pinMode(4,INPUT);
  Wire.begin(); // join i2c bus (address optional for master)
  Serial.begin(9600);
}

void loop() {
  delay(2000);
  for(i=0x0;i<=0x3F;i=i+0x1){
      Wire.beginTransmission(i); // transmit to device #44 (0x2c)
      // device address is specified in datasheet
      
      delay(1000);
      
      Serial.print("I2C Addr ");
      Serial.println(i,HEX);
      Wire.write(byte(0x50));            //[0101 0000] sends instruction byte (consultar memória)
      Wire.write(byte3);                 //[0000 0100] morada 0x02
      ack=Wire.endTransmission();
    
      Serial.print("A ler morada 0x");
      Serial.println(byte3>>2 ,HEX);
      Serial.println();
      
      Serial.println(ack);
      Wire.requestFrom(0xc, 3);    // request 2 bytes from slave device #0xe (status)
      
      stat=Wire.read();
      b1=Wire.read();
      b2=Wire.read();
    
      Serial.println(stat,BIN);
      Serial.print(b1,BIN);
      Serial.print("  ");
      Serial.print(b2,BIN);
      Serial.println("\n");
  }
    
}
