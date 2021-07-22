<template>
  <v-md-editor v-model="text" height="100vh"></v-md-editor>
</template>

<script lang="ts">
import { reactive, ref, toRefs } from "vue";

interface dataProps {}
export default {
  name: "EditDiary",
  components: {},
  setup() {
    let text = ref<any>("");
    const data = reactive({});
    return {
      data,
      text,
    };
  },
};
</script>

<style lang="scss" scoped></style>
