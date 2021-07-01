<template class="edit-diary">
  <head>
      <div></div>
      <div></div>
  </head>
  <main>
      <p class="tit">{{}}</p>
  </main>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import {reactive,toRefs} from "vue"
import Main from '../../layout/components/Main.vue'
//定义ts数据类型
 interface dataProps{

 }
export default{
  name:"EditDiary",
//import引入的组件需要注入到对象中才能使用
  components: {Main},
//这里存放数据
  setup() {
   const data = reactive({})
    return {
      data
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
