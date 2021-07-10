<template>
  <div class="sort-dialog">
    <n-list>
      <n-list-item>
        <template v-for="{ item, index } in sortArr" :key="index">
          <SortItem :title="item.title" :sub-title="item.subTitle"></SortItem>
        </template>
      </n-list-item>
    </n-list>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, defineComponent } from "vue";
import SortItem from "./SortItem.vue";
//定义ts数据类型
interface dataProps {}

interface SortItemInterface {
  title: string;
  subTitle: string;
}
export default defineComponent({
  name: "SortDialog",
  //import引入的组件需要注入到对象中才能使用
  components: { SortItem },
  //这里存放数据
  setup() {
    let data = reactive({
      sortArr: [
        {
          title: "日记本",
          subTitle: "全部",
        },
        {
          title: "日记本",
          subTitle: "全部",
        },
        {
          title: "日记本",
          subTitle: "全部",
        },
        {
          title: "日记本",
          subTitle: "全部",
        },
        {
          title: "日记本",
          subTitle: "全部",
        },
      ] as SortItemInterface[],
    });
    return {
      ...toRefs(data),
    };
  },
});
</script>

<style lang="scss" scoped>
.sort-dialog {
  width: 200px;
  z-index: 1900;
}
</style>
