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
          <div :class="['tit-item', 'f', 'fjb', 'pointer', { active: +item === +mouseItemId }]" @mouseover="mouseOver(item)" @click="clickTime(item)">
            <p>测试数据{{ item }}</p>
            <p>{{ index }}</p>
          </div>
        </template>
      </div>
    </div>
    <div class="right">
      <swiper :mousewheel="mousewheel" @swiper="onSwiper" @slideChangeTransitionEnd="onSlideChange">
        <template v-for="(item, index) in 200" :key="index">
          <swiper-slide>
            <Grid></Grid>
          </swiper-slide>
        </template>
      </swiper>
    </div>
  </div>
</template>

<script lang="ts">
import { SearchOutline } from "@vicons/ionicons5";
import Grid from "./components/Grid.vue";
import { ref,reactive, toRefs } from "vue";
import "swiper/swiper.scss";
import { Swiper, SwiperSlide } from "swiper/vue";
import SwiperCore, { Mousewheel, Controller, A11y, Autoplay } from "swiper";
import { defineComponent } from 'vue'
SwiperCore.use([Mousewheel]);


export default defineComponent({
  name: "",
  data() {
    return {
      mousewheel: {
        mousewheel: true, // 是不是可以鼠标滑动
        thresholdTime: 600,
      },
    };
  },
  components: {
    SearchOutline,
    Grid,
    Swiper,
    SwiperSlide,
  },
  setup() {
    let mouseItemId = ref(1);
    const data = reactive({
      controlledSwiper: null
    })  
    
    const mouseOver = (id:any) => {
      mouseItemId.value = id;
    };


    const onSwiper = (swiper:Swiper) => {
      data.controlledSwiper = swiper
    };
    const onSlideChange = (swiper: Swiper) => {
      mouseItemId.value = swiper.activeIndex + 1;
    };

    function clickTime(item:any){
      data.controlledSwiper.slideTo(item-1)
      console.log(' data.controlledSwiper: ',  data.controlledSwiper);
    }  



    return {
      mouseItemId,
      mouseOver,
      onSwiper,
      onSlideChange,
      clickTime,
      ...toRefs(data)  
    };
  },
})
</script>

<style>
.swiper-slide {
  width: 100% !important;
}
</style>

<style lang="scss" scpoed>
.time-line {
  .left {
    width: 240px;
    box-sizing: border-box;
    height: 100vh;
    position: relative;
    box-sizing: border-box;
    &::after {
      position: absolute;
      top: -40px;
      right: 0;
      bottom: 0;
      content: "";
      width: 1px;
      background: gray;
    }
    .tit-list {
      box-sizing: border-box;
      height: calc(100vh - 74px);
      overflow: scroll;
      padding: 0 10px;
      width: 240px;
      box-sizing: border-box;
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
    width: calc(100vw - 480px);
  }
}
</style>
