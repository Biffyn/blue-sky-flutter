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

exports.geocoding = functions.https.onRequest((req, res) => {

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

  let suburb = "";

  if (address.address.suburb) {
    suburb = address.address.suburb
  } else if (address.address.locality) {
    suburb = address.address.locality
  } else {
    suburb = null;
  }

  let formattedAddress = {
    city: address.address.city,
    suburb: suburb,
    latitude: address.lat,
    longitude: address.lon
  }
  
  return formattedAddress
}

/// Helper to format the request URL
function formatDarkSkyUrl(latitude, longitude, units) {
  const apiKey = functions.config().darksky.key;
  return `https://api.darksky.net/forecast/${apiKey}/${latitude},${longitude}?units=${units}?lang=de`
}

function formatGeocodingUrl(latitude, longitude) {
  const apiKey = functions.config().geocoding.key;
  return `https://us1.locationiq.com/v1/reverse.php?key=${apiKey}&lat=${latitude}&lon=${longitude}&format=json&zoom=14`

 
}