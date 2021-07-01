<template>
    <div class="vue-infinite-calendar">
        <div class="calendar-header">
            <a href="javascript:void(0)" class="today-button" @click="scrollToDate(new Date())">今日</a>
            <div class="current-year">{{ currentYear }}</div>
        </div>
        <div class="calendar-container" ref="calendarContainer" @scroll="handleScroll">
            <MonthList
                ref="monthList"
                :months="months"
                :firstDay="firstDay"
                :onSelect="onSelect"
                :onDeselect="onDeselect"
                :selectedDates="selectedDates"
            />
        </div>
    </div>
</template>

<script lang="ts">
import MonthList from './MonthListNew.vue'
import { reactive, toRefs, ref, defineComponent, PropType, computed } from "vue"
//定义ts数据类型
interface dataProps {

}
export default defineComponent({
    name: "",
    //import引入的组件需要注入到对象中才能使用
    components: { MonthList },
    props: {
        firstDay: {
            type: Number as PropType<number>,
            default: 1// Monday
        },
        max: {
            type: Object,
            default: new Date(2022, 11, 31)
        },
        selected: {
            type: Array as PropType<Array<string>>,
            default: []
        },
        min: {
            type: Date,
            default: new Date(2019, 0, 1)
        },
        onSelect: {
            type: Function as PropType<() => void>,
            required: true
        },
        onDeselect: {
            type: Function as PropType<() => void>,
            required: true
        }
    },
    //这里存放数据
    setup(props, context) {

        let calendarContainer = ref<any | null>(null);
        const selectedDates = ref<any[]>([])
        const monthList = ref<any | null>(null);
        const currentYear = ref<number>();
        const data = reactive({
           
        })


        function scrollToDate(date: Date):void {
            const month: number = date.getMonth()
            const year: number = date.getFullYear()
            scrollToMonth(year, month)
        }


        function scrollToMonth(year: number, month: number):void {
            console.log('month: ', month);
            console.log('year: ', year);
            const offset:number = (document as any).querySelector(`.month[data-month="${month}"][data-year="${year}"]`).offsetTop
            // calendarContainer.querySelector.value.scrollTop = offset - 40
        }


        function handleScroll():void {
            const scrollTop :number = (document as any).querySelector('.calendar-container').scrollTop
            const years: NodeListOf<Element>= document.querySelectorAll('.year')
            for (let i = 0; i < years.length; i++) {
                const year:any = years[i]
                if (scrollTop <= (year.offsetTop - 30)) {
                    if (i !== 0) { currentYear.value = Number(year.innerHTML) - 1 }
                    return
                }
            }
            currentYear.value = props.max.getFullYear()
        }


        // 计算属性
        const months = computed(() => {
            let month: number = props.min.getMonth()
            let year: number = props.min.getFullYear()
            let currentDate = props.min
            let displayedMonths = []
            while (currentDate.getTime() < props.max.getTime()) {
                displayedMonths.push({ year: year, month: month })
                month += 1
                if (month >= 12) {
                    year += 1
                    month -= 12
                }
                currentDate = new Date(year, month)
            }
            return displayedMonths
        })

        return {
            data,
            months,
            currentYear,
            scrollToDate,
            handleScroll,
            monthList,
            selectedDates

            // handleScroll,


        }
    }
})
</script>

<style lang="scss" scoped>

.vue-infinite-calendar {
  width: 300px;
  height: 100vh;
  position: relative;
}

.calendar-container {
  height: calc(100vh - 40px);
  overflow: scroll;
  -webkit-overflow-scrolling: touch;
  box-shadow: inset 0px 10px 10px -10px #ccc, inset 0px -10px 10px -10px #ccc;
  &::-webkit-scrollbar {
    display: none;
  }
}

.calendar-header {
  background-color: white;
  height: 40px;
  .current-year {
    font-size: 1.5rem;
  }
  .today-button {
    float: right;
    text-decoration: none;
  }
}
</style>
