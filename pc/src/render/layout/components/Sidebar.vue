<template>
  <div class="sidebar">
    <div class="f">
      <NAvatar circle @click="showModal = true" src="https://seaside-station.com/wpbin/wp-content/uploads/mori_08.jpg"></NAvatar>
      <div class="ml10">
        <p class="fwb f14">何默</p>
        <p class="f12">会员</p>
      </div>
    </div>
    <div class="slidbar-list">
      <nav class="item">
        <template v-for="(item, index) in navList" :key="index">
          <router-link :to="item.link">
            <div @click="selNav(item.link)" :class="['pointer', { active: item.link === activeLink }]">
              <i>{{ item.icon }}</i>
              <p>{{ item.tit }}</p>
            </div>
          </router-link>
        </template>
        <div></div>
        <p>日记本</p>
        <router-link to="/diary">
          <div @click="selNav('diary')" :class="['pointer', { active: 'diary' === activeLink }]">
            <!-- <i>{{ item.icon }}</i> -->
            <p>日记本</p>
          </div>
        </router-link>
      </nav>
    </div>
  </div>
  <n-modal v-model:show="showModal"  preset="card" :style="bodyStyle" title="账户">
    <Modal></Modal>
  </n-modal>
</template>

<script lang="ts">
import { NAvatar } from "naive-ui";
import { ref, defineComponent, computed } from "vue";
import { useStore } from "vuex";
import { key } from "@/store/index";
import Modal from "./Modal.vue";
import { MdClose } from "@vicons/ionicons4";

interface BodyStyle {
  width: string;
}

export default defineComponent({
  name: "Sidebar",
  data() {
    return {};
  },
  components: {
    NAvatar,
    Modal,
    MdClose,
  },
  setup() {
    // const activeLink = ref<string>('today');
    const store = useStore(key);
    const activeLink = computed(() => store.state.slidebarActiveId);
    const navList = [
      {
        icon: "",
        tit: "今日",
        link: "today",
      },
      {
        icon: "",
        tit: "时间线",
        link: "time-line",
      },
      {
        icon: "",
        tit: "日历",
        link: "calendar",
      },
      {
        icon: "",
        tit: "附件",
        link: "attachment",
      },
      {
        icon: "",
        tit: "资源库",
        link: "resouce",
      },
    ];

    //
    const selNav = (link: string) => {
      store.dispatch("slidebarActiveIdFn", link);
    };

    return {
      navList,
      activeLink,
      selNav,
      bodyStyle: {
        width: "30vw",
        minWidth:"240px"
      } as BodyStyle,
      showModal: ref<boolean>(false),
    };
  },
});
</script>

<style lange="scss" scpoed>
.sidebar {
  box-sizing: border-box;
  width: 240px;
  height: 100vh;
  padding: 0 20px;
  background: rgb(238, 238, 238);
}
.slidbar-list > div {
  display: flex;
  padding: 4px;
}
.active {
  background: gray;
}
</style>
