#include <ArduinoJson.h>
#include <ESP8266Firebase.h>
#include <ESP8266WiFi.h>

#define _SSID "Doctor Who"                                                              // Your WiFi SSID
#define _PASSWORD "07723957"                                                            // Your WiFi Password
#define REFERENCE_URL "myproject-37f07-default-rtdb.europe-west1.firebasedatabase.app"  // Your Firebase project reference url

#define bFour D0
#define bThree D7
#define bTwo D6
#define bOne D5

#define aFour D4
#define aThree D3
#define aTwo D2
#define aOne D1

Firebase firebase(REFERENCE_URL);

void setup() {
  Serial.begin(115200);


  pinMode(bFour, INPUT);
  pinMode(bThree, INPUT);
  pinMode(bTwo, INPUT);
  pinMode(bOne, INPUT);

  pinMode(aFour, INPUT);
  pinMode(aThree, INPUT);
  pinMode(aTwo, INPUT);
  pinMode(aOne, INPUT);


  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(1000);

  // Connect to WiFi
  Serial.println();
  Serial.println();
  Serial.print("Connecting to: ");
  Serial.println(_SSID);
  WiFi.begin(_SSID, _PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print("-");
  }

  Serial.println("");
  Serial.println("WiFi Connected");

  // Print the IP address
  Serial.print("IP Address: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");
  digitalWrite(LED_BUILTIN, HIGH);

  //================================================================//
  // writeToFirebase();
}


void loop() {

  bSlotFour();
  bSlotThree();
  bSlotTwo();
  bSlotOne();

  aSlotFour();
  aSlotThree();
  aSlotTwo();
  aSlotOne();
}
// SLOT B4----------------------------
int bFourResult = 0;
void bSlotFour() {
  int result = digitalRead(bFour);

  if (bFourResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("B4", send);
  }

  bFourResult = result;
  delay(200);
}
// SLOT B3----------------------------
int bThreeResult = 0;
void bSlotThree() {
  int result = digitalRead(bThree);

  if (bThreeResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("B3", send);
  }

  bThreeResult = result;
  delay(200);
}
// SLOT B2----------------------------
int bTwoResult = 0;
void bSlotTwo() {
  int result = digitalRead(bTwo);

  if (bTwoResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("B2", send);
  }

  bTwoResult = result;
  delay(200);
}
// SLOT B1----------------------------
int bOneResult = 0;
void bSlotOne() {
  int result = digitalRead(bOne);

  if (bOneResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("B1", send);
  }

  bOneResult = result;
  delay(200);
}
// SLOT A4----------------------------
int aFourResult = 0;
void aSlotFour() {
  int result = digitalRead(aFour);

  if (aFourResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("A4", send);
  }

  aFourResult = result;
  delay(200);
}
// SLOT A3----------------------------
int aThreeResult = 0;
void aSlotThree() {
  int result = digitalRead(aThree);

  if (aThreeResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("A3", send);
  }

  aThreeResult = result;
  delay(200);
}
// SLOT A2----------------------------
int aTwoResult = 0;
void aSlotTwo() {
  int result = digitalRead(aTwo);

  if (aTwoResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("A2", send);
  }

  aTwoResult = result;
  delay(200);
}
// SLOT A1----------------------------
int aOneResult = 0;
void aSlotOne() {
  int result = digitalRead(aOne);

  if (aOneResult != result) {
    int send = 0;
    if (result == HIGH) {
      Serial.println("There is No Object!");
      send = 0;
    } else {
      send = 1;
      Serial.println("Object Detected!");
    }
    writeToFirebase("A1", send);
  }

  aOneResult = result;
  delay(200);
}

void writeToFirebase(String slot, int value) {
  // Write some data to the realtime database.
  firebase.setInt("Slots/" + slot, value);
}