<template>
    <div class="vue-infinite-calendar">
        <div class="calendar-header">
            <a href="javascript:void(0)" class="today-button" @click="scrollToDate(new Date())">今日</a>
            <div class="current-year">{{ currentYear }}</div>
        </div>
        <div class="calendar-container" ref="calendarContainer" @scroll="handleScroll">
            <MonthList
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
import { reactive, toRefs,ref, defineComponent, PropType, computed } from "vue"
import { months } from '_moment@2.29.1@moment'
//定义ts数据类型
interface dataProps {

}
export default defineComponent({
    name: "",
    //import引入的组件需要注入到对象中才能使用
    components: { MonthList },
    props: {
        selected: {
            type: Array as PropType<Array<string>>,
            default: function() { return [] }
        },
        min: {
            type: Date as PropType<Date>,
            default: function() {
                return new Date(2010, 0, 1)
            }
        },
        max: {
            type: Date as PropType<Date>,
            default: function() {
                return new Date(2020, 11, 31)
            }
        },
        firstDay: {
            type: Number as PropType<number>,
            default: 1// Monday
        },
        onSelect: {
            type: Function as PropType<() => void>,
            default() { }
        },
        onDeselect: {
            type: Function as PropType<() => void>,
            default() { }
        }
    },
    //这里存放数据
    setup(props) {
        const data = reactive({})

        function scrollToDate(date: Date) {
            const month: number = date.getMonth()
            const year: number = date.getFullYear()
            scrollToMonth(year, month)
        }

        function scrollToMonth(year: number, month: number) {
            const headerHeight = this.headerHeight
            const offset = this.$el.querySelector(`.month[data-month="${month}"][data-year="${year}"]`).offsetTop
            this.$el.querySelector('.calendar-container').scrollTop = offset - headerHeight
        }


        function handleScroll() {
            const headerHeight = headerHeight.value
            const scrollTop = this.$el.querySelector('.calendar-container').scrollTop
            const years = this.$el.querySelectorAll('.year')
            for (let i = 0; i < years.length; i++) {
                const year = years[i]
                if (scrollTop <= year.offsetTop - (headerHeight - 10)) {
                    if (i !== 0) { this.currentYear = Number(year.innerHTML) - 1 }
                    return
                }
            }
            this.currentYear = this.max.getFullYear()
        }

        const calendarContainer = ref<HTMLElement|null>(null);    
        // 计算属性
        const headerHeight = computed(() => {
            return calendarContainer.value?.getBoundingClientRect().height
        })

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
            console.log(displayedMonths);
            return displayedMonths
        })

        return {
            data,
            handleScroll,
            
        }
    }
})
</script>

<style lang="scss" scoped>
</style>
