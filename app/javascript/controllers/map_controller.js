// app/javascript/controllers/map_controller.js

import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("🗺️ Map controller connected")

    this.initializeMap()
    this.addMarkers()
    this.fitMapToMarkers()
    
  }

  initializeMap() {
    mapboxgl.accessToken = this.apiKeyValue || 'pk.eyJ1IjoibWlnejIyMDUiLCJhIjoiY21hemc4ZzJiMGJzcjJsc2Fxdm83MDdweiJ9.yu0zSvl3tEeW55Rw9wjFjA'

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [0, 20],
      zoom: 2
    })
  }

  addMarkers() {
    console.log("📍 Markers:", this.markersValue)

    this.markersValue.forEach(marker => {
      const mapMarker = new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(new mapboxgl.Popup().setHTML(marker.popup_html))
        .addTo(this.map)

      mapMarker.getElement().addEventListener("click", () => {
        this.fetchNearbyCountries(marker.id)
      })
    })
  }

  fetchNearbyCountries(countryId) {
    fetch(`/countries/${countryId}/nearby`)
      .then(response => {
        if (!response.ok) throw new Error("Network error")
        return response.json()
      })
      .then(data => {
        this.updateCountryList(data)
      })
      .catch(error => {
        console.error("Failed to fetch nearby countries:", error)
      })
  }

  updateCountryList(countries) {
    const list = document.getElementById("map-country-list")
    if (!list) return

    list.innerHTML = ""

    countries.forEach(country => {
      const li = document.createElement("li")
      li.className = "list-group-item"
      li.innerHTML = `<a href="/countries/${country.id}">${country.name}</a>`
      list.appendChild(li)
    })
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()

    this.markersValue.forEach(marker => {
      bounds.extend([marker.lng, marker.lat])
    })

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 5, duration: 0 })
  }
}
