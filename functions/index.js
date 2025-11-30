const { setGlobalOptions } = require("firebase-functions/v2");
const axios = require("axios");
const { defineString } = require("firebase-functions/params");
const { onCall } = require("firebase-functions/v2/https");
const {
  onDocumentCreated,
  onDocumentDeleted,
} = require("firebase-functions/v2/firestore");

setGlobalOptions({ maxInstances: 10 });

if (process.env.FUNCTIONS_EMULATOR) {
  require("dotenv").config();
}

const BASE_URL = defineString("BASE_URL").value();
const SECRET = defineString("SECRET").value();

const SEARCH_PATH = "/applications_search";
const ADD_PATH = "/application_insert";
const DELETE_PATH = "/delete_application";
axios.defaults.headers.common["SECRET"] = SECRET;

exports.search = onCall(async (request) => {
  const { data } = request;
  const { term } = data;
  const target = 0;
  const page = -1;

  try {
    const mongoResponse = await axios.get(BASE_URL + SEARCH_PATH, {
      params: { term, target, page },
    });

    const response = mongoResponse.data.map((item) => {
      const image = item.images && item.images.length > 0 ? item.images[0] : "";

      return {
        name: item.name,
        id: item.id,
        image: image,
        cityId: item.cityId,
      };
    });

    return response;
  } catch (error) {
    return [];
  }
});

exports.addToIndexMongo = onDocumentCreated(
  "/approvedApplications/{documentId}",
  async (event) => {
    const original = event.data.data();
    const target = 0;
    const jsonBody = JSON.stringify({
      id: event.data.id,
      ...original,
    });
    const mongoResponse = await axios.post(BASE_URL + ADD_PATH, jsonBody, {
      params: { target },
    });

    return mongoResponse != null;
  }
);

exports.removeToIndexMongo = onDocumentDeleted(
  "/approvedApplications/{documentId}",
  async (event) => {
    const target = 0;
    const mongoResponse = await axios.delete(BASE_URL + DELETE_PATH, {
      params: { target, id: event.data.id },
    });

    return mongoResponse != null;
  }
);
