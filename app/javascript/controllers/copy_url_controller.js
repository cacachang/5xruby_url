import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["page"];

  copyToClipboard() {
    console.log("in");

    console.log(this.pageTarget.innerHTML);
    navigator.clipboard.writeText(this.pageTarget.innerHTML);
  }
}
