// Programa Sensor magnético

#include <Wire.h>

  byte val = 0, stat=0;
  int c2=0;
  int i=0;  
  unsigned int atime=0, ptime=0, rtime;

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
        
  Wire.write(byte(0x3e));            //[0011 1110] sends instruction byte (single read, XYZ sem temperatura)
  
  Wire.endTransmission();

  //ptime=millis();
  //while(digitalRead(4)==LOW);
  //atime=millis();
  //rtime=atime-ptime;
  delay(50);
    
  Wire.requestFrom(0xc, 1);    // request 1 byte from slave device #0xc (status)
  //Serial.print("\n");
  
  c2=0;
  
  while(Wire.available())    // slave may send less than requested
  {    
    c2 = Wire.read();    // lê todos os bytes e guarda num vector
  }

  Wire.beginTransmission(0xc); 

  Wire.write(byte(0x4e)); //0100 1110 - Ler uma vez campo (zyx)

  Wire.endTransmission();

  Wire.requestFrom(0xc, 7);    // request 1 byte from slave device #0xc (status)
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
  Serial.println("BEGIN");
  Serial.println(stat);
  Serial.println(x.valor);
  Serial.println(y.valor);
  Serial.println(z.valor);
  delay(50);  
  }
