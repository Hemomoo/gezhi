<template>
  <div class="time-line f">
    <div class="left pt40">
      <n-input placeholder="搜索日记">
        <template #prefix>
          <n-icon>
            <search-outline />
          </n-icon>
        </template>
      </n-input>
    </div>
    <div class="right"></div>
  </div>
</template>

<script>
import { SearchOutline } from "@vicons/ionicons5";
export default {
  name: "",
  data() {
    return {};
  },
  components: {
    SearchOutline,
  },
};
</script>

<style lang="scss" scpoed>
.time-line {
  .left {
    width: 400px;
    height: 100vh;
    padding: 40px;
    position: relative;
    &::after {
      position: absolute;
      top: -40px;
      right: 0;
      bottom: 0;
      content: "";
      width: 1px;
      background: red;
    }
  }
}
</style>
