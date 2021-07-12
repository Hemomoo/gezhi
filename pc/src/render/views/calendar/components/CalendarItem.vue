<template>
  <div class="vue-infinite-calendar">
    <div class="calendar-header f fjb fac">
      <a href="javascript:void(0)" class="today-button" @click="scrollToDate(new Date())">今日</a>
      <div class="current-year">{{ currentYear }}</div>
    </div>
    <div class="calendar-container" ref="calendarContainer" @scroll="handleScroll" v-infinite-scroll="load" style="overflow: auto">
      <MonthList ref="monthList" :months="months" :firstDay="firstDay" :selectedDates="selectedDates" />
    </div>
  </div>
</template>

<script lang="ts">
import MonthList from "./MonthList.vue";
import moment from "moment";
import { reactive, toRefs, ref, defineComponent, PropType, computed, onMounted } from "vue";
//定义ts数据类型
interface dataProps {
  max: Date;
  min: Date;
}
export default defineComponent({
  name: "Calendar",
  //import引入的组件需要注入到对象中才能使用
  components: { MonthList },
  props: {
    firstDay: {
      type: Number as PropType<number>,
      default: 1, // Monday
    },
    max: {
      type: Object,
      default: new Date(2022, 11, 31),
    },
    selected: {
      type: Array as PropType<Array<string>>,
      default: [],
    },
    min: {
      type: Date,
      default: new Date(2019, 0, 1),
    },
  },
  //这里存放数据
  setup(props, context) {
    let calendarContainer = ref<any | null>(null);
    const selectedDates = ref<any[]>([]);
    const monthList = ref<any | null>(null);
    const currentYear = ref<number>();
    const data = reactive<dataProps>({
      max: new Date(2022, 11, 31),
      min: new Date(2019, 0, 1),
    });

    function scrollToDate(date: Date): void {
      const month: number = date.getMonth();
      const year: number = date.getFullYear();
      scrollToMonth(year, month);
    }

    // 组件挂载后触发的钩子函数
    onMounted(() => {
      //進入的時候就調用一次
      scrollToDate(new Date());
    });

    function scrollToMonth(year: number, month: number): void {
      const offset: number = (document as any).querySelector(`.month[data-month="${month}"][data-year="${year}"]`).offsetTop;
      calendarContainer.value.scrollTop = offset - 40;
    }

    // 滚动获取这个年
    function handleScroll(): void {
      const scrollTop: number = (document as any).querySelector(".calendar-container").scrollTop;
      const years: NodeListOf<Element> = document.querySelectorAll(".year");
      for (let i = 0; i < years.length; i++) {
        const year: any = years[i];
        if (scrollTop <= year.offsetTop - 30) {
          if (i !== 0) {
            currentYear.value = Number(year.innerHTML) - 1;
          }
          return;
        }
      }
      currentYear.value = data.max.getFullYear();
    }

    // load加载跟多
    function load() {
      data.max = new Date(moment(data.max).add(1, "y").toDate());
    }

    // 计算属性
    const months = computed(() => {
      let month: number = data.min.getMonth();
      let year: number = data.min.getFullYear();
      let currentDate = data.min;
      let displayedMonths = [];
      while (currentDate.getTime() < data.max.getTime()) {
        displayedMonths.push({ year: year, month: month });
        month += 1;
        if (month >= 12) {
          year += 1;
          month -= 12;
        }
        currentDate = new Date(year, month);
      }
      return displayedMonths;
    });

    return {
      data,
      months,
      currentYear,
      scrollToDate,
      handleScroll,
      monthList,
      selectedDates,
      calendarContainer,
      load, // 加载更多的方法
    };
  },
});
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
