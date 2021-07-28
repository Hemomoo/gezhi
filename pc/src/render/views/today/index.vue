<template>
  <div class="today">
    <div class="hearder" id="test">
      <p class="fwb f26 tal">2021年12月3日</p>
      <p class="tal">今天过得怎么样</p>
    </div>
    <section class="content f fjb">
      <div class="left">
        <!-- 日期 -->
        <div class="date">
          <Paster v-model:value="test">
            <div>可是看到{{ test }}</div>
            <template #header>
              <div>年获得丰厚</div>
            </template>
          </Paster>
          <div></div>
          <div></div>
        </div>
      </div>
      <div class="right">
        <Statistics></Statistics>
      </div>
    </section>
  </div>
</template>

<script lang="ts">
import Statistics from "./components/Statistics.vue";
import Paster from "./components/Paster.vue";
import _ from "lodash";
import { reactive, toRefs, ref, computed, watch, h } from "vue";
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
    Paster,
  },
  provide: {
    user: "John Doe",
  },
  computed: {},
  render(h: any) {
    return h("div", {
      onClick: ($event: any) => console.log("clicked", $event.target),
    });
  },
  setup() {
    let test = ref<string>("test");
    watch(test, (val) => {
      console.log("val:>>>>> ", val);
    });

    return {
      test,
    };
  },
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
