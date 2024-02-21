import { Controller } from "stimulus";

export default class extends Controller {
  // Turbo Streams callback
  success(event) {
    const stream = event.detail[0];
    if (stream.target && stream.target.includes('result-section')) {
      this.resultSectionTarget.innerHTML = stream.template;
    }
  }
}
