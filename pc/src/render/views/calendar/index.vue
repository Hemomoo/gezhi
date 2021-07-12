<template>
  <div class="">
    <CalendarItem></CalendarItem>
  </div>
</template>

<script lang="ts">
import CalendarItem from './components/CalendarItem.vue'
import {reactive,toRefs,defineComponent} from "vue"
//定义ts数据类型
 interface dataProps{

 }

export default defineComponent({
  name:"Calendar",
//import引入的组件需要注入到对象中才能使用
  components: {
    CalendarItem
  },
//这里存放数据
  setup() {
   const data = reactive({})
    return {
      data
    }
  }
}) 
</script>

<style lang="scss" scoped>
</style>
