<template>
  <div class="f fjb">
    <div class="fwb">{{ tit }}</div >
    <div class='f fac '>
     <slot>{{suffixTit}}</slot >
      <n-icon size="20" :depth="4" class="ml10">
        <IosArrowForward />
      </n-icon>
    </div >
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, defineComponent, PropType } from "vue";
import { IosArrowForward } from "@vicons/ionicons4";

//定义ts数据类型
interface dataProps {}
export default defineComponent({
  name: "ListItem",
  //import引入的组件需要注入到对象中才能使用
  components: {IosArrowForward},
  props: {
    tit: {
      type: String as PropType<string>,
      defalut: "",
      required:true
    },
    suffixTit: {
      type: String as PropType<string>,
      defalut: "",
    },
  },
  setup() {
    const data = reactive({});
    return {
      data,
    };
  },
});
</script>

<style lang="scss" scoped></style>
