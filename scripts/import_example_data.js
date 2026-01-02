#!/usr/bin/env node

/**
 * Firebase Emulator Data Import Script
 * 
 * This script converts data/example_scheme.json to Firebase emulator format
 * and imports it to emulator-data directory.
 * 
 * Usage:
 *   node scripts/import_example_data.js
 * 
 * Then start emulator with:
 *   flutter pub run emulator
 *   or
 *   firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data
 */

const fs = require('fs');
const path = require('path');

const EXAMPLE_DATA_PATH = path.join(__dirname, '../data/example_scheme.json');
const EMULATOR_DATA_PATH = path.join(__dirname, '../emulator-data');
const FIRESTORE_EXPORT_PATH = path.join(EMULATOR_DATA_PATH, 'firestore_export');
const ALL_NAMESPACES_PATH = path.join(FIRESTORE_EXPORT_PATH, 'all_namespaces');
const ALL_KINDS_PATH = path.join(ALL_NAMESPACES_PATH, 'all_kinds');

// Collection name mapping (JSON keys to Firestore collection names)
const COLLECTION_MAP = {
  'approvedAdvertise': 'approvedAdvertise',
  'touristicPlaces': 'touristicPlaces',
  'adBoard': 'adBoard',
  'regionalCities': 'regionalCities',
  'regionalTowns': 'regionalTowns',
  'adminList': 'adminList',
  'approvedCampaigns': 'approvedCampaigns',
  'unApprovedCampaigns': 'unApprovedCampaigns',
  'specialAgency': 'specialAgency',
  'news': 'news',
  'memories': 'memories',
  'towns': 'towns',
  'allowedAdminClaims': 'allowedAdminClaims',
  'approvedApplications': 'approvedApplications',
  'unApprovedApplications': 'unApprovedApplications',
  'notifications': 'notifications',
  'developers': 'developers',
  'logs': 'logs',
  'categories': 'categories',
  'scholarship': 'scholarship',
  'chainStores': 'chainStores',
  'usefulLinks': 'usefulLinks'
};

/**
 * Convert a value to Firestore format
 */
function convertToFirestoreValue(value) {
  if (value === null) {
    return { nullValue: null };
  }
  
  if (typeof value === 'boolean') {
    return { booleanValue: value };
  }
  
  if (typeof value === 'number') {
    if (Number.isInteger(value)) {
      return { integerValue: value.toString() };
    }
    return { doubleValue: value };
  }
  
  if (typeof value === 'string') {
    // Check if it's a timestamp (ISO 8601 format)
    if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/.test(value)) {
      return { timestampValue: value };
    }
    return { stringValue: value };
  }
  
  if (Array.isArray(value)) {
    return {
      arrayValue: {
        values: value.map(convertToFirestoreValue)
      }
    };
  }
  
  if (typeof value === 'object') {
    return {
      mapValue: {
        fields: Object.keys(value).reduce((acc, key) => {
          acc[key] = convertToFirestoreValue(value[key]);
          return acc;
        }, {})
      }
    };
  }
  
  return { stringValue: String(value) };
}

/**
 * Convert a document to Firestore format
 */
function convertToFirestoreDocument(data) {
  return {
    name: '', // Will be set by Firestore
    fields: Object.keys(data).reduce((acc, key) => {
      acc[key] = convertToFirestoreValue(data[key]);
      return acc;
    }, {}),
    createTime: new Date().toISOString(),
    updateTime: new Date().toISOString()
  };
}

/**
 * Generate a document ID from data
 */
function generateDocumentId(collectionName, data) {
  // Try to find an ID field
  if (data.id) return data.id;
  if (data.documentId) return data.documentId;
  if (data.name) return data.name.toLowerCase().replace(/\s+/g, '_');
  if (data.title) return data.title.toLowerCase().replace(/\s+/g, '_');
  if (data.campaignName) return data.campaignName.toLowerCase().replace(/\s+/g, '_');
  if (data.applicantId) return data.applicantId;
  if (data.userId) return data.userId;
  if (data.developerId) return data.developerId;
  if (data.configName) return data.configName;
  if (data.claimName) return data.claimName;
  
  // Fallback: use collection name + timestamp
  return `${collectionName}_${Date.now()}`;
}

/**
 * Main function
 */
function main() {
  console.log('🔥 Firebase Emulator Data Import Script\n');
  
  // Check if example data file exists
  if (!fs.existsSync(EXAMPLE_DATA_PATH)) {
    console.error(`❌ Error: ${EXAMPLE_DATA_PATH} not found!`);
    process.exit(1);
  }
  
  // Read example data
  console.log(`📖 Reading ${EXAMPLE_DATA_PATH}...`);
  const exampleData = JSON.parse(fs.readFileSync(EXAMPLE_DATA_PATH, 'utf8'));
  
  // Create directory structure
  console.log('📁 Creating directory structure...');
  [EMULATOR_DATA_PATH, FIRESTORE_EXPORT_PATH, ALL_NAMESPACES_PATH, ALL_KINDS_PATH].forEach(dir => {
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
  });
  
  // Process each collection
  let totalDocuments = 0;
  Object.keys(exampleData).forEach(key => {
    const collectionName = COLLECTION_MAP[key] || key;
    const data = exampleData[key];
    
    if (!data) return;
    
    // Create collection directory
    const collectionPath = path.join(ALL_KINDS_PATH, collectionName);
    if (!fs.existsSync(collectionPath)) {
      fs.mkdirSync(collectionPath, { recursive: true });
    }
    
    // Generate document ID
    const docId = generateDocumentId(collectionName, data);
    const docPath = path.join(collectionPath, `${docId}.json`);
    
    // Convert to Firestore format
    const firestoreDoc = convertToFirestoreDocument(data);
    
    // Write document
    fs.writeFileSync(docPath, JSON.stringify(firestoreDoc, null, 2));
    console.log(`  ✅ ${collectionName}/${docId}.json`);
    totalDocuments++;
  });
  
  // Create metadata file
  const metadata = {
    version: '1.0.0',
    exportTime: new Date().toISOString(),
    collections: Object.keys(exampleData).map(key => COLLECTION_MAP[key] || key)
  };
  
  fs.writeFileSync(
    path.join(FIRESTORE_EXPORT_PATH, 'metadata.json'),
    JSON.stringify(metadata, null, 2)
  );
  
  console.log(`\n✅ Successfully imported ${totalDocuments} documents to ${EMULATOR_DATA_PATH}`);
  console.log('\n📝 Next steps:');
  console.log('   1. Start emulator: flutter pub run emulator');
  console.log('   2. Or manually: firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data');
  console.log('\n💡 Tip: The emulator will use this data on startup and save changes on exit.\n');
}

// Run script
main();

