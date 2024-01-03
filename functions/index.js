const {onCall, HttpsError} = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const axios = require("axios");
const functions = require("firebase-functions");

setGlobalOptions({maxInstances: 10});


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

axios.defaults.headers.common['SECRET'] = SECRET;

exports.search = functions.https.onCall(async (data, context) => 
 {
  const { term, page } = data;
  const target = 0; 
  try {
    const mongoResponse = await axios.get(BASE_URL + SEARCH_PATH, {
      params: { term, target, page }
    });

    return mongoResponse.data;

    response.json(mongoResponse.data);
  } catch (error) {

    return {};
    response
      .status(axios.HttpStatusCode.InternalServerError)
      .send(error.message);
  }
});
