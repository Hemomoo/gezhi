<template>
  <div class="sort-item">
    <div class="f fjb  pointer" >
      <p>{{ title }}</p>
      <div class="f fac">
        <p>{{ subTitle }}</p>
        <n-icon ref="sortButton"><ArrowForwardIosFilled></ArrowForwardIosFilled></n-icon>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { reactive, toRefs, defineComponent, PropType } from "vue";
import { ArrowForwardIosFilled } from "@vicons/material";
//定义ts数据类型
interface dataProps {}
export default defineComponent({
  name: "SortItem",
  //import引入的组件需要注入到对象中才能使用
  components: {
    ArrowForwardIosFilled,
  },
  props: {
    title: {
      type: String as PropType<string>,
      defalut: "",
    },
    subTitle: {
      type: String as PropType<string>,
      defalut: "全部",
    },
  },
  //这里存放数据
  setup() {
    const data = reactive({});
    return {
      data,
    };
  },
});
</script>

<style lang="scss" scoped></style>
