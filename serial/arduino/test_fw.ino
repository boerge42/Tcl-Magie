/*
  
  Uwe Berger; 2015
  
*/


// ******************************************
String inputString = "";
boolean stringComplete = false;
int old_hall = 42;

int ledPin  = 13;
int hallPin = 11;

String message_led_on   = "LED on";
String message_led_off  = "LED off";
String message_hall_on  = "HALL on";
String message_hall_off = "HALL off";

// ******************************************
void setup() {
  Serial.begin(9600);
  inputString.reserve(10);
  //Serial.println("Init...");
  pinMode(ledPin, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(hallPin, INPUT); 
}

// ******************************************
void loop() {
  
  if (digitalRead(hallPin)) {
    if (old_hall == 1) {
      Serial.println(message_hall_off); 
    }
    old_hall = 0;
  } 
  else {
    if (old_hall == 0) {
      Serial.println(message_hall_on); 
    }
    old_hall = 1;
  }
  
  
  
  
  // empfangenes Kommando parsen...
  if (stringComplete) {
    inputString.toUpperCase();
    // Befehl ON
    if (String("ON") == inputString) {
      digitalWrite(ledPin, HIGH);
      Serial.println(message_led_on); 
    } 
    else 
      // Befehl OFF
      if (String("OFF") == inputString) {
      digitalWrite(ledPin, LOW);
      Serial.println(message_led_off); 
    } 
    else 
      // Befehl TOGGLE
      if (String("TOGGLE") == inputString) {
        if (digitalRead(ledPin)) {
          digitalWrite(ledPin, LOW);
          Serial.println(message_led_off); 
        } 
        else {
          digitalWrite(ledPin, HIGH);
          Serial.println(message_led_on); 
        }
      } 
    else 
      // Befehl STATUS
      if (String("STATUS") == inputString) {
        if (digitalRead(ledPin)) {
          Serial.println(message_led_on); 
        } 
        else {
          Serial.println(message_led_off); 
        }
      } 
    else { 
        Serial.println("cmd unknown!"); 
    } 

    inputString = "";
    stringComplete = false;
  }
}

// ******************************************
void serialEvent() {
  while (Serial.available()) {
    char inChar = (char)Serial.read(); 
    if (inChar == '\r') {
      stringComplete = true;
      //Serial.print('\n');
    } 
    else {
      inputString += inChar;
    } 
    //Serial.print(inChar);
  }
}

