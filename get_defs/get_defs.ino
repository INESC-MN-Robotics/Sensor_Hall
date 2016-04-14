// Programa Sensor magnético

#include <Wire.h>

  byte val = 0, stat=0, ack;
  int c2=0;
  int i=0;  
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
  Wire.beginTransmission(0xc); // transmit to device #44 (0x2c)
  // device address is specified in datasheet
        
  Wire.write(byte(0x50));            //[0101 0000] sends instruction byte (consultar memória)
  Wire.write(byte(0x04));            //[0000 0100] morada 0x02
  ack=Wire.endTransmission();

  Serial.print("A ler morada ");
  Serial.println(byte3,HEX);
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

  delay(2000);

  if(Serial.available()){
    str1=Serial.readString();
    str1.toCharArray(char1, 5);
    byte1=strtoul(char1,NULL,16);
    st=1;
    Serial.println("Introduzir byte 2");
    while(!Serial.available()&&st==1);
    str2=Serial.readString();
    str2.toCharArray(char2, 5);
    byte2=strtoul(char2,NULL,16);
    st=2;
    Serial.println("Introduzir MORADA");
    Serial.println("Da forma: (<MORADA (6bits)> 0 0)");
    while(!Serial.available()&&st==2);
    str3=Serial.readString();
    str3.toCharArray(char3, 5);
    byte3=strtoul(char3,NULL,16);
    if(char3[0]=='p' || char2[0]=='p'){
      Wire.beginTransmission(0xc);
      Wire.write(0x60); //Instruction - write
      Wire.write(byte1); 
      Wire.write(byte2); 
      Wire.write(byte3); 
      ack=Wire.endTransmission();
      Wire.requestFrom(0xc, 1);
      stat=Wire.read();
      Serial.println(ack);
      Serial.println(stat);
      Serial.println("Dados enviados \n");
    }
    else
      Serial.println("Não foi enviada instrução \n");
  }
  else
    Serial.println("Pronto para receber instrução");
delay(2000);  

}
