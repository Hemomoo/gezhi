<template>
  <div class="vue-infinite-calendar">
    <div class="calendar-header">
      <a href="javascript:void(0)" class="today-button" @click="scrollToDate(new Date())">今日</a>
      <div class="current-year">{{ currentYear }}</div>
    </div>
    <div class="calendar-container"  @scroll="handleScroll">
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
import MonthList from './monthList.vue'
export default {
  name: "CalendarItem",
  components: {
    MonthList
  },
  data() {
    return {
      currentYear: new Date().getFullYear() as Number,
      selectedDates: [] as Array<any> 
    }
  },
  computed: {
    months() {
      let month: Number = this.min.getMonth()
      let year: Number = this.min.getFullYear()
      let currentDate = this.min
      let displayedMonths = []

      while (currentDate.getTime() < this.max.getTime()) {
        displayedMonths.push({ year: year, month: month })
        month += 1
        if (month >= 12) {
          year += 1
          month -= 12
        }
        currentDate = new Date(year, month)
      }
      return displayedMonths
    },
    headerHeight() {
      return this.$el.querySelector('.calendar-header').getBoundingClientRect().height
    }
  },
  created() {
    this.selected.forEach((date:Date) => {
      const isoDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`
      this.selectedDates.push(isoDate)
    })
  },
  mounted() {
    this.scrollToDate(new Date())
  },
  props: {
    selected: {
      type: Array,
      default: function(): Array<String> { return [] }
    },
    min: {
      type: Date,
      default: function(): Date {
        return new Date(1980, 0, 1)
      }
    },
    max: {
      type: Date,
      default: function(): Date {
        return new Date(2050, 11, 31)
      }
    },
    firstDay: {
      type: Number,
      default: 1 as Number// Monday
    },
    onSelect: {
      type: Function,
      default() { }
    },
    onDeselect: {
      type: Function,
      default() { }
    }
  },
  methods: {
    scrollToDate(date:Date) {
      const month:number = date.getMonth()
      const year:number = date.getFullYear()
      this.scrollToMonth(year, month)
    },
    scrollToMonth(year: number, month: number) {
      const headerHeight = this.headerHeight
      const offset = this.$el.querySelector(`.month[data-month="${month}"][data-year="${year}"]`).offsetTop
      this.$el.querySelector('.calendar-container').scrollTop = offset - headerHeight
    },
    handleScroll(e) {
      const headerHeight = this.headerHeight
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
  }
}
</script>

<style lang="scss">
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
