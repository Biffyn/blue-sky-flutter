const functions = require('firebase-functions');
const http = require('requestify');
const cors = require('cors')({origin: true});
const firebaseConfig = JSON.parse(process.env.FIREBASE_CONFIG);

exports.darkSkyProxy = functions.https.onRequest((req, res) => {

  /// Wrap request with cors
  cors(req, res, () => {

    /// Get the url params
    const latitude = req.query.latitude
    const longitude = req.query.longitude
    const units = "si"

    const url = formatDarkSkyUrl(latitude, longitude, units);

    /// Send request to DarkSky
    return http.get(url).then(response => {
        return res.status(200).send(response.getBody());
      })
      .catch(err => {
        return res.status(400).send(err)
      })

  });

});

exports.googleGeocoding = functions.https.onRequest((req, res) => {

  cors(req, res, () => {

    const latitude = req.query.latitude
    const longitude = req.query.longitude

    const url = formatGeocodingUrl(latitude, longitude);

    return http.get(url).then(response => {
        let formattedAddress = formatAddress(response.getBody())
        return res.status(200).send(formattedAddress);
      })
      .catch(err => {
        return res.status(400).send(err)
      })

  });
})

function formatAddress(address) {

  let address_components = address.results[0].address_components;

  let formattedAddress = {
    city: "",
    district: "",
  }

  address_components.forEach(function (val) {
    if (val.types[0] === "political") {
      formattedAddress.district = val.long_name;
    }

    if (val.types[0] === "locality") {
      formattedAddress.city = val.long_name;
    }
    
  })
  return formattedAddress
}

/// Helper to format the request URL
function formatDarkSkyUrl(latitude, longitude, units) {
  const apiKey = functions.config().darksky.key;
  return `https://api.darksky.net/forecast/${apiKey}/${latitude},${longitude}?units=${units}`
}

function formatGeocodingUrl(latitude, longitude) {
  const apiKey = functions.config().geocoding.key;
  return `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${apiKey}`
}