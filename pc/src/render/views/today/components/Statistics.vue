<template>
  <div class="statistics">
    <p class="fwb f24">统计</p>
    <div class="data">
      <template v-for="(item, index) in data.statisticsList" :key="index">
        <div class="fwb f fdc fje">
          <p :class="[{'f30':item.tit==='日记'} ]">{{ item.num }}</p>
          <p>{{ item.tit }}</p>
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
  name: "Statistics",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive({
      statisticsList: [
        {
          tit: "日记",
          num: 200,
        },
        {
          tit: "格子",
          num: 200,
        },
        {
          tit: "字符",
          num: 200,
        },
        {
          tit: "开始日",
          num: 200,
        },
        {
          tit: "当前连续",
          num: 200,
        },
        {
          tit: "最长连续",
          num: 200,
        },
      ],
    });
    return {
      data,
    };
  },
};
</script>

<style lang="scss" scoped>
.statistics {
  background: rgb(86, 163, 171);
  color: #fff;
  padding: 6% 4%;
  border-radius: 4%;
  min-width: 240px;
  .data {
    display: grid;
    min-height: 130px ;
    grid-template-rows: repeat(2, 50%);
    grid-template-columns: repeat(3,33.333%);
  }
}
</style>
