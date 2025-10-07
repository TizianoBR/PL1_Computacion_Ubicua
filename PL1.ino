#define PEATONES 12
#define COCHES 13
#define BOTON 11
#define ESPERA 10

const int activationTime=5000;
const int cooldownTime=3000;
int lastActivation=0;

void setup() {
  pinMode(COCHES, OUTPUT);
  pinMode(PEATONES, OUTPUT);
  pinMode(BOTON, INPUT);
  
  digitalWrite(PEATONES, LOW);
  digitalWrite(COCHES, LOW);
  digitalWrite(ESPERA, LOW);
}

void loop() {
  int timeStamp = millis();
  if (digitalRead(BOTON)==HIGH){
    if (timeStamp < lastActivation + cooldownTime){
      digitalWrite(ESPERA, HIGH);
      delay(lastActivation + cooldownTime - timeStamp);
      digitalWrite(ESPERA, LOW);
    }
    digitalWrite(PEATONES, HIGH);
    digitalWrite(COCHES, LOW);
    delay(activationTime);
    lastActivation=millis();
  }
  else{
    digitalWrite(PEATONES, LOW);
    digitalWrite(COCHES, HIGH);
  }
}
