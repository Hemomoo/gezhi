<template>
  <div class="grid">
      <div class="grid-box">
        <template v-for="(item, index) in 9">
          <div class="grid-box-item">
            <p class="tit tac">tit{{ item }}</p>
            <p class="diary">tit{{ item }}</p>
          </div>
        </template>
      </div>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs } from "vue";
//定义ts数据类型
interface dataProps {}
export default {
  name: "Grid",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive({});
    return {
      data,
    };
  },
};
</script>

<style lang="scss" scoped>
.grid{
    height: 100vh;
    .grid-box{
    display: grid;
    grid-template-rows:repeat(3,33.333%);
    grid-template-columns:repeat(3,33.333%);
    &-item{
        border-bottom: 1px solid gainsboro;
        border-right: 1px solid gainsboro;
    }
}
}

</style>
