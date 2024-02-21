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
      return response.text();
    })
    .then(html => {
      const turboStreamElement = document.createElement('template');
      turboStreamElement.innerHTML = html;
      const turboStream = turboStreamElement.content.querySelector('turbo-stream');

      if (turboStream) {
        document.body.appendChild(turboStream);
      }
      
      form.reset();
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Lỗi khi gửi biểu mẫu.');
    });
  }
}
