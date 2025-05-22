import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.files = [] // Track selected files here
  }

  preview() {
    // Add new files from input to this.files, avoiding duplicates
    const newFiles = Array.from(this.inputTarget.files)

    newFiles.forEach(file => {
      // Only add if not already in files (compare by name + size)
      if (!this.files.some(f => f.name === file.name && f.size === file.size)) {
        this.files.push(file)
      }
    })

    this.updatePreview()
    this.resetInput()
  }

  updatePreview() {
    this.previewTarget.innerHTML = ''

    this.files.forEach((file, index) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const wrapper = document.createElement('div')
        wrapper.classList.add('preview-wrapper')
        wrapper.style.position = 'relative'
        wrapper.style.display = 'inline-block'
        wrapper.style.marginRight = '10px'
        wrapper.style.marginBottom = '10px'

        const img = document.createElement('img')
        img.src = e.target.result
        img.style.width = '100px'
        img.style.height = '100px'
        img.style.objectFit = 'cover'
        img.style.borderRadius = '4px'
        img.style.boxShadow = '0 0 5px rgba(0,0,0,0.3)'

        const btn = document.createElement('button')
        btn.type = 'button'
        btn.textContent = '×'  // multiply symbol for “X”
        btn.style.position = 'absolute'
        btn.style.top = '2px'
        btn.style.right = '2px'
        btn.style.background = 'rgba(0,0,0,0.5)'
        btn.style.color = 'white'
        btn.style.border = 'none'
        btn.style.borderRadius = '50%'
        btn.style.width = '20px'
        btn.style.height = '20px'
        btn.style.cursor = 'pointer'
        btn.title = 'Remove image'

        btn.addEventListener('click', () => {
          this.files.splice(index, 1)
          this.updatePreview()
        })

        wrapper.appendChild(img)
        wrapper.appendChild(btn)
        this.previewTarget.appendChild(wrapper)
      }
      reader.readAsDataURL(file)
    })

    // Update the actual input element’s files to match this.files:
    this.updateInputFiles()
  }

  resetInput() {
    // Clear input so change event triggers even if user selects same files again
    this.inputTarget.value = ''
  }

  updateInputFiles() {
    // Unfortunately, input.files is read-only, so we create a DataTransfer to set it
    const dataTransfer = new DataTransfer()
    this.files.forEach(file => dataTransfer.items.add(file))
    this.inputTarget.files = dataTransfer.files
  }
}
