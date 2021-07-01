<template>
    <div class="month" :data-month="month" :data-year="year">
        <div class="month-name">{{ month + 1 }}月</div>
        <div class="week-days">
            <template v-for="(weekday,index) in weekdays" :key="index">
                <div class="week-day">{{ weekday }}</div>
            </template>
        </div>
        <div class="week" v-for="week in weeks">
            <Day v-for="day in week" :day="day" :key="day.getTime()" :isSelected="isSelected(day)"  :isShowDay="isShowDay(day)" />
        </div>
    </div>
</template>

<script lang="ts">
import Day from './Day.vue'
import { reactive, toRefs, defineComponent, computed, PropType, ComputedRef } from "vue"
//定义ts数据类型
interface dataProps {

}
export default defineComponent({
    name: "MonthNew",
    components: {
        Day
    },
    props: {
        month: {
            type: Number as PropType<number>,
            required: true
        },
        year: {
            type: Number as PropType<number>,
            required: true
        },
        firstDay: {
            type: Number as PropType<number>,
            required: true
        },
        selectedDates: {
            type: Array,
            required: true
        },
        dayNames: {
            type: Array as PropType<Array<string>>,
            default: ['日', '一', '二', '三', '四', '五', '六']
        },
    },
    //这里存放数据
    setup(props) {
        const data = reactive({})
        const weekdays = computed(() => {
            let weekDays = []
            let firstDay = props.firstDay
            while (weekDays.length !== 7) {
                weekDays.push(props.dayNames[firstDay])
                firstDay += 1
                if (firstDay >= props.dayNames.length) { firstDay = 0 }
            }
            return weekDays
        })


        const weeks = computed(() => {
            let monthWeeks = []
            const firstDate = new Date(props.year, props.month, 1)
            const lastDate = new Date(props.year, props.month + 1, 0)
            let currentWeekDay = 0
            let currentWeek = []

            // Add days from previous month
            if (props.firstDay !== firstDate.getDay()) {
                let previousDate = new Date(props.year, props.month, 0)
                while (previousDate.getDay() !== props.firstDay) { previousDate.setDate(previousDate.getDate() - 1) }
                while (previousDate.getTime() !== firstDate.getTime()) {
                    const day = new Date(previousDate.getTime())
                    currentWeek.push(day)
                    currentWeekDay += 1
                    previousDate.setDate(previousDate.getDate() + 1)
                }
            }

            // Add days from current month
            while (firstDate.getTime() !== lastDate.getTime()) {
                const day = new Date(firstDate.getTime())
                if (currentWeekDay === 7) {
                    monthWeeks.push(currentWeek)
                    currentWeekDay = 0
                    currentWeek = []
                }
                currentWeek.push(day)
                currentWeekDay += 1
                firstDate.setDate(firstDate.getDate() + 1)
            }
            if (currentWeek.length > 0) {
                while (currentWeek.length !== 7) {
                    const day = new Date(firstDate.getTime())
                    currentWeek.push(day)
                    firstDate.setDate(firstDate.getDate() + 1)
                }
                monthWeeks.push(currentWeek)
            }
            return monthWeeks
        })

        function isSelected(date: any):boolean {
            const isoDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`
            return props.selectedDates.indexOf(isoDate) !== -1
        }

        // 是不是可以显示点击
        function isShowDay(day:Date):boolean{
            const month:number = day.getMonth()
            return !(month === props.month) 
        }

        return {
            data,
            weekdays,
            weeks,
            isSelected,
            isShowDay
        }
    }
})
</script>

<style lang="scss" scoped>
.week {
    width: 100%;
}

.month {
    .month-name {
        font-weight: bold;
        margin-left: 20px;
        padding-top: 15px;
        margin-bottom: 5px;
    }
}

.week-days {
    width: 100%;
    margin-bottom: 5px;

    .week-day {
        display: inline-block;
        width: 14.28571%;
        text-align: center;
    }
}
</style>
