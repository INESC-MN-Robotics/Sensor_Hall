#ifndef driver_h
#define driver_h

#include "Arduino.h"
#include<Wire.h>

union field;

void read_single (int address);

void send_info(int address);

int setup_mlx (int address);

int* find_address ();

#endif
