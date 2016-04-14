// Programa Sensor magnético

#include <Wire.h>

  byte val = 0, stat=0, ack;
  int c2=0;
  int i=0;  
  int b1=0, b2=0;

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

  Serial.println(ack);
  Serial.println("\n");

  //while(digitalRead(4)==LOW);
    
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

  //Wire.beginTransmission(0xc);
  //Wire.write(0x60); //Instruction - write
  //Wire.write(0x04); //Register
  //Wire.write(0x00); //1º byte
  //Wire.write(0xF0); //2º byte
  //ack=Wire.endTransmission();
  //Wire.requestFrom(0xc, 1);
  //stat=Wire.read();
  //Serial.println(ack);
  //Serial.println(stat);
  Serial.println("ENDED ROUTINE");
  Serial.println("\n");

delay(2000);  

}
