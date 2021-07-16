<template>
  <div class="time-line f">
    <div class="left">
      <div class="f fdc pt20">
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
              <n-icon> <search-outline /> </n-icon>
            </template>
          </n-input>
        </div>
      </div>
      <div class="tit-list f1" v-infinite-scroll="load" style="overflow: auto">
        <template v-for="(item, index) in titTotal" :key="index">
          <div :class="['tit-item', 'f', 'fjb', 'pointer', { active: +item === +mouseItemId }]" @click="clickTime(item, index)">
            <p>{{ item.title }}</p>
            <p>{{ index }}</p>
          </div>
        </template>
      </div>
    </div>
    <div class="right">
      <swiper :mousewheel="mousewheel" @swiper="onSwiper" @slideChangeTransitionEnd="onSlideChange">
        <template v-for="(item, index) in titTotal" :key="index">
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
import { ref, reactive, toRefs, onMounted, nextTick } from "vue";
import "swiper/swiper.scss";
import { SortFilled } from "@vicons/material";
import { Swiper, SwiperSlide } from "swiper/vue";
import SwiperCore, { Mousewheel } from "swiper";
import { defineComponent } from "vue";
import SortDialog from "./components/SortDialog.vue";
import { timeList } from "@/api/time-line";

SwiperCore.use([Mousewheel]);

// data数据的接口
interface dataType {
  controlledSwiper: Swiper;
}

interface itemInterface {
  id: string;
  display_time: string;
  title: string;
}



interface titleListInterface {
  code: number;
  data: {
    items: itemInterface[];
    total: number;
  };
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
    let mouseItemId = ref<string>('');
    let titTotal = ref<itemInterface[]>([]);
    let sortButton = ref<any>("sortButton");
    let offsetLeft = ref<number>(0);
    let offsetTop = ref<number>(0);
    const data = reactive<dataType>({ controlledSwiper: null });
    // 挂载后
    onMounted(() => {
      timeList().then((res:any) => {
        mouseItemId.value = res.items[0].id;
        titTotal.value = res.items;
      });

      nextTick(() => {
        offsetLeft.value = sortButton.value.$el.offsetLeft + 240 - 150;
        offsetTop.value = sortButton.value.$el.offsetTop + 40;
      });
    });

    const mouseOver = (id: string) => {
      mouseItemId.value = id;
    };

    const onSwiper = (swiper: Swiper) => {
      data.controlledSwiper = swiper;
    };
    const onSlideChange = (swiper: Swiper) => {
      mouseItemId.value = swiper.activeIndex + 1;
    };

    function load() {
      timeList().then((res) => {
        titTotal.value = titTotal.value.concat(res.items);
      });
    }

    function clickTime(item: any, index: number) {
      mouseItemId.value = item.id;
      data.controlledSwiper.slideTo(+index - 1);
    }

    return {
      mouseItemId,
      mouseOver,
      onSwiper,
      onSlideChange,
      clickTime,
      titTotal,
      load,
      sortButton,
      offsetLeft,
      offsetTop,
      sortShow: ref<boolean>(false),
      ...toRefs(data),
    };
  },
});
</script>

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
      height: calc(100vh - 117px);
      overflow: scroll;
      padding: 0 10px;
      width: 240px;
      box-sizing: border-box;
      .tit-item {
        padding: 6px 4px;
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
