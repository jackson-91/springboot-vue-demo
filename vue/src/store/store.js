import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// 一个store  , Vuex.store的 实例
export const store = new Vuex.Store({
  strict: true,
  state: localStorage.getItem('state')
    ? JSON.parse(localStorage.getItem('state'))
    : {
      token: '',
      menus: [],
      dicset: []
    },
  getters: { //  Getter相当于vue中的computed计算属性
    getToken: (state) => { return state.token }
  },
  mutations: {
    set_token(state, ltoken) { // 第一个参数是拿到state对象
      localStorage.setItem('token', ltoken)
      state.token = ltoken
    },
    del_token(state) {
      localStorage.removeItem('token')
      state.token = ''
    },
    set_menu(state, menus) { // 第一个参数是拿到state对象
      localStorage.setItem('menu', menus)
      state.menus = menus
    },
    del_menu(state) {
      localStorage.removeItem('menu')
      state.menus = []
    },
    set_dicset(state, dicset) {
      localStorage.setItem('dicset', dicset)
      state.dicset = dicset
    },
    del_dicset(state) {
      localStorage.removeItem('dicset')
      state.dicset = []
    },
    set_user(state, userinfo) {
      localStorage.setItem('userinfo', userinfo)
      state.userinfo = userinfo
    },
    del_user(state) {
      localStorage.removeItem('userinfo')
      state.userinfo = []
    },
    clear_state(state) {
      localStorage.clear(); state.token = null; state.menus = null; state.userinfo=null;state.dicset==null; state = null
    }
  },
  actions: {
    // 注册actions，类似vue里面的methods
    // 通过这个修改state里面的值
    // 可以直接用mutations修改，但是官方建议使用actions去调用mutations去修改
    set_token(context, token) {
      context.commit('set_token', token)
    },
    del_token(context) {
      context.commit('del_token')
    },
    set_menu(context, menus) {
      context.commit('set_menu', menus)
    },
    del_menu(context) {
      context.commit('del_menu')
    },
    set_dicset(context, dicset) {
      context.commit('set_dicset', dicset)
    },
    del_dicset(context) {
      context.commit('del_dicset')
    },
    set_user(context, userinfo) {
      context.commit('set_user', userinfo)
    },
    del_user(context) {
      context.commit('del_user')
    },
    clear_state(context) {
      context.commit('clear_state')
    }
  }
})
