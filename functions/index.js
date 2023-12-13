const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const axios = require("axios");
const functions = require("firebase-functions");

if (process.env.FUNCTIONS_EMULATOR) {
  require("dotenv").config();
}
const BASE_URL = process.env.FUNCTIONS_EMULATOR
  ? process.env.BASE_URL
  : functions.config().mongo.baseurl;

const SEARCH_PATH = "/applications_search";

exports.search = onRequest(async (request, response) => {
  const { term, page } = request.query;
  const target = 0; // Since target is always zero

  try {
    const mongoResponse = await axios.get(BASE_URL + SEARCH_PATH, {
      params: { term, target, page },
    });

    response.json(mongoResponse.data);
  } catch (error) {
    response
      .status(axios.HttpStatusCode.InternalServerError)
      .send(error.message);
  }
});
