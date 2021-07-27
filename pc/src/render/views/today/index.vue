<template>
  <div class="today">
    <div class="hearder" id="test">
      <p class="fwb f26 tal">2021年12月3日</p>
      <p class="tal" @click="test">今天过得怎么样</p>
      <p>{{ fullName }}</p>
    </div>
    <section class="content f fjb">
      <div class="left">
        <!-- 日期 -->
        <div class="date">
          <div></div>
          <div></div>
        </div>
      </div>
      <div class="right">
        <Statistics></Statistics>
        <Statistics></Statistics>
      </div>
    </section>
  </div>
</template>

<script lang="ts">
import Statistics from "./components/Statistics.vue";
import _ from "lodash";
export default {
  name: "Today",
  data() {
    return {
      firstName: "邓",
      lastName: "亮",
    };
  },
  components: {
    Statistics,
  },
  computed: {},
  beforeCreate() {
    // console.log(">>>>>>beforeCreate", this);
    // console.log(document.getElementById("test"));
  },
  created() {
    // console.log(">>>>>>created", this);
    // console.log(document.getElementById("test"));
    // 用 Lodash 的防抖函数
    // this.debouncedClick = _.debounce(this.click, 500)
  },
  mounted() {
    console.log(">>>>>>mounted", this);
    // console.log(document.getElementById("test"));
  },
  methods: {},

  setup() {},
};
</script>

<style lang="scss" scpoed>
.today {
  width: 80%;
  margin: 0 auto;
  .right {
    width: 30%;
  }
}
</style>
