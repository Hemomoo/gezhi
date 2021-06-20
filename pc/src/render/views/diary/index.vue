<template>
  <div class="diary">
    <template v-for="(item, index) in diaryList" :key="index">
        <router-link class="diary-item" to="/edit-diary" tag="div">
          <div >{{ item }}</div>
        </router-link>
    </template>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs } from "vue";
//定义ts数据类型
interface dataProps {}
export default {
  name: "Diary",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive({});
    const diaryList = [
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
    ];
    return {
      data,
    };
  },
};
</script>

<style lang="scss" scoped>
.diary {
  height: 100vh;
  display: grid;
  grid-template-columns: repeat(3, 33.33%);
  grid-template-rows: repeat(3, 33.33%);
  &-item {
    border-bottom: 1px solid gainsboro;
    border-right: 1px solid gainsboro;
    &:hover {
      background: gray;
    }
    &:nth-child(5):hover {
      background: white;
    }
  }
}

// .diary-item:hover {
//   background: gray;
// }
</style>
