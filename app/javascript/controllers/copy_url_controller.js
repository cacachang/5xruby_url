import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["page"];

  initialize() {
    this.urlId = 0;
  }

  connect() {
    this.urlId = this.element.dataset.urlId;
  }

  copyToClipboard() {
    console.log(this.pageTarget.innerHTML);
    navigator.clipboard.writeText(this.pageTarget.innerHTML);
  }
}
