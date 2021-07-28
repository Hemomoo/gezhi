<template>
  <div class="sort-dialog">
    <div  v-bind="$attrs">测试attrs</div>
    <transition name="fade-righ" @before-enter="beforeEnter" :duration="1000">
      <!-- 二级菜单 -->
      <n-list v-if="secondaryListShow">
        <n-list-item>
          <template v-for="(item,index) in sortArr" :key="index"> 测试 </template>
        </n-list-item>
      </n-list>
      <!-- 一级菜单 -->
      <n-list v-else>
        <template v-for="(item,index) in sortArr" :key="index">
          <n-list-item @click="navigator">
            <SortItem :title="item.title" :sub-title="item.subTitle"></SortItem>
          </n-list-item>
        </template>
      </n-list>
    </transition>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, defineComponent, ref } from "vue";
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
  emits:[], // 抛出事件
  //这里存放数据
  setup() {
    let secondaryListShow = ref<boolean>(false);
    let data = reactive({
      sortArr: [
        {
          title: "日记本",
          subTitle: "全部",
        },
        {
          title: "类型",
          subTitle: "全部",
        },
        {
          title: "贴纸",
          subTitle: "全部",
        },
        {
          title: "标签",
          subTitle: "全部",
        },
        {
          title: "年份",
          subTitle: "全部",
        },
      ] as SortItemInterface[],
    });

    function navigator(): void {
      secondaryListShow.value = true;
    }

    function beforeEnter():void {}

    return {
      secondaryListShow,
      navigator,
      beforeEnter,
      ...toRefs(data),
    };
  },
});
</script>

<style lang="scss" scoped>
.sort-dialog {
  z-index: 1900;
}
</style>
