<template>
  <div class="paster"><n-input v-model:value="test" type="input" placeholder="基本的 Input" @input="$emit('update:value', $event)"></n-input></div>
  <slot></slot>
  <slot name="header"></slot>

  <testCon></testCon>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, PropType } from "vue";
import testCon from "./test.vue";
//定义ts数据类型
interface dataProps {}
export default {
  name: "Paster",
  components: { testCon },
  props: {
    test: {
      type: String as PropType<string>,
      defalut: "test",
    },
  },
  setup() {
    const data = reactive({});
    return {
      data,
    };
  },
};
</script>

<style lang="scss" scoped></style>
