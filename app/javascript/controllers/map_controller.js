// app/javascript/controllers/map_controller.js

import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
  console.log("🗺️ Map controller connected");

  mapboxgl.accessToken = 'pk.eyJ1IjoibWlnejIyMDUiLCJhIjoiY21hemc4ZzJiMGJzcjJsc2Fxdm83MDdweiJ9.yu0zSvl3tEeW55Rw9wjFjA'

  this.map = new mapboxgl.Map({
    container: this.element,
    style: "mapbox://styles/mapbox/streets-v11",
    center: [0, 20],
    zoom: 2
  })

  console.log("📍 Markers:", this.markersValue)

  this.markersValue.forEach(marker => {
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(new mapboxgl.Popup().setHTML(marker.info_window_html))
      .addTo(this.map)
  })

  this.fitMapToMarkers()
}

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 5, duration: 0 })
  }
}
