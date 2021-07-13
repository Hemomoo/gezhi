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
    function beforeEnter():void {}

    return {
      cachedViews: [],
      beforeEnter,
    };
  },
};
</script>

<style lange ='scss' scpoed>
.main {
  width: calc(100vw - 240px);
  height: 100vh;
}
</style>
