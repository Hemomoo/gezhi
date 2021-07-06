<template>
  <transition name="fade" @before-enter="beforeEnter" :duration="1000">
    <keep-alive :include="cachedViews">
      <router-view />
    </keep-alive>
  </transition>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import { KeepAlive, Teleport, Transition, TransitionGroup } from "vue";
export default {
  name: "Main",
  components: {
    KeepAlive,
    Transition,
  },
  setup() {
    function beforeEnter() {
    }

    return {
      cachedViews: [],
      beforeEnter,
    };
  },
};
</script>

<style lange="scss" scpoed>
.main {
  width: 80vw;
}
</style>
