const { setGlobalOptions } = require("firebase-functions/v2");
const {
  onCall,
  onRequest,
  HttpsError,
} = require("firebase-functions/v2/https");
const {
  onDocumentCreated,
  onDocumentDeleted,
} = require("firebase-functions/v2/firestore");
const { MongoClient } = require("mongodb");
const { defineString } = require("firebase-functions/params");
require("dotenv").config();

setGlobalOptions({ maxInstances: 10 });

const MONGODB_URI =
  process.env.MONGODB_URI || defineString("MONGODB_URI").value();
const DB_NAME = "applications";
const APPROVED_COLLECTION = "approved";
const UNAPPROVED_COLLECTION = "unapproved";

let cachedClient = null;
let cachedDb = null;

async function connectToDatabase() {
  if (cachedClient && cachedDb) {
    return { client: cachedClient, db: cachedDb };
  }

  const client = new MongoClient(MONGODB_URI, {
    maxPoolSize: 10,
    minPoolSize: 2,
    serverSelectionTimeoutMS: 5000,
  });

  await client.connect();
  const db = client.db(DB_NAME);

  cachedClient = client;
  cachedDb = db;

  console.log("MongoDB'ye bağlandı.");
  return { client, db };
}

exports.search = onCall(async (request) => {
  const { data } = request;
  const { term } = data;
  const target = 0;
  const page = -1;

  if (!term) {
    throw new HttpsError("invalid-argument", "Arama terimi gereklidir");
  }

  try {
    const limit = 10;
    const collectionName =
      target == 0 ? APPROVED_COLLECTION : UNAPPROVED_COLLECTION;

    const { db } = await connectToDatabase();
    const collection = db.collection(collectionName);

    const agg = [
      {
        $search: {
          index: "application_name",
          autocomplete: {
            query: term,
            path: "name",
            tokenOrder: "sequential",
          },
        },
      },
    ];

    if (page != -1) {
      const pageLimit = limit * page;
      const skip = (page - 1) * limit;
      agg.push({ $limit: pageLimit });
      agg.push({ $skip: skip });
    }

    const docs = await collection.aggregate(agg).toArray();

    return docs;
  } catch (error) {
    console.error("Arama Hatası:", error);
    throw new HttpsError("internal", "Arama sırasında bir hata oluştu");
  }
});

exports.addToIndexMongo = onDocumentCreated(
  "/approvedApplications/{documentId}",
  async (event) => {
    try {
      const original = event.data.data();
      const docId = event.data.id;

      const { db } = await connectToDatabase();
      const collection = db.collection(APPROVED_COLLECTION);

      const documentToSave = {
        id: docId,
        ...original,
      };

      await collection.updateOne(
        { id: docId },
        { $set: documentToSave },
        { upsert: true }
      );

      console.log(`Döküman MongoDB'ye eklendi/güncellendi: ${docId}`);
      return true;
    } catch (error) {
      console.error("Ekleme Hatası:", error);
      return false;
    }
  }
);

exports.removeToIndexMongo = onDocumentDeleted(
  "/approvedApplications/{documentId}",
  async (event) => {
    try {
      const docId = event.data.id;

      const { db } = await connectToDatabase();
      const collection = db.collection(APPROVED_COLLECTION);

      await collection.deleteOne({ id: docId });

      console.log(`Döküman MongoDB'den silindi: ${docId}`);
      return true;
    } catch (error) {
      console.error("Silme Hatası:", error);
      return false;
    }
  }
);
