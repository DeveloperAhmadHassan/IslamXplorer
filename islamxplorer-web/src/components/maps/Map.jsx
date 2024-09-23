import { GoogleMap, Marker, useLoadScript } from "@react-google-maps/api";
import { useEffect, useState } from "react";
import "./styles.css";

const Map = () => {
  const { isLoaded, loadError } = useLoadScript({
    googleMapsApiKey: "AIzaSyDlUJlwbraJe3NQBgAuXtPRwlAxeHLvI7o",
    libraries: ["places"], // Include the places library
  });
  const [currentPosition, setCurrentPosition] = useState(null);

  useEffect(() => {
    // Fetch user's current location
    navigator.geolocation.getCurrentPosition(
      (position) => {
        setCurrentPosition({
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        });
      },
      (error) => {
        console.error("Error getting current position:", error);
      }
    );
  }, []);

  if (loadError) return <div>Error loading maps</div>;
  if (!isLoaded) return <div>Loading...</div>;

  return (
    <div className="map">
      {currentPosition ? (
        <GoogleMap
          mapContainerClassName="map-container"
          center={currentPosition}
          zoom={15}
        >
          {/* Marker for user's current position */}
          <Marker
            position={currentPosition}
            icon={"http://maps.google.com/mapfiles/ms/icons/green-dot.png"}
        />

          {/* Other markers for nearby mosques */}
          <NearbyMosquesMarkers currentPosition={currentPosition} />
        </GoogleMap>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
};

// Component to fetch and display markers for nearby mosques
const NearbyMosquesMarkers = ({ currentPosition }) => {
  const [nearbyMosques, setNearbyMosques] = useState([]);
  const [error, setError] = useState(null);

  // Fetch nearby mosques using Google Places API
  useEffect(() => {
    const placesService = new window.google.maps.places.PlacesService(
      document.createElement("div")
    );
    placesService.nearbySearch(
      {
        location: currentPosition,
        radius: 5000, // Search within 5km radius
        type: "mosque", // Search for mosques
      },
      (results, status) => {
        if (status === "OK") {
          setNearbyMosques(results);
          setError(null); // Clear any previous errors
        } else {
          setError(status); // Set error status
          console.error("Error fetching nearby mosques:", status);
        }
      }
    );
  }, [currentPosition]);

  // Display markers for nearby mosques
  return (
    <>
      {error && <div>Error fetching nearby mosques: {error}</div>}
      {nearbyMosques.map((mosque) => (
        <Marker
            key={mosque.place_id}
            position={{
                lat: mosque.geometry.location.lat(),
                lng: mosque.geometry.location.lng(),
            }}
            icon={"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png"}
        />
      ))}
    </>
  );
};

export default Map;
