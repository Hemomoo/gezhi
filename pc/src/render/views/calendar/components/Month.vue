<template>
  <div class="month" :data-month="month" :data-year="year">
    <div class="month-name">{{month+1}}月</div>
    <div class="week-days">
        <template v-for="(weekday,index) in weekdays"  :key="index" >
          <div class="week-day"  >{{weekday}}</div>
        </template>
      </div>
    <div class="week" v-for="week in weeks">
      <Day
        v-for="day in week"
        :day="day"
        :key="day.getTime()"
        :isSelected="isSelected(day)"
        :onSelect="onSelect"
        :onDeselect="onDeselect"
      />
    </div>
  </div>
</template>

<script lang="ts">
import Day from './Day.vue'

export default {
  components: {
    Day
  },
  computed: {
    weeks () {
      let monthWeeks = []
      const firstDate = new Date(this.year, this.month, 1)
      const lastDate = new Date(this.year, this.month + 1, 0)
      let currentWeekDay = 0
      let currentWeek = []

      // Add days from previous month
      if (this.firstDay !== firstDate.getDay()) {
        let previousDate = new Date(this.year, this.month, 0)
        while (previousDate.getDay() !== this.firstDay) { previousDate.setDate(previousDate.getDate() - 1) }
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
    },
    weekdays () {
      let weekDays = []
      let firstDay = this.firstDay
      while (weekDays.length !== 7) {
        weekDays.push(this.dayNames[firstDay])
        firstDay += 1
        if (firstDay >= this.dayNames.length) { firstDay = 0 }
      }
      return weekDays
    },
  },
  methods: {
    isSelected (date) {
      const isoDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`
      return this.selectedDates.indexOf(isoDate) !== -1
    }
  },
  props: {
    month: {
      type: Number,
      required: true
    },
    year: {
      type: Number,
      required: true
    },
    firstDay: {
      type: Number,
      required: true
    },
    onSelect: {
      type: Function,
      required: true
    },
    onDeselect: {
      type: Function,
      required: true
    },
    selectedDates: {
      type: Array,
      required: true
    },
    dayNames: {
      type: Array,
      default:function (): Array<String>  { return ['日', '一', '二', '三', '四', '五', '六'] }
    },
  }
}
</script>

<style lang="scss">
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
