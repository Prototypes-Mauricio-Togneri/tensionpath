import {onRequest} from "firebase-functions/v2/https";
import {setGlobalOptions} from "firebase-functions/v2/options";

setGlobalOptions({
  region: "europe-west6",
  timeoutSeconds: 60,
});

export const helloWorld = onRequest((request, response) => {
  response.send("Hello from Firebase 4");
});
