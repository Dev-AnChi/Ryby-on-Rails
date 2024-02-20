// app/javascript/controllers/dimension-form_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["resultSection"];

  submit(event) {
    event.preventDefault();
    const form = this.element;
  
    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log(data); // Kiểm tra xem data được trả về từ server là gì
      this.resultSectionTarget.innerHTML = `<h2>Result:</h2><pre>${JSON.stringify(data, null, 2)}</pre>`;
      form.reset();
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Lỗi khi gửi biểu mẫu.');
    });
  }
  
}
