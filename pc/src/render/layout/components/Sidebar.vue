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
            <div @click="selNav(item.id)" :class="['pointer', { active: +item.id === +activeId }]">
              <i>{{ item.icon }}</i>
              <p>{{ item.tit }}</p>
            </div>
          </router-link>
        </template>
        <div></div>
        <p>日记本</p>
        <router-link to="/diary">
          <div @click="selNav(100)" :class="['pointer', { active: 100 === +activeId }]">
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
import { ref,defineComponent  } from "vue";

export default defineComponent( {
  name: "Sidebar",
  data() {
    return {};
  },
  components: {
    NAvatar,
  },
  setup(content,data) {
    console.log('data: ',data );
    const activeId = ref(1);
    const navList = [
      {
        icon: "",
        id: 1,
        tit: "今日",
        link: "today",
      },
      {
        icon: "",
        id: 2,
        tit: "时间线",
        link: "time-line",
      },
      {
        icon: "",
        id: 3,
        tit: "日历",
        link: "calendar",
      },
      {
        icon: "",
        id: 5,
        tit: "附近",
        link: "today",
      },
      {
        icon: "",
        id: 6,
        tit: "资源库",
        link: "today",
      },
    ];

    const selNav = (id:number) => {
      activeId.value = id;
    };

    return {
      navList,
      activeId,
      selNav,
    };
  },
})
</script>

<style lange ='scss' scpoed>
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
