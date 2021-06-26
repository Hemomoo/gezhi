<template >
  <div class="edit-diary">
    <div>
      <div>{{ today }}</div>
      <div></div>
    </div>
    <p>今天是元气满满的一天</p>
    
     <v-md-editor v-model="text" height="100vh"></v-md-editor>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs } from "vue";
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import moment from "moment";
//定义ts数据类型
interface dataProps {}
export default {
  name: "EditDiary",
  //import引入的组件需要注入到对象中才能使用
  components: {mavonEditor},
  data() {
    return { text: "" };
  },
  //这里存放数据
  setup() {
    const data = reactive({});
    const today = moment().format("YYYY-MM-DD");
    console.log("today: ", today);
    return {
      data,
      today,
    };
  },
};
</script>

<style lang="scss" scoped>
.edit-diary {
  width: 100%;
  height: 100%;
}
</style>
