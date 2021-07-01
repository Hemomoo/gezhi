<template>
    <n-popselect
        v-model:value="dayVal"
        @update:value="change"
        :options="options"
        trigger="click"
        placement="bottom"
    >
        <div
            :class="{ day: true, 'base-color': isToday, 'is-selected': selected, 'disabled': isShowDay }"
        >{{ day.getDate() }}</div>
    </n-popselect>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, ref, defineComponent, PropType, computed, onMounted, watch } from "vue"

import { useRouter, useRoute, LocationQueryValue } from 'vue-router'
//定义ts数据类型
interface dataProps {

}
export default defineComponent({
    name: "DayNew",
    //import引入的组件需要注入到对象中才能使用
    components: {},
    props: {
        day: {
            type: Date as PropType<Date>,
            required: true,
        },
        isSelected: {
            type: Boolean as PropType<boolean>,
            required: true
        },
        isShowDay: {
            type: Boolean as PropType<boolean>,
            required: true
        }
    },
    //这里存放数据
    setup(props) {
        let dayVal = ref<string>('')
        const data = reactive({})
        let selected = ref<boolean>(false)
        //   路由管理器，用来管理所有的路由
        const router = useRouter()
        // route 当前路由
        const route = useRoute()

        // 计算属性会自动计算类型
        const isToday = computed(() => {
            const today: Date = new Date()
            const day: Date = props.day
            return day.getFullYear() === today.getFullYear() &&
                day.getMonth() === today.getMonth() &&
                day.getDate() === today.getDate()
        })

        // 挂载
        onMounted(() => {
        })

        // 监听
        // watch(dayVal, (count, prevCount) => {
        //     console.log('prevCount: ', prevCount);
        //     console.log('count: ', count);
        // })


        function change() {
            const day: any = props.day
            router.push({ path: "/edit-diary", params: { day } })
        }

        return {
            data,
            selected,
            isToday,
            change,
            dayVal, // 选择的option
            options: [
                {
                    label: '日记本',
                    value: 'diary'
                },
                {
                    label: '在本日',
                    value: 'inToday'
                }]
        }
    }
})
</script>

<style lang="scss" scoped>
.day {
    cursor: pointer;
    display: inline-block;
    height: 43px;
    line-height: 43px;
    text-align: center;
    border-radius: 22px;
    width: 14.28571%;
}

.disabled {
    pointer-events: none;
    cursor: default;
    color: #000;
    opacity: 0.6;
}

.day.is-today {
    background-color: blanchedalmond;
}

.day.is-selected:hover {
    background-color: lightskyblue;
}

.day:hover {
    background-color: whitesmoke;
}
</style>

