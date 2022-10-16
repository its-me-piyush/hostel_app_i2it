// FingurePrint: change.
// fingurePrint site: https://www.grc.com/fingerprints.htm
// Manage Libraries arduinojson: 5.13.2
// Tools -> board -> board Managers : esp8266 : 2.7.3  -> 3.0.2


#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

// Set these to run example.
#define DATABASE_URL "hostel-app-i2it-default-rtdb.firebaseio.com"
#define API_KEY "kaq5aHpDYrvpspQaH4Sny2cFsmCQfun98AwhdPrd"

#define WIFI_SSID "Zsiecr"
#define WIFI_PASSWORD "piyushnagpal007"

#define USER_EMAIL "hostelEsp8266@esp8266.com"
#define USER_PASSWORD "hostel@Esp@8266"

#define LED_GPIO 5 //D1
#define FAN_GPIO 14 //D5

FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

void setup() {
  Serial.begin(115200);

  pinMode(LED_GPIO, OUTPUT);
  pinMode(FAN_GPIO, OUTPUT);

  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  Firebase.begin(DATABASE_URL, API_KEY);

  //Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  //  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {

  //  // set bool value
  //  Firebase.setBool("N007/LED", false);
  //  // handle error
  if (Firebase.ready()) {
    delay(1000);

    // get bool
    Serial.print("N007/LED: ");
    delay(1000);

    //    Serial_Printf("Set bool... %s\n", Firebase.RTDB.getBool(&fbdo, F("/test/bool")));
    //    Serial.printf("Get bool... %s\n", Firebase.RTDB.getBool(&fbdo, FPSTR("/test/bool")) ? fbdo.to<bool>() ? "true" : "false" : fbdo.errorReason().c_str());

    
    Firebase.RTDB.getBool(&fbdo, FPSTR("/N007/LED"));
    
    if (fbdo.to<bool>()) {
      digitalWrite(LED_GPIO, HIGH);
      Serial.print("ON\n");
      delay(1000);
    }
    if (!fbdo.to<bool>()) {
      digitalWrite(LED_GPIO, LOW);
      Serial.print("OFF\n");
      delay(1000);
    }

    Serial.print("N007/FAN: ");
    delay(1000);
    
    Firebase.RTDB.getBool(&fbdo, FPSTR("/N007/FAN"));

    if (fbdo.to<bool>()) {
      digitalWrite(FAN_GPIO, HIGH);
      Serial.print("ON\n");
      delay(1000);
    }
    if (!fbdo.to<bool>()) {
      digitalWrite(FAN_GPIO, LOW);
      Serial.print("OFF\n");
      delay(1000);
    }
  }
  else {
    Serial.print("setting /N007/LED failed:\n");
    return;
  }
}
