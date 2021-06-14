<template>
  <div class="time-line f">
    <div class="left">
      <div class="pl10 pr10 mt40">
        <n-input placeholder="搜索标题">
          <template #prefix>
            <n-icon>
              <search-outline />
            </n-icon>
          </template>
        </n-input>
      </div>

      <div class="tit-list">
        <template v-for="(item, index) in 100" :key="index">
          <div
            :class="[
              'tit-item',
              'f',
              'fjb',
              'pointer',
              { active: +item === +mouseItemId },
            ]"
            @mouseover="mouseOver(item)"
          >
            <p>测试数据{{ item }}</p>
            <p>{{ index }}</p>
          </div>
        </template>
      </div>
    </div>
    <div class="right">
      <swiper
        :slides-per-view="3"
        :space-between="50"
         navigation
        :scrollbar="{ draggable: true }"
        @swiper="onSwiper"
        @slideChange="onSlideChange"
      >
      <template v-for="(item,index) in 10" :key="index">
         <swiper-slide ><Grid></Grid></swiper-slide>
      </template>
       
      </swiper>
    </div>
  </div>
</template>

<script lang="ts">
import { SearchOutline } from "@vicons/ionicons5";
import Grid from "./components/Grid.vue";
import { ref } from "vue";
import { Swiper, SwiperSlide } from "swiper/vue";
// import SwiperCore, { Navigation, Pagination, Scrollbar, A11y } from 'swiper';
import 'swiper/swiper.scss';
export default {
  name: "",
  data() {
    return {};
  },
  components: {
    SearchOutline,
    Grid,
    Swiper,
    SwiperSlide,
  },
  setup() {
    let mouseItemId = ref(1);
    const mouseOver = (id) => {
      mouseItemId.value = id;
    };

    const  onSwiper=(swiper) =>{
        console.log(swiper);
      };
     const onSlideChange =()=> {
        console.log('slide change');
      };


    return {
      mouseItemId,
      mouseOver,
      onSwiper,
      onSlideChange
    };
  },
};
</script>

<style>
.swiper-slide{
  width: 100% !important;
}
</style>

<style lang="scss" scpoed>

.time-line {
  .left {
    width: 240px;
    height: 100vh;
    position: relative;
    &::after {
      position: absolute;
      top: -40px;
      right: 0;
      bottom: 0;
      content: "";
      width: 1px;
      background: gray;
    }
  }
  .left {
    .tit-list {
      box-sizing: border-box;
      height: calc(100vh - 74px);
      overflow: scroll;
      padding: 0 10px;
      .tit-item {
        height: 40px;
        line-height: 40px;
        padding: 0 4px;
      }
      .active {
        background: rgb(226, 225, 225);
        color: #fff;
      }
    }
  }
  .right {
    flex: 1;
    height: 100vh;
  }
}
</style>
