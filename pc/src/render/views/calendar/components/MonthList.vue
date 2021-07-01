<template>
  <div class="month-list">
    <template v-for="month in months">
      <div class="year" v-if="month.month === 0">{{month.year}}</div>
      <Month
        :month="month.month"
        :year="month.year"
        :firstDay="firstDay"
        :selectedDates="selectedDates"
      ></Month>
    </template>
  </div>
</template>

<script lang="ts">
import Month from './Month.vue'
import {reactive,toRefs,defineComponent,PropType } from "vue"
//定义ts数据类型
 interface dataProps{

 }

interface Month{
    year:number,
    month:number
}

export default defineComponent ({
  name:"MonthListNew",
//import引入的组件需要注入到对象中才能使用
  components: {
    Month
  },
  props: {
    months: {
      type: Array as PropType<Array<Month>>,
      required: true
    },
    firstDay: {
      type: Number as PropType<number>,
      required: true
    },
   
    selectedDates: {
      type: Array as PropType<any[]>,
      required: true
    }
  },
//这里存放数据
  setup(props) {
   const data = reactive({})
    return {
      data
    }
  }
})
</script>

<style lang="scss" scoped>
</style>
