import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "removeButton"]

  connect() {
    console.log("Photo preview controller connected")
  }

  preview() {
    this.previewTarget.innerHTML = ""
    Array.from(this.inputTarget.files).forEach(file => {
      const reader = new FileReader()
      reader.onload = e => {
        const img = document.createElement("img")
        img.src = e.target.result
        img.style.maxWidth = "150px"
        img.style.marginRight = "10px"
        this.previewTarget.appendChild(img)
      }
      reader.readAsDataURL(file)
    })
    this.removeButtonTarget.style.display = this.inputTarget.files.length ? "inline-block" : "none"
  }

  remove() {
    this.inputTarget.value = ""
    this.previewTarget.innerHTML = ""
    this.removeButtonTarget.style.display = "none"
  }
}
