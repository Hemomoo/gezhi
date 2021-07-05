<template>
  <div>
    <n-list>
       
      <n-list-item>
        <ListItem tit="头像">
          <NAvatar crice src="https://seaside-station.com/wpbin/wp-content/uploads/mori_08.jpg"></NAvatar>
        </ListItem>
      </n-list-item>
      <n-list-item>
        <ListItem tit="名字" suffixTit="何默"></ListItem>
      </n-list-item>
      <n-list-item>
        <ListItem tit="邮箱" suffixTit="787615673@qq.com"></ListItem>
      </n-list-item>
      <n-list-item>
        <ListItem tit="密码" ></ListItem>
      </n-list-item>
      <p class='f12 mt10'>第三方登录</p >
      <n-list-item>
        <ListItem tit="苹果" suffixTit="绑定"></ListItem>
      </n-list-item>
       <n-list-item>
        <ListItem tit="谷歌" suffixTit="绑定"></ListItem>
      </n-list-item>
       <n-list-item>
        <ListItem tit="微信" suffixTit="绑定"></ListItem>
      </n-list-item>
    </n-list>
    <p class="tac f12">于2019年加入格志</p >
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { NAvatar } from "naive-ui";
import { reactive, toRefs, defineComponent } from "vue";
import ListItem from "@/components/List-item.vue";
//定义ts数据类型
interface dataProps {}
export default defineComponent({
  name: "Modal",
  //import引入的组件需要注入到对象中才能使用
  components: {
    NAvatar,
    ListItem,
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
