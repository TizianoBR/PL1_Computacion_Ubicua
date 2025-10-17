#include <config.h>

//Component pins
#define PEATONES 14
#define COCHES 26
#define BOTON 12
#define ESPERA 27

// states
#define Gr 0
#define Yr 1
#define Rr1 2
#define Rg 3
#define Rr2 4

int cooldownTime=3000;
int stateTime[]={
  2000, //YrTime
  1000, //Rr1Time
  5000, //RgTime
  1000  //Rr2Time
};

unsigned long lastStateStart=0;
bool waiting=false;
int state=0;
unsigned long now=0;

void setup() {
  pinMode(COCHES, OUTPUT);
  pinMode(PEATONES, OUTPUT);
  pinMode(ESPERA, OUTPUT);
  pinMode(BOTON, INPUT);
  
  digitalWrite(PEATONES, LOW);
  digitalWrite(COCHES, LOW);
  digitalWrite(ESPERA, LOW);

  Serial.begin(9600);
  Serial.println("Hola");
}

void loop() {
  now = millis();
  //Check button
  if ((state==Gr || state==Rr2) && digitalRead(BOTON)==LOW){
    waiting=true;
    digitalWrite(ESPERA, HIGH);
  }

  if (state==Gr && waiting && checkTime(now, lastStateStart, cooldownTime)){
    state++;
    waiting = false;
    lastStateStart=now;
  }

  if (state>=Yr && (checkTime(now, lastStateStart, stateTime[state-1]))){
    state++;
    if (state>Rr2)
      state=Gr;
    lastStateStart=now;
  }

  //Set lights
  switch(state){
    case Gr:
      lightCar('G');
      lightPasserby('R');
      break;
    case Yr:
      lightCar('Y');
      lightPasserby('R');
      break;
    case Rg:
      lightCar('R');
      lightPasserby('G');
      break;
    case Rr1:
    case Rr2:
      lightCar('R');
      lightPasserby('R');
      break;
    default:
      lightCar('Y');
      lightPasserby('G');
      break;
  }

  // Serial.println(state);
  // Serial.println(waiting);
  // Serial.println();
  Serial.println(digitalRead(BOTON));
  // delay(1000);
}

bool checkTime(unsigned long now, unsigned long base, int target){
  //Checks if now-base>=target while acounting for overflow
  unsigned long halfULong = pow(2,16);
  if (base >= halfULong){
    now-=halfULong;
    base-=halfULong;
  }
  return now-base>=(unsigned long)target;
}

void lightPasserby(char c){
  if (c=='G'){
    digitalWrite(PEATONES, HIGH);
    digitalWrite(ESPERA, LOW);
  }
  else{
    digitalWrite(PEATONES, LOW);
  }
}

void lightCar(char c){
  if (c=='G'){
    digitalWrite(COCHES, HIGH);
  }
  else if (c=='Y'){
    if (now%1000<500){
      digitalWrite(COCHES, HIGH);
    }
    else{
      digitalWrite(COCHES, LOW);
    }
  }
  else{
    digitalWrite(COCHES, LOW);
  }
}
