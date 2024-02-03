const { setGlobalOptions } = require("firebase-functions/v2");
const axios = require("axios");
const functions = require("firebase-functions");
// const { onDocumentCreated } = require("firebase-functions/firestore");

setGlobalOptions({ maxInstances: 10 });

if (process.env.FUNCTIONS_EMULATOR) {
  require("dotenv").config();
}

const BASE_URL = process.env.FUNCTIONS_EMULATOR
  ? process.env.BASE_URL
  : functions.config().mongo.baseurl;

const SECRET = process.env.FUNCTIONS_EMULATOR
  ? process.env.SECRET
  : functions.config().mongo.secret;

const SEARCH_PATH = "/applications_search";
const ADD_PATH = "/application_insert";

axios.defaults.headers.common["SECRET"] = SECRET;

exports.search = functions.https.onCall(async (data, _) => {
  const { term } = data;
  const target = 0;
  const page = -1;
  try {
    const mongoResponse = await axios.get(BASE_URL + SEARCH_PATH, {
      params: { term, target, page },
    });

    const response = mongoResponse.data.map((item) => {
      return { name: item.name, id: item.id };
    });

    return response;
  } catch (error) {
    return [];
  }
});

exports.addDataToMongo = functions.firestore
  .document("/approvedApplications/{documentId}")
  .onCreate(async (change, context) => {
    const original = change.data();
    const target = 0;

    const jsonBody = JSON.stringify({
      id: change.id,
      ...original,
    });
    const mongoResponse = await axios.post(BASE_URL + ADD_PATH, jsonBody, {
      params: { target },
    });


    console.log(mongoResponse);
    return mongoResponse != null;
  });
