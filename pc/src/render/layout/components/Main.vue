<template>
  <section class="main">
    <router-view />
  </section>
</template>

<script lang='ts'>
export default {
  name: "Main",
  data() {
    return {};
  },
  components: {},
};
</script>

<style lange ='scss' scpoed>


.main {
  width: calc(100vw - 240px);
  height: 100vh;
}
</style>
