<template>
  <div class="cont">
    <div class="top tac fwb">附件</div>
    <div class="content" v-infinite-scroll="load" style="overflow:auto">
      <div class="item" v-for="(item, index) in imgs">
        <div class="item-img">
          <img :src="item.img" alt="" />
          <p class="date cfff">{{ item.date }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { reactive, toRefs, defineComponent } from "vue";
//定义ts数据类型
interface dataProps {}

interface Img {
  img: string;
  date: string;
}


interface dataType{
  imgs:Img[]
}


export default defineComponent({
  name: "Attachment",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive<dataType>({
      imgs: [
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_07.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_08.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_10.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_11.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
        {
          img: "https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg",
          date: "2021年12月10日",
        },
      ] ,
    });

    function load(){
      data.imgs = data.imgs.concat(data.imgs)
    }

    return {
      load,
      ...toRefs(data)
    };
  },
});
</script>

<style scoped>
.top {
  height: 60px;
  line-height: 60px;
}

.content {
  height: calc(100vh - 60px);
  overflow: scroll;
  display: grid;
  grid-template-columns: repeat(6, calc(100vw / 6 - 260px / 6));
}

.content > .item {
  width: 100%;
  display: block;
  height: calc(80vw / 6);
}

.item-img {
  width: 100%;
  height: 100%;
  position: relative;
}
.item-img img {
  position: absolute;
  display: block;
  width: 100%;
  height: 100%;
  /* object-fit: cover; */
}

.date {
  position: absolute;
  bottom: 2px;
  z-index: 2;
}
</style>
