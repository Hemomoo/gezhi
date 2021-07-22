<!-- 模板库 -->
<template>
  <div class="formwork">

  </div>
</template>

<script lang="ts">

import {reactive,toRefs,defineComponent} from "vue"
//定义ts数据类型
 interface dataProps{

 }
export default defineComponent ({
  name:"",
//import引入的组件需要注入到对象中才能使用
  components: {},
//这里存放数据
  setup() {
   const data = reactive({

   })
    return {
      data
    }
  }
})
</script>

<style lang="scss" scoped>
</style>
