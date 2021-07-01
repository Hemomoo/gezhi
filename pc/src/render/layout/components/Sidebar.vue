<template>
  <div class="sidebar">
    <div class="f">
      <NAvatar circle></NAvatar>
      <div>
        <p>何默</p>
        <p>会员</p>
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
</template>

<script lang="ts">
import { NAvatar } from "naive-ui";
import { ref, defineComponent, computed } from "vue";
import { useStore } from "vuex";
import { key } from '@/store/index'


export default defineComponent({
  name: "Sidebar",
  data() {
    return {};
  },
  components: {
    NAvatar,
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
