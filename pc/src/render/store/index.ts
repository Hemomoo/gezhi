// store.ts
import { InjectionKey } from 'vue'
import { createStore, Store } from 'vuex'

// 为 store state 声明类型
export interface State {
    slidebarActiveId: number
}

// 定义 injection key
export const key: InjectionKey<Store<State>> = Symbol()

export const store = createStore<State>({
    state: {
        slidebarActiveId: 1
    },
    mutations: {
        SLIDEBAR_ACTIVE_ID(state, activeId) {
            state.slidebarActiveId = activeId
        }
    },
    actions: {
        slidebarActiveIdFn(context, activeId) {
            context.commit('SLIDEBAR_ACTIVE_ID', activeId)
        }
    }
})