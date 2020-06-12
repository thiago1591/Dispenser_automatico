#include <Stepper.h>
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

#define BLYNK_PRINT Serial

Stepper my_Stepper(200, D8, D7, D6, D5);

bool Right = false;
bool Left = false;

char auth[] = "";
char ssid[] = "";
char pass[] = "";

void setup(){

  Serial.begin(9600);                                
  Blynk.begin(auth, ssid, pass);                     
  my_Stepper.setSpeed(70);                            
  
}

BLYNK_WRITE(V1){                                      
  Right = param.asInt();                             
  }
  
BLYNK_WRITE(V0){                                  
  Left = param.asInt();                          
  }
  
void Stepper1 (int Direction, int Rotation){       
  for (int i = 0; i < Rotation; i++){                
  my_Stepper.step(Direction * 200);               
  Blynk.run();
  }
}

void loop() {   
  
  Blynk.run();
  
  if (Right){                                        
  Stepper1(1, 10);                                    
  Serial.println("Right turn");
  }
  delay(20);                                      
  
  if (Left){                                          
  Stepper1(-1, 10);                                   
  Serial.println("Left turn");
  }
  delay(20);                                      
}
