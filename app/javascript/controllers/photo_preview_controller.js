import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    console.log("Photo Preview controller connected")
    this.files = []
    this.signedIds = new Map()
  }

  preview() {
    Array.from(this.inputTarget.files).forEach(file => {
      const key = `${file.name}-${file.size}`
      if (!this.signedIds.has(key)) {
        this.files.push(file)
        this.readFileAndPreview(file, key)
      }
    })
    // Clear input to allow uploading the same file again if needed
    this.inputTarget.value = ""
  }

  readFileAndPreview(file, key) {
    const reader = new FileReader()
    reader.onload = (e) => {
      const wrapper = document.createElement("div")
      wrapper.className = "preview-wrapper"
      wrapper.dataset.key = key

      const img = document.createElement("img")
      img.src = e.target.result
      img.className = "preview-image"

      const closeBtn = document.createElement("button")
      closeBtn.type = "button"
      closeBtn.innerText = "×"
      closeBtn.className = "remove-image-btn"
      closeBtn.addEventListener("click", () => this.removeImage(key, wrapper))

      const progress = document.createElement("div")
      progress.className = "upload-progress"

      wrapper.appendChild(img)
      wrapper.appendChild(closeBtn)
      wrapper.appendChild(progress)
      this.previewTarget.appendChild(wrapper)

      this.uploadFile(file, key, progress)
    }
    reader.readAsDataURL(file)
  }

  uploadFile(file, key, progressBar) {
    const url = this.inputTarget.dataset.directUploadUrl
    const upload = new DirectUpload(file, url, {
      directUploadWillStoreFileWithXHR: (xhr) => {
        xhr.upload.addEventListener("progress", event => {
          const progress = (event.loaded / event.total) * 100
          progressBar.style.width = `${progress}%`
        })
      }
    })

    upload.create((error, blob) => {
      if (error) {
        console.error("Upload error:", error)
      } else {
        this.signedIds.set(key, blob.signed_id)
        this.syncHiddenInputs()
      }
    })
  }

  removeImage(key, wrapper) {
    this.signedIds.delete(key)
    this.files = this.files.filter(f => `${f.name}-${f.size}` !== key)
    wrapper.remove()
    this.syncHiddenInputs()
  }

  syncHiddenInputs() {
    this.element.querySelectorAll("input[type='hidden'][data-uploaded]").forEach(i => i.remove())
    this.signedIds.forEach(signedId => {
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = `${this.inputTarget.name}[]`
      input.value = signedId
      input.dataset.uploaded = true
      this.element.appendChild(input)
    })
  }
}
