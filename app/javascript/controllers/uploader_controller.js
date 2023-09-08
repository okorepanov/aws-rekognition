import { Controller } from "@hotwired/stimulus"

const ImageCreationUrl = 'images'

// Connects to data-controller="uploader"
export default class extends Controller {
  static targets = ["uploader", "picker", "pickerLabel"]

  formSubmit(event) {
    event.preventDefault();

    this.uploaderTarget.value = 'Uploading'

    let imageFile = this.pickerTarget.files[0];
    let formData = new FormData();

    formData.append('image', imageFile);

    fetch('images', {method: 'POST', body: formData,})
        .then(r => this.updateUploadButton())
  }

  updateUploadButton() {
    this.uploaderTarget.value = 'Upload'
    this.uploaderTarget.hidden = !this.uploaderTarget.hidden;
    this.pickerLabelTarget.hidden = !this.pickerLabelTarget.hidden;
  }
}
