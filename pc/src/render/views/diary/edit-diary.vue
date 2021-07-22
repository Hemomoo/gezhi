<template>
  <v-md-editor ref='test' v-model="text" height="100vh"></v-md-editor>
</template>

<script lang="ts">
import { reactive, ref, toRefs, watch, defineComponent } from "vue";

interface dataProps {}
export default defineComponent({
  name: "EditDiary",
  props: {},
  components: {},
  setup(props, context) {
    let text = ref<any>("");
    let test  
    const data = reactive({});
    watch(
      () => text.value,
      (val) => {
        // console.log('vue',vue);
        console.log("val: ", val);
      }
    );

    return {
      data,
      text,
    };
  },
});
</script>

<style lang="scss" scoped></style>
