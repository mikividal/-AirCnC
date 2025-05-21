import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    flatpickr(this.inputTarget, {
      mode: "range",
      dateFormat: "Y-m-d",
      onChange: (selectedDates) => {
        const [start, end] = selectedDates
        document.getElementById("start-date").value = start?.toISOString().split("T")[0] || ""
        document.getElementById("end-date").value = end?.toISOString().split("T")[0] || ""
      }
    })
  }
}
