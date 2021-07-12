<template>
  <div class="time-line f">
    <div class="left mt20">
      <div class="head fja f">
        <p></p>
        <p class="fwb">时间线</p>
        <n-icon @click="sortShow = true" ref="sortButton"><SortFilled></SortFilled></n-icon>
        <n-modal
          v-model:show="sortShow"
          title="筛选"
          preset="card"
          :style="{
            width: '300px',
            position: 'fixed',
            left: `${offsetLeft}px`,
            top: `${offsetTop}px`,
          }"
        >
           <template #header-extra> 重置 </template>
          <SortDialog></SortDialog>
        </n-modal>
      </div>
      <div class="pl10 pr10 mt20 mb20">
        <n-input placeholder="搜索标题">
          <template #prefix>
<<<<<<< HEAD
            <n-icon> <search-outline /> </n-icon>
          </template>
        </n-input>
      </div>

      <div class="tit-list" v-infinite-scroll="load" style="overflow: auto">
        <template v-for="(item, index) in titTotal" :key="index">
=======
            <n-icon>
              <search-outline></search-outline>
            </n-icon>
          </template>
        </n-input>
      </div>
      <div class="tit-list">
        <template v-for="(item, index) in 100" :key="index">
>>>>>>> 19d9080dc03cdc15109e8b5834ea7cba97041b97
          <div :class="['tit-item', 'f', 'fjb', 'pointer', { active: +item === +mouseItemId }]" @click="clickTime(item)">
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
import { ref, reactive, toRefs } from "vue";
import "swiper/swiper.scss";
import { SortFilled } from "@vicons/material";
import { Swiper, SwiperSlide } from "swiper/vue";
import SwiperCore, { Mousewheel } from "swiper";
import { defineComponent } from "vue";
SwiperCore.use([Mousewheel]);


// data数据的接口
interface dataType{
  controlledSwiper:Swiper
}



export default defineComponent({
  name: "TimeLine",
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
    SortFilled,
    Swiper,
    SwiperSlide,
    SortDialog,
  },
  setup() {
    let mouseItemId = ref<number>(1);
    let titTotal = ref<number>(50);
    const data = reactive<dataType>({ controlledSwiper: null });
    const mouseOver = (id: number) => {
    let mouseItemId = ref(1);
    let sortButton = ref<any>("sortButton");
    let offsetLeft = ref<number>(0);
    let offsetTop = ref<number>(0);
    const data = reactive({
      controlledSwiper: null,
    });

    onMounted(() => {
      nextTick(() => {
        offsetLeft.value = sortButton.value.$el.offsetLeft + 240 - 150;
        offsetTop.value = sortButton.value.$el.offsetTop + 40;
      });
    });

    const mouseOver = (id: any) => {
      mouseItemId.value = id;
    };

    const onSwiper = (swiper: Swiper) => {
      data.controlledSwiper = swiper;
    };
    const onSlideChange = (swiper: Swiper) => {
      mouseItemId.value = swiper.activeIndex + 1;
    };

<<<<<<< HEAD
    function load() {
      titTotal.value += 10;
    }

    function clickTime(item: any) {
      data.controlledSwiper.slideTo(item - 1);
=======
    function clickTime(item: any) {
      data.controlledSwiper.slideTo(item - 1);
      console.log(" data.controlledSwiper: ", data.controlledSwiper);
>>>>>>> 19d9080dc03cdc15109e8b5834ea7cba97041b97
    }

    return {
      mouseItemId,
      mouseOver,
      onSwiper,
      onSlideChange,
      clickTime,
<<<<<<< HEAD
      titTotal,
      load,
=======
      sortButton,
      offsetLeft,
      offsetTop,
      sortShow: ref<boolean>(false),
>>>>>>> 19d9080dc03cdc15109e8b5834ea7cba97041b97
      ...toRefs(data),
    };
  },
});
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
    .head {
      position: relative;
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
