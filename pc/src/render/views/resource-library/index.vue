<template>
  <div class="">
    <n-card style="width: 100%;height: 100vh;">
      <n-tabs default-value="template" justify-content="center">
        <n-tab-pane name="template" tab="模板库">Wonderwall</n-tab-pane>
        <n-tab-pane name="tips" tab="提示库">Hey Jude</n-tab-pane>
        <n-tab-pane name="famous" tab="名言库">七里香</n-tab-pane>
      </n-tabs>
    </n-card>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, defineComponent } from "vue";
//定义ts数据类型
interface dataProps {}
export default defineComponent({
  name: "",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive({});
    return {
      data,
    };
  },
});
</script>

<style lang="scss" scoped>


</style>
