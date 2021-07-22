<template>
  <div class="resource-cont">
    <n-card style="width: 100%; height: 100vh">
      <n-tabs default-value="template" v-model:value="tabActive" justify-content="center" @update:vuale="tab">
        <n-tab-pane name="template" tab="模板库">
          <p :id='test'>{{ test }}</p>
        </n-tab-pane>
        <n-tab-pane name="tips" tab="提示库">Hey Jude</n-tab-pane>
        <n-tab-pane name="famous" tab="名言库">七里香</n-tab-pane>
      </n-tabs>
    </n-card>
  </div>
</template>

<script lang="ts">
import { reactive, toRefs, defineComponent, ref, PropType } from "vue";
//定义ts数据类型
interface dataProps {}

type TabActive = "template" | "tips" | "famous";

export default defineComponent({
  name: "",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  props: {
    test: {
      type: String as PropType<string>,
      default: "测试",
    },
  },
  //这里存放数据
  setup(props) {
    const tabActive = ref<TabActive>("template");
    const data = reactive({});
    function tab(value: string) {
      console.log("value: ", value);
      console.log("12121");
    }

    return {
      data,
      tabActive,
      tab,
    };
  },
});
</script>

<style lang="scss" scoped>
.resource-cont {
  width: calc(100vw - 240px);
}

::v-deep(.n-tabs-tab) {
  margin: 0 40px;
}
</style>
