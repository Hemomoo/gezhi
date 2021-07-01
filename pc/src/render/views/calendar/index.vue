<template>
  <div class="">
    <CalendarItem></CalendarItem>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
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
