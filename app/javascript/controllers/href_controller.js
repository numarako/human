import { Controller } from 'stimulus'

export default class extends Controller {
  // 親要素のdata-href属性にあるパスに遷移する
  toHref(event) {
    event.preventDefault()
    const href = event.currentTarget.dataset['href']
    window.location.href = href
  }
}
