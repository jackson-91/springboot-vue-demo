import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex'
import router from './router'
import './plugins/element.js'
import './assets/css/global.css'
import axios from './axios/http'
import { store } from './store/store'
import './plugins/dialog'
import filters from './filter/index';
import "./assets/css/style.css"
import '@/assets/icons'
import Tinymce from '@/components/form-designer/tinymce/index.vue'

Vue.component('tinymce', Tinymce)

Vue.use(Vuex)
Vue.prototype.$http = axios
Vue.config.productionTip = false

for (var i in filters) {
  Vue.filter(i, filters[i]);
}

new Vue({
  axios,
  router,
  store,
  render: h => h(App)
}).$mount('#app')
